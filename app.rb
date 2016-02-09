require 'sinatra'
require 'sinatra/activerecord'
require 'pony'
require './config/environments' #database configuration
Dir["./models/*.rb"].each {|file| require file }

enable :sessions unless test?

get '/' do
  session[:id] = nil
  erb :index
end

get '/login' do
  erb :login
end

get '/sign_in' do
  erb :sign_in
end

get '/forgotten_password' do
  erb :forgotten_password
end

get '/logout' do
  session[:id] = nil
  redirect '/'
end

get '/home_page' do
  erb :home_page
end

get '/rules' do
  erb :rules
end

get '/apply' do
  if session[:id] == nil
    redirect '/login'
  else
    @parent = Parent.new
    @child = Child.new
    erb :apply
  end
end

get '/applications' do
  @applications = Application.includes(:child)
    .where(children: {user_id: session[:id]})
    .order("children.first_name, children.last_name, applications.created_at")
  erb :applications
end

get '/applications/new' do
  @user = User.find(session[:id])
  @application = Application.new
  erb :application
end

post '/applications' do
  @user = User.find(session[:id])
  @application = Application.new(params[:application])
  if @application.save
    session[:flash] = "Кандидатурата беше добавена успешно"
    redirect '/applications'
  else
    erb :application
  end
end

post '/sign_in/submit' do
  @user = User.new(params[:user])
  if @user.save
    redirect '/login'
  else
    "Възникна грешка при опита за регистриране в системата. Опитайте отново."
  end
end

post '/login/submit' do
  @user = User.find_by_email(params[:email])
  if @user and @user.password == params[:password]
    session[:id] = @user.id
    session[:name] = @user.name
    redirect '/home_page'
  else
    "Невалидеин Е-поща или парола."
  end
end

post '/forgotten_password' do
  @user = User.find_by_email(params[:email])
  random_password = Array.new(10).map { (65 + rand(58)).chr}.join
  @user.password = random_password
  @user.save!
  Pony.mail(
    :to => @user.email,
    :subject => "Нова парола",
    :body => "Новата ви парола е: #{random_password}. При удобен за вас момент я сменете за повишаване на вашата сигурност."
  )
  "Вашата нова парола беше изпратена на подадената от вас Е-поща."
end

post '/apply' do
  @parent = Parent.new(params[:parent])
  @parent.user_id = session[:id]
  @child = Child.new(params[:child])
  @child.user_id = session[:id]
  @child.parent = @parent
  if @parent.valid? and @child.valid?
    @parent.save
    @child.save
    "Вашата регистрация беше извършена успешно."
  else
    erb :apply
  end
end

