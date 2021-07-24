require_relative '../db/mysql_connector'
require_relative './category'

class Item
    attr_accessor :id, :name, :price, :categories

    def initialize(name, price, categories = [], id = nil)
        @id = id
        @name = name
        @price = price
        @categories = categories
    end

    def save
        return false unless valid?
        client = create_db_client
        client.query("INSERT INTO items (name, price) VALUES ('#{@name}', #{@price})")
        client.last_id
    end

    def self.get_all_items
        client = create_db_client
        qry_items = client.query("SELECT DISTINCT items.id as 'item_id', items.name as 'item_name', items.price FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id")
        items = Array.new
        qry_items.each do | data |
            item = Item.new(data['item_name'], data['price'], [], data['item_id'])
            items.push(item)
        end
        items
    end

    def self.get_item_by_id(id)
        client = create_db_client
        qry_item = client.query("SELECT items.id as 'item_id', items.name as 'item_name', items.price, categories.id as 'category_id' FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id LEFT JOIN categories ON item_categories.category_id = categories.id WHERE items.id = #{id}")
        if qry_item.count > 0
            return item = Item.new(qry_item.first['item_name'], qry_item.first['price'], qry_item.first['category_id'], qry_item.first['item_id'])
        else 
            nil
        end
    end
    
    def self.get_items_by_categories(category_id)
        client = create_db_client
        qry = client.query("SELECT items.id as 'item_id', items.name as 'item_name', items.price, item_categories.category_id FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id WHERE category_id=#{category_id}")
        items = Array.new
        qry.each do | data |
            item = Item.new(data['item_name'], data['price'], data['category_id'], data['item_id'])
            items.push(item)
        end
        items
    end

    def find_categories
        @categories = Category.get_categories_by_item_id(@id)
    end

    def delete
        client = create_db_client
        qry_delete = client.query("DELETE FROM items WHERE id=#{@id}")
    end

    def update
        client = create_db_client
        qry_category = client.query("UPDATE items SET name='#{@name}', price=#{@price} WHERE id=#{@id}")
    end

    def valid?
        return false if @name.nil?
        return false if @price.nil?
        true
    end
end

# class item
#     attr_accessor :id, :name, :price, :reference_no

#     def initialize(id, name, price, order)
#         @id = id
#         @name = name
#         @price = price
#         @order = order
#     end

#     def self.find_by_order(order)
#         client = create_db_client
#         res = client.query("SELECT * FROM items WHERE reference_no='#{order}'")
#         items = Array.new
#         res.each do | data |
#             item = Item.new(data['id'], data['name'], data['price'], data['order'])
#             items.push(item)
#         end
#         items
#     end
# end
