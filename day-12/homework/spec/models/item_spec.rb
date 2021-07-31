require_relative '../../models/category'
require_relative '../../models/item'
require 'mysql2'

RSpec.describe Item do
    describe "inter-class" do
        describe "save" do
            it "should return new id" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "INSERT INTO items (name, price) VALUES ('nasi goreng', 20000)"

                allow(stub_client).to receive(:last_id).and_return(rand(10))
                expect(stub_client).to receive(:query).with(stub_query)

                item = Item.new("nasi goreng", 20000)

                id = item.save

                expect(id).to be_an(Integer)
            end
        end

        describe "update" do
            it "should return 1" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "UPDATE items SET name='nasi-goreng-gila', price=25000 WHERE id=1"
                
                allow(stub_client).to receive(:affected_rows).and_return(1)
                expect(stub_client).to receive(:query).with(stub_query)

                allow(Item).to receive(:get_item_by_id).with(1).and_return(Item.new("nasi-goreng",20000,nil, 1))

                old_item = Item.get_item_by_id(1)
                old_item.name = "nasi-goreng-gila"
                old_item.price = 25000

                affected_row = old_item.update

                expect(affected_row).to eq(1)
            end
        end

        describe "delete" do
            it "should return 1" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "DELETE FROM items WHERE id=1"
                
                allow(stub_client).to receive(:affected_rows).and_return(1)
                expect(stub_client).to receive(:query).with(stub_query)
                allow(Item).to receive(:get_item_by_id).with(1).and_return(Item.new("nasi-goreng",20000,nil, 1))
    
                old_item = Item.get_item_by_id(1)
    
                affected_row = old_item.delete
    
                expect(affected_row).to eq(1)
            end
        end

        describe "find category" do
            it "should return array of Category" do
                allow(Category).to receive(:get_categories_by_item_id).with(1).and_return([
                    Category.new("Main course", 1),
                    Category.new("Western", 2)
                ])
                allow(Item).to receive(:get_item_by_id).with(1).and_return(Item.new("nasi-goreng",20000,nil, 1))
                item = Item.get_item_by_id(1)

                item.find_categories

                expect(item.categories).to include(a_kind_of(Category))
            end
        end

        describe "get all items" do
            it "should return array of item" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "SELECT DISTINCT items.id as 'item_id', items.name as 'item_name', items.price FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id"

                expect(stub_client).to receive(:query).with(stub_query)
                allow(stub_client).to receive(:query).and_return([
                    {"item_name" => "makanan-satu", "price" => 20000, "item_id" => 1},
                    {"item_name" => "makanan-dua", "price" => 25000, "item_id" => 2}
                ])

                items = Item.get_all_items
                
                expect(items).to include(a_kind_of(Item))
            end
        end

        describe "get item by id" do
            it "should return 1 item" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "SELECT items.id as 'item_id', items.name as 'item_name', items.price, categories.id as 'category_id' FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id LEFT JOIN categories ON item_categories.category_id = categories.id WHERE items.id = 1"

                expect(stub_client).to receive(:query).with(stub_query)
                allow(stub_client).to receive(:query).and_return([
                    {"item_name" => "makanan-satu", "price" => 20000, "item_id" => 1}
                ])

                item = Item.get_item_by_id(1)
                
                expect(item).to be_an(Item)
            end
        end

        describe "get item by id" do
            it "should return 1 item" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "SELECT items.id as 'item_id', items.name as 'item_name', items.price, item_categories.category_id FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id WHERE category_id=1"

                expect(stub_client).to receive(:query).with(stub_query)
                allow(stub_client).to receive(:query).and_return([
                    {"item_name" => "makanan-satu", "price" => 20000, "category_id" => 1, "item_id" => 1}
                ])

                item = Item.get_items_by_categories(1)
                
                expect(item).to include(a_kind_of(Item))
            end
        end
    end

    describe "inner-class" do
        it 'should return true' do
            item = Item.new("koka-kola", 20000)
            expect(item.valid?).to eq(true)
        end
        it 'should return false' do
            item = Item.new(nil, nil)
            expect(item.valid?).to eq(false)
        end
    end

    
end