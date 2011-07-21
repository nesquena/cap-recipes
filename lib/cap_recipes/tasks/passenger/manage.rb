Capistrano::Configuration.instance(true).load do
  namespace :deploy do
    
    desc "Stops the phusion passenger server"
    task :stop, :roles => :web do
      puts "Stopping rails web server"
      apache.stop
    end

    desc "Starts the phusion passenger server"
    task :start, :roles => :web do
      puts "Starting rails web server"
      apache.start
    end

    desc "Restarts the phusion passenger server"
    task :restart, :roles => :web do
      puts "Restarting passenger by touching restart.txt"
      run "touch #{current_path}/tmp/restart.txt"
    end
    
  end

  namespace :passenger do

    desc "Standalone mode for passenger"
    namespace :standalone do

      desc "Starts the standalone passenger server"
      task :start do
        run "cd #{current_path} && passenger start -a 127.0.0.1 -p 3000 -d -e #{stage_or_production}"
      end

      desc "Stops the standalone passenger server"
      task :stop do
        run "cd #{current_path} && passenger stop"
      end

      desc "Restarts the standalone passenger server"
      task :restart, :roles => :app, :except => { :no_release => true } do
        run "cd #{current_path} && passenger stop"
        run "cd #{current_path} && passenger start -a 127.0.0.1 -p 3000 -d -e #{stage_or_production}"
      end

    end

  end
  # ===============================================================
  # Support for capistrano-ext
  # ===============================================================
  def stage_or_production
    exists?(:stage) ? stage : "production"
  end
end
