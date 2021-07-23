require_relative '../db/mysql_connector'

class Item
    attr_accessor :id, :name, :price, :category_id

    def initialize(name, price, category_id = nil, id = nil)
        @id = id
        @name = name
        @price = price
        @category_id = category_id
    end

    def save
        return false unless valid?
        client = create_db_client
        client.query("INSERT INTO items (name, price) VALUES ('#{@name}', #{@price})")
        client.last_id
    end

    def self.get_all_items
        client = create_db_client
        qry_items = client.query("SELECT items.id as 'item_id', items.name as 'item_name', items.price, categories.name as 'category_name' FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id LEFT JOIN categories ON item_categories.category_id = categories.id")
        items = Array.new
        qry_items.each do | data |
            item = Item.new(data['item_name'], data['price'], data['category_name'], data['item_id'])
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