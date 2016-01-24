namespace :deploy do
  task :production do
    puts "deploying to production"
    system "git push heroku master"
    puts "clearing cache"
    system "heroku run rake cache:flush"
    puts "done"
  end
end
