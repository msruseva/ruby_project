namespace :classification do
  desc "Run the classification algorithm"
  task :run do
    Classification.run
  end
end
