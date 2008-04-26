require 'yaml'

Capistrano::Configuration.instance(true).load do
  set :backgroundrb_host, 'localhost'
  set :backgroundrb_env, 'production'
  
  namespace :backgroundrb do   
    # ===============================================================
    # PROCESS MANAGEMENT
    # ===============================================================  
    
    desc "Stops the backgroundrb worker processes"
    task :stop, :role => :app do
      run "cd #{current_path} && sudo ruby script/backgroundrb stop -e #{backgroundrb_env}"
    end
    
    desc "Starts the backgroundrb worker processes"
    task :start, :role => :app do
      run "cd #{current_path} && nohup ruby script/backgroundrb start -e #{backgroundrb_env} > #{backgroundrb_log}"
    end
    
    desc "Restarts a running backgroundrb server."
    task :restart, :role => :app do
      backgroundrb.stop
      sleep(5)  # sleep for 5 seconds to make sure the server has mopped up everything
      backgroundrb.start
    end
    
    # ===============================================================
    # PROCESS CONFIGURATION
    # ===============================================================  
    
    desc "Creates configuration file for the backgroundrb server"
    task :configure, :role => :app do
      config = { :backgroundrb => {:ip => backgroundrb_host, :port => backgroundrb_port, :environment => backgroundrb_env} }
      backgroundrb_yml = config.to_yaml
      
      run "if [ ! -d #{shared_path}/config ]; then mkdir #{shared_path}/config; fi"
      put(backgroundrb_yml, "#{shared_path}/config/backgroundrb.yml", :mode => 0644)
    end
    
    # ===============================================================
    # FILE MANAGEMENT
    # ===============================================================  
    
    desc "Copies the shared/config/backgroundrb yaml to release/config/"
    task :copy_config, :role => :app do
      on_rollback {
        puts "***** File shared/config/backgroundrb.yml is missing. Make sure you have run backgroundrb:configure first. *****"
      }
      
      run "cp #{shared_path}/config/backgroundrb.yml #{release_path}/config/"
    end
    
    desc "Displays the backgroundrb log from the server"
    task :tail do
      stream "tail -f #{shared_path}/log/backgroundrb_#{backgroundrb_port}.log" 
    end
  end
  
  # ===============================================================
  # TASK CALLBACKS
  # ===============================================================  
  
  after "deploy:update_code", "backgroundrb:copy_config"
  after "deploy:restart", "backgroundrb:restart"
end