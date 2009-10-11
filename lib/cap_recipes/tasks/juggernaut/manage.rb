require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do
  set :juggernaut_config, "#{current_path}/config/juggernaut.yml"
  set :juggernaut_pid, "#{current_path}/tmp/pids/juggernaut.pid"
  set :juggernaut_log, "#{current_path}/log/juggernaut.log"
  set :juggernaut_role, :app
  set :base_ruby_path,  '/usr'

  namespace :juggernaut do

    # ===============================================================
    # PROCESS MANAGEMENT
    # ===============================================================

    desc "Starts the juggernaut push server"
    task :start, :roles => juggernaut_role do
      utilities.with_role(juggernaut_role) do
        puts "Starting juggernaut push server"
        try_sudo "#{base_ruby_path}/bin/juggernaut -c #{juggernaut_config} -d --pid #{juggernaut_pid} --log #{juggernaut_log}"
      end
    end

    desc "Stops the juggernaut push server"
    task :stop, :roles => juggernaut_role do
      utilities.with_role(juggernaut_role) do
        puts "Stopping juggernaut push server"
        try_sudo "#{base_ruby_path}/bin/juggernaut -c #{juggernaut_config} -k * --pid #{juggernaut_pid} --log #{juggernaut_log}"
      end
    end

    desc "Restarts the juggernaut push server"
    task :restart, :roles => juggernaut_role do
      utilities.with_role(juggernaut_role) do
        juggernaut.stop
        juggernaut.start
      end
    end

    # ===============================================================
    # FILE MANAGEMENT
    # ===============================================================

    desc "Symlinks the shared/config/juggernaut yaml to release/config/"
    task :symlink_config, :roles => :app do
      try_sudo "ln -s #{shared_path}/config/juggernaut.yml #{release_path}/config/juggernaut.yml"
    end

    desc "Displays the juggernaut log from the server"
    task :tail, :roles => :app do
      stream "tail -f #{shared_path}/log/juggernaut.log"
    end

  end

end
