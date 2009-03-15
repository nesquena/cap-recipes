Capistrano::Configuration.instance(true).load do

  set :memcache_init_path, "/etc/init.d/memcached"
  set :memcache_size, '64'
  set :memcache_port, '11211'
  set :memcache_host, '127.0.0.1'
  set :memcache_user, 'nobody'

  namespace :memcache do
    
    desc "Stops the memcache server"
    task :stop, :roles => :app do
      puts "Stopping the memcache server"
      try_sudo "killall -s TERM memcached" 
    end

    desc "Starts the memcache server"
    task :start, :roles => :app do
      puts "Starting the memcache server"
      try_sudo "memcached -m #{memcache_size} -p #{memcache_port} -l #{memcache_host} -u #{memcache_user}"
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