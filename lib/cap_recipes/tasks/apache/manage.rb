Capistrano::Configuration.instance(true).load do

  set :apache_init_path, "/etc/init.d/apache2"

  namespace :apache do
    
    desc "Stops the apache web server"
    task :stop, :roles => :web do
      puts "Stopping the apache server"
      sudo "#{apache_init_path} stop"
    end

    desc "Starts the apache web server"
    task :start, :roles => :web do
      puts "Starting the apache server"
      sudo "#{apache_init_path} start"
    end

    desc "Restarts the apache web server"
    task :restart, :roles => :web do
      puts "Restarting the apache server"
      sudo "#{apache_init_path} restart"
    end
    
  end
end
