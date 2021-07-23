require 'sinatra'
require_relative './models/order'
require_relative './models/item'
require_relative './models/category'
require_relative './models/item_category'

get '/' do
    orders = Order.get_all_orders
    erb :index, locals:{
        orders: orders
    }
end

get '/items/' do
    items = Item.get_all_items
    erb :items, locals:{
        items: items
    }
end

get '/items/:id/' do
    item = Item.get_item_by_id(params['id'])
    category = Category.get_category_by_id(item.category_id)
    erb :item_detail, locals:{
        item: item,
        category: category
    }
end

post '/items/:id/delete' do
    id = params['id']
    item = Item.get_item_by_id(id)
    item_categories = Item_category.get_categories_by_item_id(item.id)
    item_categories.delete
    item.delete
    redirect '/'
end

post '/items/:id/edit' do
    item_id = params['id']
    name = params['name']
    price = params['price']
    category_id = params['category']
    old_item = Item.get_item_by_id(item_id)
    old_item_category = Item_category.get_categories_by_item_id(item_id)
    old_item_category.category_id = category_id
    old_item.name = name
    old_item.price = price
    old_item.update
    old_item_category.update
    redirect "/items/#{item_id}/"
end

get '/items/:id/edit' do
    item = Item.get_item_by_id(params['id'])
    categories = Category.get_all_categories
    if item
        category = Category.get_category_by_id(item.category_id)
        erb :edit, locals:{
            item: item,
            category: category,
            categories: categories
        }
    else
        404
    end
end

get '/items/new' do
    categories = Category.get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/' do
    name = params['name']
    price = params['price']
    category_id = params['category']
    new_item = Item.new(name, price)
    new_id = new_item.save
    puts new_id
    new_item_category = Item_category.new(new_id, category_id)
    new_item_category.save
    redirect '/'
end