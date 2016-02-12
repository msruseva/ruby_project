get '/parent' do
  if session[:id] == nil
    redirect '/login'
  else
    @parents = Parent.exists?(user_id: session[:id])
    @user = User.find_by_email(params[:email])
    unless @parents
      @parent = Parent.new
      erb :parent
    else
      redirect '/child/new'
    end
  end
end

post '/parents' do
  @parent = Parent.new(params[:parent])
  @parent.user_id = session[:id]
  if @parent.valid?
    @parent.save
    session[:flash] = "Вие успешно добавихте вашите данни."
    redirect '/child/new'
  else
    session[:flash] = "Вашето ЕГН има по-малко от 10 цифри. Моля въведете валидно ЕГН."
    redirect '/parent'
  end
end
