require 'mysql2'
require_relative './item'
require_relative './category'

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
    qry_items = client.query("SELECT * FROM items")
    items = Array.new
    qry_items.each do | data |
        item = Item.new(data['id'], data['name'], data['price'])
        items.push(item)
    end
    items
end

def get_all_categories
    client = create_db_client
    qry_category = client.query("SELECT * FROM categories")
    categories = Array.new
    qry_category.each do | data |
        category = Category.new(data['id'], data['name'])
        categories.push(category)
    end
    categories
end

def get_all_items_categories
    client = create_db_client
    raw_query = client.query("select items.id as 'item_id', items.name as 'item_name', items.price, categories.name as 'category_name' from items left join item_categories on items.id = item_categories.item_id left join categories on item_categories.category_id = categories.id")
    items = Array.new
    raw_query.each do | data |
        item = Item.new(data['item_id'], data['item_name'], data['price'], data['category_name'])
        items.push(item)
    end
    items
end

def get_items_by_price(limit_price)
    client = create_db_client
    items = client.query("SELECT * FROM items WHERE price < #{limit_price}")
end

def get_item_id(name)
    client = create_db_client
    item = client.query("SELECT id FROM items WHERE name = '#{name}'")
end

def insert_item(name, price)
    client = create_db_client
    client.query("INSERT INTO items (name, price) VALUES ('#{name}', #{price})")
end

def insert_item_categories(name, price, category_id)
    client = create_db_client
    client.query("INSERT INTO items (name, price) VALUES ('#{name}', #{price})")
    item_id = client.last_id
    client.query("INSERT INTO item_categories VALUES (#{item_id}, #{category_id})")
end


# puts "================= items =============="
# get_all_items.each do | a |
#     puts a
# end
# puts "======================================"

# puts "================= categories =============="
# get_all_categories.each do | category |
#     puts category
# end
# puts "==========================================="

# get_all_items_categories.each do | item_detail |
#     puts item_detail
# end

# puts "Input price? "
# limit_price = gets.chomp

# items = get_items_by_price(limit_price)

# items.each do | item |
#     puts item
# end