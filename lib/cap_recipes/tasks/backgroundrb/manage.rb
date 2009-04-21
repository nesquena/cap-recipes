require 'yaml'

Capistrano::Configuration.instance(true).load do
  set :backgroundrb_host, 'localhost'
  set :backgroundrb_env , 'production'
  set :base_ruby_path,    '/usr'
  
  namespace :backgroundrb do   
    # ===============================================================
    # PROCESS MANAGEMENT
    # ===============================================================  
    
    desc "Stops the backgroundrb worker processes"
    task :stop, :roles => :app do
      run "cd #{current_path} && #{sudo} #{base_ruby_path}/bin/ruby script/backgroundrb stop"
    end
    
    desc "Starts the backgroundrb worker processes"
    task :start, :roles => :app do
      run "cd #{current_path} && #{sudo} nohup #{base_ruby_path}/bin/ruby script/backgroundrb start"
    end
    
    desc "Restarts a running backgroundrb server."
    task :restart, :roles => :app do
      backgroundrb.stop
      sleep(5)  # sleep for 5 seconds to make sure the server has mopped up everything
      backgroundrb.start
    end
    
    # ===============================================================
    # PROCESS CONFIGURATION
    # ===============================================================  
    
    desc "Creates configuration file for the backgroundrb server"
    task :configure, :roles => :app do
      config = { :backgroundrb => {:ip => backgroundrb_host, :port => backgroundrb_port, :environment => backgroundrb_env} }
      backgroundrb_yml = config.to_yaml
      
      run "if [ ! -d #{shared_path}/config ]; then mkdir #{shared_path}/config; fi"
      put(backgroundrb_yml, "#{shared_path}/config/backgroundrb.yml", :mode => 0644)
    end
    
    # ===============================================================
    # FILE MANAGEMENT
    # ===============================================================  
    
    desc "Symlinks the shared/config/backgroundrb yaml to release/config/"
    task :symlink_config, :roles => :app do
      run "ln -s #{shared_path}/config/backgroundrb.yml #{release_path}/config/backgroundrb.yml"
    end
    
    desc "Displays the backgroundrb log from the server"
    task :tail do
      stream "tail -f #{shared_path}/log/backgroundrb_#{backgroundrb_port}.log" 
    end
    
    desc "Repair permissions to allow user to perform all actions"
    task :repair_permissions, :roles => :app do
      puts "Applying correct permissions to allow for proper command execution"
      try_sudo "chown -R #{user}:#{user} #{current_path}"
      try_sudo "chown -R #{user}:#{user} #{current_path}/tmp"
    end
  end
end