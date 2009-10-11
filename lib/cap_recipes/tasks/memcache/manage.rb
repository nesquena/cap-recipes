require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do

  set :memcache_init_path, "/etc/init.d/memcached"
  set :memcache_role, :app

  namespace :memcache do

    desc "Stops the memcache server"
    task :stop, :roles => memcache_role do
      utilities.with_role(memcache_role) do
        puts "Stopping the memcache server"
        try_sudo "killall -s TERM memcached; true"
      end
    end

    desc "Starts the memcache server"
    task :start, :roles => memcache_role do
      utilities.with_role(memcache_role) do
        puts "Starting the memcache server"
        try_sudo "nohup /etc/init.d/memcached start"
      end
    end

    desc "Restarts the memcache server"
    task :restart, :roles => memcache_role do
      utilities.with_role(memcache_role) do
        puts "Restarting the memcache server"
        memcache.stop
        sleep(3)  # sleep for 3 seconds to make sure the server has mopped up everything
        memcache.start
      end
    end

  end
end
