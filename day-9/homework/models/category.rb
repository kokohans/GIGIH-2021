require_relative '../db/mysql_connector'
require_relative './item'

class Category
    attr_accessor :id, :name, :items
    def initialize(name, id = nil, items = [])
        @id = id
        @name = name
        @items = items
    end

    def self.get_all_categories
        client = create_db_client
        qry_category = client.query("SELECT id, name FROM categories")
        categories = Array.new
        qry_category.each do | data |
            category = Category.new(data['name'], data['id'])
            categories.push(category)
        end
        categories
    end
    
    def self.get_category_by_id(id)
        client = create_db_client
        qry_item = client.query("SELECT id, name FROM categories WHERE id=#{id}")
        if qry_item.count > 0
            return item = Category.new(qry_item.first['name'], qry_item.first['id'],)
        else 
            nil
        end
    end

    def self.get_categories_by_item_id(item_id)
        client = create_db_client
        qry = client.query("SELECT categories.id, categories.name FROM categories JOIN item_categories ON categories.id = item_categories.category_id WHERE item_categories.item_id=#{item_id}")
        if qry.count > 0
            categories = Array.new
            qry.each do | data |
                category = Category.new(data['name'],data['id'])
                categories.push(category)
            end
            return categories
        else
            nil
        end
    end

    def add_item(item_id)
        client = create_db_client
        qry = client.query("INSERT INTO item_categories VALUES(#{item_id}, #{@id})")
    end

    def find_items
        @items = Item.get_items_by_categories(@id)
    end

    def delete
        client = create_db_client
        qry_delete = client.query("DELETE FROM categories WHERE id=#{@id}")
    end

    def update
        client = create_db_client
        qry_category = client.query("UPDATE categories SET name='#{@name}' WHERE id=#{@id}")
    end

    def save
        return false unless valid?
        client = create_db_client
        client.query("INSERT INTO categories (name) VALUES ('#{@name}')")
        @id = client.last_id
    end

    def valid?
        return false if @name.nil?
        true
    end
end