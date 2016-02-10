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


get '/parent' do
  if session[:id] == nil
    redirect '/login'
  else
    @parents = Parent.exists?(user_id: session[:id])

    unless @parents
      @parent = Parent.new
      erb :parent
    else
      redirect '/child/new'
    end
  end
end

get '/child/new' do
  if session[:id] == nil
    redirect '/login'
  else
    @child = Child.new
    erb :child
  end
end

get '/parents_children' do
  @children = Child.where(children: {user_id: session[:id]})
  erb :parents_children
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
  @user.save
  Pony.mail(
    :to => @user.email,
    :subject => "Нова парола",
    :body => "Новата ви парола е: #{random_password}."
  )
  "Вашата нова парола беше изпратена на подадената от вас Е-поща."
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

post '/parents' do
  @parent = Parent.new(params[:parent])
  @parent.user_id = session[:id]
  if @parent.valid?
    @parent.save
    session[:flash] = "Вие успешно добавихте вашите данни."
    redirect '/child/new'
  end
end

post '/children' do
  @parent = Parent.where(parents: {user_id: session[:id]}).first
  @child = Child.new(params[:child])
  @child.user_id = session[:id]
  @child.parent = @parent
  if @parent.valid? and @child.valid?
    @child.save
    session[:flash] = "Вие успешно добавихте данните на вашия кандидат."
    redirect '/parents_children'
  else
    erb :child
  end
end

delete '/child/:id' do
  @child = Child.find(params[:id])
  @child.destroy
  redirect '/parents_children'
end

delete '/application/:id' do
  @application = Application.find(params[:id])
  @application.destroy
  redirect '/applications'
end

get '/child/:id' do
  @child = Child.find(params[:id])
  erb :edit
end

put '/child/:id' do
  @child = Child.find(params[:id])
  @child.egn = params[:child][:egn]
  @child.first_name = params[:child][:first_name]
  @child.second_name = params[:child][:second_name]
  @child.last_name = params[:child][:last_name]
  @child.save
  redirect '/parents_children'
end
