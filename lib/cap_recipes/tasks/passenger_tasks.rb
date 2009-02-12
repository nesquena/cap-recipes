require 'cap_recipes/tasks/with_scope.rb'

Capistrano::Configuration.instance(true).load do
  set :base_ruby_path, '/usr'

  namespace :passenger do
    desc "Restarts the phusion passenger server"
    task :restart, :roles => :web do
      run "touch #{current_path}/tmp/restart.txt"
    end

    desc "Installs Phusion Passenger"
    task :install, :roles => :web do
      puts 'Installing passenger module'
      install.install_apache_module
      install.update_config
    end

    desc "Setup Passenger Module"
    task :install_apache_module, :roles => :web do
      sudo "#{base_ruby_path}/bin/gem install passenger --no-ri --no-rdoc"
      sudo "#{base_ruby_path}/bin/passenger-install-apache2-module", :pty => true do |ch, stream, data|
        if data =~ /Press\sEnter\sto\scontinue/ || data =~ /Press\sENTER\sto\scontinue/
          ch.send_data("\n")
        else
          Capistrano::Configuration.default_io_proc.call(ch, stream, data)
        end
      end
    end

    desc "Configure Passenger"
    task :update_config, :roles => :web do
      version = 'ERROR' # default

      # passenger (2.X.X, 1.X.X)
      run("gem list | grep passenger") do |ch, stream, data|
        version = data.sub(/passenger \(([^,]+).*?\)/,"\\1").strip
      end

      puts "  passenger version #{version} configured"

      passenger_config =<<-EOF
        LoadModule passenger_module #{base_ruby_path}/lib/ruby/gems/1.8/gems/passenger-#{version}/ext/apache2/mod_passenger.so
        PassengerRoot #{base_ruby_path}/lib/ruby/gems/1.8/gems/passenger-#{version}
        PassengerRuby #{base_ruby_path}/bin/ruby
      EOF

      put passenger_config, "/tmp/passenger"
      sudo "mv /tmp/passenger /etc/apache2/conf.d/passenger"
      apache.restart
    end
  end
end