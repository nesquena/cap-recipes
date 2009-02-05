Capistrano::Configuration.instance(true).load do

  set :memcache_init_path, "/etc/init.d/memcached"

  # ===============================================================
  # SERVER MANAGEMENT
  # ===============================================================

  namespace :memcache do
    desc "Stops the memcache server"
    task :stop, :roles => :app do
      puts "Stopping the memcache server"
      try_sudo "#{memcache_init_path} stop"
    end

    desc "Starts the memcache server"
    task :start, :roles => :app do
      puts "Starting the memcache server"
      try_sudo "#{memcache_init_path} start"
    end

    desc "Restarts the memcache server"
    task :restart, :roles => :app do
      puts "Restarting the memcache server"
      memcache.stop
      sleep(5)  # sleep for 5 seconds to make sure the server has mopped up everything
      memcache.start
    end

    # ===============================================================
    # INSTALLATION
    # ===============================================================

    desc 'Installs memcache and the ruby gem'
    task :install, :roles => :app do
      puts 'Installing memcache'
      try_sudo 'apt-get install memcached'
      try_sudo "#{base_ruby_path}/bin/gem install memcache-client --no-ri --no-rdoc"
      memcache.start
    end
  end
  
  after "deploy:restart", "memcache:restart" # clear cache after updating code
end
