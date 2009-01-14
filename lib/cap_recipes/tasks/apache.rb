Capistrano::Configuration.instance(true).load do

  set :apache_init_path, "/etc/init.d/apache2"

  # ===============================================================
  # SERVER MANAGEMENT
  # ===============================================================

  namespace :apache do
    desc "Stops the apache web server"
    task :stop, :role => :app, :except => { :no_release => true } do
      puts "Stopping the apache server"
      sudo "#{apache_init_path} stop"
    end

    desc "Starts the apache web server"
    task :start, :role => :app, :except => { :no_release => true } do
      puts "Starting the apache server"
      sudo "#{apache_init_path} start"
    end

    desc "Restarts the apache web server"
    task :restart, :role => :app, :except => { :no_release => true } do
      puts "Restarting the apache server"
      sudo "#{apache_init_path} restart"
    end

    # ===============================================================
    # INSTALLATION
    # ===============================================================

    desc 'Installs apache 2 and development headers to compile passenger'
    task :install, :roles => :web, :except => { :no_release => true } do
      puts 'Installing apache 2'
      sudo 'apt-get install apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert libapr1 libapr1-dev   libaprutil1 libmagic1 libpcre3 libpq5 openssl apache2-prefork-dev -y'
    end
  end
end
