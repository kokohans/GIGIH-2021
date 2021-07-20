require 'sinatra'
require './db_connector'

get '/' do
    items = get_all_items_categories
    erb :index, locals:{
        items: items
    }
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