get '/classification' do
  if session[:id] == nil
    redirect '/login'
  else
    Classification.run
    @applications_confirmed = Application.includes(:child, :school).where(applications: {classifing: true} ).order("applications.school_id, applications.num_classifing")
    @applications_rejected = Application.includes(:child, :school).where(applications: {classifing: false} ).order("applications.school_id, applications.num_classifing")
    erb :classification
  end
end
