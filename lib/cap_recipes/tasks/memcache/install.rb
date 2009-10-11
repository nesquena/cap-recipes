require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do
  namespace :memcache do
    
    desc 'Installs memcache and the ruby gem'
    task :install, :roles => :app do
      puts 'Installing memcache'
      utilities.apt_install 'memcached'
      try_sudo "#{base_ruby_path}/bin/gem install memcache-client --no-ri --no-rdoc"
      memcache.start
    end
    
  end
end