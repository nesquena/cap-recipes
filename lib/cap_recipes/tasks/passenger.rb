Capistrano::Configuration.instance(true).load do
  
  # ===============================================================
  # DEPLOYMENT SCRIPTS
  # ===============================================================  
  
  namespace :deploy do
    
    # ===============================================================
    # SERVER MANAGEMENT
    # ===============================================================
    
    desc "Stops the phusion passenger server"
    task :stop, :role => :app do
      puts "Stopping rails web server"
      apache.stop
    end
    
    desc "Starts the phusion passenger server"
    task :start, :role => :app do
      puts "Starting rails web server"
      apache.start
    end
    
    desc "Restarts the phusion passenger server"
    task :restart, :role => :app do
      puts "Restarting the application"
      run "touch #{current_path}/tmp/restart.txt"
    end
    
    desc "Update code on server, apply migrations, and restart passenger server"
    task :with_migrations, :role => :app do
      deploy.update
      deploy.migrate
      deploy.restart
    end
    
    # ===============================================================
    # UTILITY TASKS
    # ===============================================================
    
    desc "Copies the shared/config/database yaml to release/config/"
    task :copy_config, :role => :app do
      puts "Copying database configuration to release path"
      sudo "cp #{shared_path}/config/database.yml #{release_path}/config/"
    end
    
    desc "Displays the production log from the server locally"
    task :tail, :role => :app do
      stream "tail -f #{shared_path}/log/production.log" 
    end
    
    # ===============================================================
    # INSTALLATION
    # ===============================================================
    
    task :install, :role => :app do
      puts 'Installing passenger gems'
      sudo 'gem install fastthread passenger'
    end
  end  
  
  # ===============================================================
  # MAINTENANCE TASKS
  # ===============================================================  
  namespace :sweep do
    desc "Clear file-based fragment and action caching"
    task :log, :role => :app do
      puts "Sweeping all the log files"
      run "cd #{current_path} && sudo rake log:clear RAILS_ENV=production" 
    end
    
    desc "Clear file-based fragment and action caching"
    task :cache, :role => :app do
      puts "Sweeping the fragment and action cache stores"
      run "cd #{current_path} && rake tmp:cache:clear RAILS_ENV=production" 
    end
  end
  
  # ===============================================================
  # TASK CALLBACKS
  # ===============================================================  
  
  after "deploy:update_code", "deploy:copy_config" # copy database.yml file to release path
  after "deploy:update_code", "sweep:cache" # clear cache after updating code
end