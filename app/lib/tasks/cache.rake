namespace :cache do
  task :flush => :environment do
    puts "flushing cache"
    Rails.cache.clear
    puts "done"
  end
end
