require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza_order')
also_reload('./models/*')
# enables sinatra to re-acquire changed models without us having to stop/start/also_reload

# index route all pizzas
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  p @orders
  erb(:index)
end

# Be careful on ordering - put placeholders after any specific commands.  In example below if /pizza-orders/:id' cam first then it would ne executed with 'new' treated as the :id input :
get '/pizza-orders/new' do
  erb(:new)
end

# show - show one pizza
get '/pizza-orders/:id' do
  @order = PizzaOrder.find(params[:id])
  erb(:show)
end

get '/pizza-orders/:id/edit' do
    @order = PizzaOrder.find(params[:id])
    erb(:edit)
end

# create - make a pizza_order
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

post '/pizza-orders/:id/update' do
  @order = PizzaOrder.new(params)
  @order.update()
  redirect "/pizza-orders"
end


post '/pizza-orders/:id/delete' do
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  redirect '/pizza-orders'
end
