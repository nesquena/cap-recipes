Capistrano::Configuration.instance(true).load do
  set :ruby_lib_path, '/usr/lib/ruby'
  set :ruby_bin_path, '/usr/bin/ruby1.8'

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

    desc "Repair permissions to allow user to perform all actions"
    task :repair_permissions, :role => :app do
      puts "Applying correct permissions to allow for proper command execution"
      sudo "chmod -R 744 #{current_path}/log #{current_path}/tmp"
      sudo "chown -R #{user}:#{user} #{current_path}"
      sudo "chown -R #{user}:#{user} #{current_path}/tmp"
    end

    desc "Displays the production log from the server locally"
    task :tail, :role => :app do
      stream "tail -f #{shared_path}/log/production.log"
    end

    # ===============================================================
    # INSTALLATION
    # ===============================================================

    desc "Installs Phusion Passenger"
    task :install_passenger, :role => :app do
      puts 'Installing passenger module'
      deploy.passenger_module
      deploy.config_passenger
    end
    
    desc "Setup Passenger Module"
    task :passenger_module do
      sudo "gem install passenger --no-ri --no-rdoc"
      input = ''
      run "sudo passenger-install-apache2-module" do |ch, stream, out|
        next if out.chomp == input.chomp || out.chomp == ''
        print out
        ch.send_data(input = $stdin.gets) if out =~ /(Enter|ENTER)/
      end
    end

    desc "Configure Passenger"
    task :config_passenger do
      version = 'ERROR' # default
      
      # passenger (2.X.X, 1.X.X)
      run("gem list | grep passenger") do |ch, stream, data|
        version = data.sub(/passenger \(([^,]+).*/,"\\1").strip
      end

      puts "  passenger version #{version} configured"

      passenger_config =<<-EOF
        LoadModule passenger_module #{ruby_lib_path}/gems/1.8/gems/passenger-#{version}/ext/apache2/mod_passenger.so
        PassengerRoot #{ruby_lib_path}/gems/1.8/gems/passenger-#{version}
        PassengerRuby /usr/bin/ruby1.8
      EOF
      
      put passenger_config, "src/passenger"
      sudo "mv src/passenger /etc/apache2/conf.d/passenger"
    end
    
  end

  # ===============================================================
  # MAINTENANCE TASKS
  # ===============================================================
  namespace :sweep do
    desc "Clear file-based fragment and action caching"
    task :log, :role => :app do
      puts "Sweeping all the log files"
      run "cd #{current_path} && #{sudo} rake log:clear RAILS_ENV=production"
    end

    desc "Clear file-based fragment and action caching"
    task :cache, :role => :app do
      puts "Sweeping the fragment and action cache stores"
      run "cd #{release_path} && #{sudo} rake tmp:cache:clear RAILS_ENV=production"
    end
  end

  # ===============================================================
  # TASK CALLBACKS
  # ===============================================================
  after "deploy:update_code", "deploy:copy_config" # copy database.yml file to release path
  after "deploy:update_code", "sweep:cache" # clear cache after updating code
  after "deploy:restart"    , "deploy:repair_permissions" # fix the permissions to work properly
end
