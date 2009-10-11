require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do

  namespace :apache do
    
    desc 'Installs apache 2 and development headers to compile passenger'
    task :install, :roles => :web do
      puts 'Installing apache 2'
      utilities.apt_install %w[apache2 apache2.2-common apache2-mpm-prefork apache2-utils 
        libexpat1 ssl-cert libapr1 libapr1-dev   libaprutil1 libmagic1 
        libpcre3 libpq5 openssl apache2-prefork-dev]
    end
    
  end
end
