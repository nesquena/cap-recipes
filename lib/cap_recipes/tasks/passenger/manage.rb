require 'cap_recipes/tasks/utilities.rb'

Capistrano::Configuration.instance(true).load do
  namespace :deploy do
    
    desc "Stops the phusion passenger server"
    task :stop, :roles => :web do
      puts "Stopping rails web server"
      apache.stop
    end

    desc "Starts the phusion passenger server"
    task :start, :roles => :web do
      puts "Starting rails web server"
      apache.start
    end

    desc "Restarts the phusion passenger server"
    task :restart, :roles => :web do
      run "touch #{current_path}/tmp/restart.txt"
    end
    
  end
end
