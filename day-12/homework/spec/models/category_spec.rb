require_relative '../../models/category'
require_relative '../../models/item'
require 'mysql2'

RSpec.describe Category do
    describe "inter-class" do
        describe "get all categories" do
            it "should return array of category" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "SELECT id, name FROM categories"

                expect(stub_client).to receive(:query).with(stub_query)
                allow(stub_client).to receive(:query).and_return([
                    name: "jenis makanan satu", id: 1,
                    name: "jenis makanan dua", id: 2
                ])

                categories = Category.get_all_categories
                
                expect(categories).to include(a_kind_of(Category))

            end
            
        end

        describe "get category by id" do
            it "should return 1 category" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "SELECT id, name FROM categories WHERE id=1"

                expect(stub_client).to receive(:query).with(stub_query)
                allow(stub_client).to receive(:query).and_return([
                    {"name" => "bukan makanan", "id" => 1}
                ])

                categories = Category.get_category_by_id(1)
                
                expect(categories).to be_an(Category)
            end
        end

        describe "get categories by item id" do
            it "should return categories" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "SELECT categories.id, categories.name FROM categories JOIN item_categories ON categories.id = item_categories.category_id WHERE item_categories.item_id=1"

                expect(stub_client).to receive(:query).with(stub_query)
                allow(stub_client).to receive(:query).and_return([
                    name: "jenis makanan satu", id: 1,
                    name: "jenis makanan dua", id: 2
                ])

                categories = Category.get_categories_by_item_id(1)

                expect(categories).to include(a_kind_of(Category))
            end
        end

        describe "add item" do
            it "should return 1" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "INSERT INTO item_categories VALUES(1, 1)"

                allow(stub_client).to receive(:affected_rows).and_return(1)
                expect(stub_client).to receive(:query).with(stub_query)

                allow(Category).to receive(:get_category_by_id).with(1).and_return(Category.new("makanan", 1))
                category = Category.get_category_by_id(1)

                result = category.add_item(1)

                expect(result).to eq(1)
            end
        end

        describe "find item" do
            it "should return array of Items" do
                allow(Item).to receive(:get_items_by_categories).with(2).and_return([
                    Item.new("nasi goreng", 20000, 2, 1),
                    Item.new("nasi bungkus", 25000, 2, 2)
                ])
                allow(Category).to receive(:get_category_by_id).with(2).and_return(Category.new("makanan", 2))
                category = Category.get_category_by_id(2)

                category.find_items

                expect(category.items).to include(a_kind_of(Item))
            end
        end

        describe "delete" do
            it "should return 1" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "DELETE FROM categories WHERE id=1"
                
                allow(stub_client).to receive(:affected_rows).and_return(1)
                expect(stub_client).to receive(:query).with(stub_query)
                allow(Category).to receive(:get_category_by_id).with(1).and_return(Category.new("makanan", 1))

                old_category = Category.get_category_by_id(1)

                affected_row = old_category.delete

                expect(affected_row).to eq(1)
            end
        end

        describe "update" do
            it "should return 1" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "UPDATE categories SET name='makanan-aja' WHERE id=1"
                
                allow(stub_client).to receive(:affected_rows).and_return(1)
                expect(stub_client).to receive(:query).with(stub_query)

                stub_category = double
                allow(Category).to receive(:get_category_by_id).with(1).and_return(Category.new("makanan", 1))

                old_category = Category.get_category_by_id(1)
                old_category.name = "makanan-aja"

                affected_row = old_category.update

                expect(affected_row).to eq(1)
            end
        end

        describe "save" do
            it "should return new id" do
                stub_client = double
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                stub_query = "INSERT INTO categories (name) VALUES ('bukan makanan')"

                allow(stub_client).to receive(:last_id).and_return(rand(10))
                expect(stub_client).to receive(:query).with(stub_query)

                category = Category.new("bukan makanan")

                id = category.save

                expect(id).to be_an(Integer)
            end
        end
    end

    describe "inner-class" do
        describe "is valid input" do
            it 'should return true' do
                category = Category.new("bukan makanan")
                expect(category.valid?).to eq(true)
            end
            it 'should return false' do
                category = Category.new(nil)
                expect(category.valid?).to eq(false)
            end
        end
    end
end