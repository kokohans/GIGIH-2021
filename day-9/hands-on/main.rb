require 'sinatra'
require_relative './controllers/order_controller'
require_relative './controllers/item_controller'

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
    controllers.new_item(params)
    redirect '/'
end