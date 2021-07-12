require 'sinatra'
require 'json'

items = {}

get '/message/:name' do
    name = params['name']
    color = params['color'] ? params['color'] : 'DodgerBlue'
    #"<h1 style=\"background-color:#{color};\">Hello #{name}!</h1>"
    erb  :message, locals: {
        color: color,
        name: name
    }
end

post '/message/' do
    push = JSON.parse(request.body.read)
    puts "I got some JSON: #{push.inspect}"
end

get '/message/' do
    "Hello siapapun anda"
end

get '/' do
    'Hello world'
end

post '/login' do
    puts params
    if params['username'] == 'admin' && params['password'] == 'admin'
        return 'welcome admin'
    else
        redirect '/login'
    end
end

get '/login' do
    erb :login
end

get '/items/' do
    erb :items
end

get '/items' do
    "#{items}"
end

post '/items/' do
    item = params['item']
    price = params['price']
    items[item] = price

    redirect '/items'
end