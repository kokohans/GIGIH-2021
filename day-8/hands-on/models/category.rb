require_relative '../db/mysql_connector'

class Category
    attr_accessor :id, :name
    def initialize(name, id = nil)
        @id = id
        @name = name
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