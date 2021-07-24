require 'sinatra'
require_relative './controllers/order_controller'
require_relative './controllers/item_controller'
require_relative './controllers/category_controller'

get '/' do
    controllers = OrderController.new
    controllers.list_orders
end

get '/order/new' do
    controllers = OrderController.new
    controllers.create_order_form
end

post '/order/' do
    controllers = OrderController.new
    controllers.create_order(params)
end

get '/items/' do
    controllers = ItemController.new
    controllers.list_items
end

get '/items/:id/' do
    controllers = ItemController.new
    controllers.show_items_by_id(params)
end

get '/items/:id/delete' do
    controllers = ItemController.new
    controllers.delete_item(params)
    redirect '/items/'
end

post '/items/:id/delete' do
    controllers = ItemController.new
    controllers.delete_item(params)
    redirect '/items/'
end

post '/items/:id/edit' do
    controllers = ItemController.new
    controllers.update_item(params)
    redirect "/items/#{params['id']}/"
end

get '/items/:id/edit' do
    controllers = ItemController.new
    controllers.update_item_form(params)
end

get '/items/new' do
    controllers = ItemController.new
    controllers.new_item_form
end

post '/items/' do
    controllers = ItemController.new
    puts params
    controllers.new_item(params)
    redirect '/'
end

get '/categories/' do
    controllers = CategoryController.new
    controllers.list_categories
end

get '/categories/new' do
    controllers = CategoryController.new
    controllers.create_new_category_form
end

post '/categories/' do
    controllers = CategoryController.new
    controllers.new_category(params)
    redirect '/categories/'
end

get '/categories/:category_id/items' do
    controllers = CategoryController.new
    controllers.list_items_by_category(params)
end

get '/categories/:category_id/items/new' do
    controllers = CategoryController.new
    controllers.add_new_item_to_category_form(params)
end

get '/categories/:category_id/items/new/:item_id' do
    controllers = CategoryController.new
    controllers.add_new_item_to_category(params)
    redirect "/categories/#{params['category_id']}/items"
end

get '/categories/:category_id/delete' do
    controllers = CategoryController.new
    controllers.delete_category(params)
    redirect '/categories/'
end

get '/categories/:category_id/edit' do
    controllers = CategoryController.new
    controllers.edit_category_form(params)
end

post '/categories/:category_id/edit' do
    controllers = CategoryController.new
    controllers.edit_category(params)
    redirect '/categories/'
end
