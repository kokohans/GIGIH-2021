require 'mysql2'
require_relative './models/item'
require_relative './models/category'

def create_db_client
    client = Mysql2::Client.new(
      :host => "localhost",
      :username => ENV['DB_UID'],
      :password => ENV['DB_PASSWORD'],
      :database => ENV['DB_NAME']
      )
    client
end

def get_all_items
    client = create_db_client
    qry_items = client.query("SELECT items.id as 'item_id', items.name as 'item_name', items.price, categories.name as 'category_name' FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id LEFT JOIN categories ON item_categories.category_id = categories.id")
    items = Array.new
    qry_items.each do | data |
        item = Item.new(data['item_id'], data['item_name'], data['price'], data['category_name'])
        items.push(item)
    end
    items
end

def get_item_by_id(id)
    client = create_db_client
    qry_item = client.query("SELECT items.id as 'item_id', items.name as 'item_name', items.price, categories.name as 'category_name' FROM items LEFT JOIN item_categories ON items.id = item_categories.item_id LEFT JOIN categories ON item_categories.category_id = categories.id WHERE items.id = #{id}")
    if qry_item.count > 0
        return item = Item.new(qry_item.first['item_id'], qry_item.first['item_name'], qry_item.first['price'], qry_item.first['category_name'])
    else 
        nil
    end
end

def get_all_categories
    client = create_db_client
    qry_category = client.query("SELECT id, name FROM categories")
    categories = Array.new
    qry_category.each do | data |
        category = Category.new(data['id'], data['name'])
        categories.push(category)
    end
    categories
end

def update_item(id,name,price,category)
    client = create_db_client
    qry_category = client.query("UPDATE items SET name='#{name}', price=#{price} WHERE id=#{id}")
    qry_category = client.query("UPDATE item_categories SET category_id=#{category} WHERE item_id=#{id}")
end

def delete_item(id)
    client = create_db_client
    qry_delete = client.query("DELETE FROM item_categories WHERE item_id=#{id}")
    qry_delete = client.query("DELETE FROM items WHERE id=#{id}")
end

def insert_item(name, price, category)
    client = create_db_client

    qry_insert = client.query("INSERT INTO items (name, price) VALUES ('#{name}', #{price})")
    last_id = client.last_id

    qry_insert = client.query("INSERT INTO item_categories VALUES (#{last_id}, #{category})")
end