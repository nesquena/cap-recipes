Capistrano::Configuration.instance(true).load do

  set :memcache_init_path, "/etc/init.d/memcached"

  # ===============================================================
  # SERVER MANAGEMENT
  # ===============================================================

  namespace :memcache do
    desc "Stops the memcache server"
    task :stop, :role => :app, :except => { :no_release => true } do
      puts "Stopping the memcache server"
      sudo "#{memcache_init_path} stop"
    end

    desc "Starts the memcache server"
    task :start, :role => :app, :except => { :no_release => true } do
      puts "Starting the memcache server"
      sudo "#{memcache_init_path} start"
    end

    desc "Restarts the memcache server"
    task :restart, :role => :app, :except => { :no_release => true } do
      puts "Restarting the memcache server"
      memcache.stop
      memcache.start
    end

    # ===============================================================
    # INSTALLATION
    # ===============================================================

    desc 'Installs memcache and the ruby gem'
    task :install, :roles => :web, :except => { :no_release => true } do
      puts 'Installing memcache'
      sudo 'apt-get install memcached'
      sudo "#{base_ruby_path}/bin/gem install memcache-client --no-ri --no-rdoc"
      memcache.start
    end
  end
  
  after "deploy:update_code", "memcache:restart" # clear cache after updating code
end
