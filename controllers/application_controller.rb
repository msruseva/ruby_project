get '/applications' do
  if session[:id] == nil
    redirect '/login'
  else
    @applications = Application.includes(:child)
      .where(children: {user_id: session[:id]})
      .order("children.first_name, children.last_name, applications.created_at")
    erb :applications
  end
end

get '/applications/new' do
  if session[:id] == nil
    redirect '/login'
  else
    @user = User.find(session[:id])
    @application = Application.new
    erb :application
  end
end

post '/applications' do
  @user = User.find(session[:id])
  @application = Application.new(params[:application])
  @child_id = params[:application][:child_id]
  @app_num = params[:application][:num]

  @new_num = Application.where("applications.child_id = ? AND applications.num = ?", @child_id, @app_num)

  @new_num.each do |app|
    app.destroy
  end
  if @application.save
    session[:flash] = "Кандидатурата беше добавена успешно"
    redirect '/applications'
  else
    erb :application
  end
end

delete '/application/:id' do
  @application = Application.find(params[:id])
  @application.destroy
  redirect '/applications'
end
