Capistrano::Configuration.instance(true).load do

  set :memcache_init_path, "/etc/init.d/memcache"

  # ===============================================================
  # SERVER MANAGEMENT
  # ===============================================================

  namespace :memcache do
    desc "Stops the memcache server"
    task :stop, :role => :app do
      puts "Stopping the memcache server"
      sudo "#{memcache_init_path} stop"
    end

    desc "Starts the memcache server"
    task :start, :role => :app do
      puts "Starting the memcache server"
      sudo "#{memcache_init_path} start"
    end

    desc "Restarts the memcache server"
    task :restart, :role => :app do
      puts "Restarting the memcache server"
      sudo "#{memcache_init_path} restart"
    end

    # ===============================================================
    # INSTALLATION
    # ===============================================================

    desc 'Installs memcache and the ruby gem'
    task :install, :roles => :web do
      puts 'Installing memcache'
      sudo 'apt-get install memcached'
      sudo "#{base_ruby_path}/bin/gem install memcache-client --no-ri --no-rdoc"
      memcache.start
    end
  end
  
  after "deploy:update_code", "memcache:restart" # clear cache after updating code
end
