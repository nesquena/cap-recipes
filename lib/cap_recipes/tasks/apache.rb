Capistrano::Configuration.instance(true).load do

  set :apache_init_path, "/etc/init.d/apache2"

  # ===============================================================
  # SERVER MANAGEMENT
  # ===============================================================

  namespace :apache do
    desc "Stops the apache web server"
    task :stop, :roles => :web do
      puts "Stopping the apache server"
      try_sudo "#{apache_init_path} stop"
    end

    desc "Starts the apache web server"
    task :start, :roles => :web do
      puts "Starting the apache server"
      try_sudo "#{apache_init_path} start"
    end

    desc "Restarts the apache web server"
    task :restart, :roles => :web do
      puts "Restarting the apache server"
      try_sudo "#{apache_init_path} restart"
    end

    # ===============================================================
    # INSTALLATION
    # ===============================================================

    desc 'Installs apache 2 and development headers to compile passenger'
    task :install, :roles => :web do
      puts 'Installing apache 2'
      try_sudo 'apt-get install apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert libapr1 libapr1-dev   libaprutil1 libmagic1 libpcre3 libpq5 openssl apache2-prefork-dev -y'
    end
  end
end
