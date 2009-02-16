require 'cap_recipes/tasks/with_scope.rb'

Capistrano::Configuration.instance(true).load do
  namespace :deploy do
    
    desc "Default deploy action" 
    task :default, :roles => :web do
      with_role(:web) do
        update
        restart
      end
    end
    
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

    desc "Update code on server, apply migrations, and restart passenger server"
    task :with_migrations, :roles => :web do
      with_role(:web) do
        deploy.update
        deploy.migrate
        deploy.restart
      end
    end
    
  end
end
