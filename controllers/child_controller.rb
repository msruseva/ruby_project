get '/child/new' do
  if session[:id] == nil
    redirect '/login'
  else
    @child = Child.new
      erb :child
    end
end

get '/children' do
  if session[:id] == nil
    redirect '/login'
  else
    @children = Child.where(children: {user_id: session[:id]})
    erb :children
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
    redirect '/children'
  else
    erb :child
  end
end

get '/child/:id' do
  if session[:id] == nil
    redirect '/login'
  else
    @child = Child.find(params[:id])
    erb :edit
  end
end

put '/child/:id' do
  @child = Child.find(params[:id])
  @child.egn = params[:child][:egn]
  @child.first_name = params[:child][:first_name]
  @child.second_name = params[:child][:second_name]
  @child.last_name = params[:child][:last_name]
  @child.save
  redirect '/children'
end

delete '/child/:id' do
  @child = Child.find(params[:id])
  @child.destroy
  redirect '/children'
end
