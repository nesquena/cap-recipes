Capistrano::Configuration.instance(true).load do

  set :memcache_init_path, "/etc/init.d/memcached"

  namespace :memcache do
    
    desc "Stops the memcache server"
    task :stop, :roles => :app do
      puts "Stopping the memcache server"
      try_sudo "nohup /etc/init.d/memcached stop &" 
    end

    desc "Starts the memcache server"
    task :start, :roles => :app do
      puts "Starting the memcache server"
      try_sudo "nohup /etc/init.d/memcached start &" 
    end

    desc "Restarts the memcache server"
    task :restart, :roles => :app do
      puts "Restarting the memcache server"
      memcache.stop
      sleep(3)  # sleep for 3 seconds to make sure the server has mopped up everything
      memcache.start
    end
    
  end
end