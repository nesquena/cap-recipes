Capistrano::Configuration.instance(true).load do

  set :memcache_init_path, "/etc/init.d/memcached"

  # ===============================================================
  # SERVER MANAGEMENT
  # ===============================================================

  namespace :memcache do
    
    desc 'Installs memcache and the ruby gem'
    task :install, :roles => :app do
      puts 'Installing memcache'
      try_sudo 'apt-get install memcached'
      try_sudo "#{base_ruby_path}/bin/gem install memcache-client --no-ri --no-rdoc"
      memcache.start
    end
    
  end
end