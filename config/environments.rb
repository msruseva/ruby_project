configure :development do
  set :show_exceptions, true
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/development.sqlite3',
    pool: '5',
    timeout: '5000'
  )

  Pony.options = {
    :from => 'noreply@example.com',
    :via => :smtp,
    :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => 'youremail@example.com',
      :password             => 'yourpassword',
      :authentication       => :plain,
      :domain               => 'localhost.localdomain'
    }
  }
end

configure :test do
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/test.sqlite3',
    pool: '5',
    timeout: '5000'
  )
end
