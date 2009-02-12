require 'cap_recipes/tasks/with_scope'
require 'cap_recipes/tasks/passenger_tasks'
require 'cap_recipes/tasks/rails'

Capistrano::Configuration.instance(true).load do
  # ===============================================================
  # DEPLOYMENT SCRIPTS
  # ===============================================================
  namespace :deploy do
    desc "Default deploy action" 
    task :default, :roles => :web do
      with_role(:web) do
        update
        restart
      end
    end

    # ===============================================================
    # SERVER MANAGEMENT
    # ===============================================================

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
      puts "Restarting the application"
      passenger.restart
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
  
  # ===============================================================
  # INSTALLATION
  # ===============================================================
  
  namespace :install do
    
    desc "Updates all installed ruby gems"
    task :gems, :roles => :web do
      try_sudo "gem update"
    end
    
  end

  # ===============================================================
  # TASK CALLBACKS
  # ===============================================================
  after "deploy:update_code", "rails:copy_config" # copy database.yml file to release path
  after "deploy:update_code", "rails:sweep:cache" # clear cache after updating code
  after "deploy:restart"    , "rails:repair_permissions" # fix the permissions to work properly
  after "deploy:restart"    , "rails:ping" # ping passenger to start the rails instance
end
