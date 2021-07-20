require 'sinatra'
require_relative './db'

get '/' do
    items = get_all_items
    erb :index, locals:{
        items: items
    }
end

get '/items/' do
    content_type :json
    items = get_all_items
    items_json = items.map do | item |
        {
            id: item.id,
            name: item.name,
            price: item.price.to_s,
            category: item.category
        }
    end
    items_json.to_json
end

get '/items/new' do
    categories = get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/create' do
    name = params['name']
    price = params['price']
    id = params['category']
    insert_item_categories(name, price, id)
    redirect '/'
end

get '/items/:id/' do
    id = params['id']
    item = get_item_by_id(id)
    if item
        erb :item, locals: {
            item: item
        }
    else
        404
    end
end

get '/items/:id/edit' do
    id = params['id']
    item = get_item_by_id(id)
    if item
        categories = get_all_categories
        erb :edit, locals: {
            item: item,
            categories: categories
        }
    else
        404
    end
end

post '/items/:id/edit' do
    item_id = params['id']
    name = params['name']
    price = params['price']
    id = params['category']
    puts "#{id}, #{name}, #{price}"
    update_item(item_id, name, price, id)
    redirect "/items/#{item_id}/"
end

post '/items/:id/delete' do
    id = params['id']
    delete_item(id)
    redirect '/'
end

post '/items/' do
    name = params['name']
    price = params['price']
    id = params['category']
    insert_item(name, price, id)
    redirect '/'
end
