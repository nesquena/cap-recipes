Capistrano::Configuration.instance(true).load do
  set :delayed_script_path, 'script/delayed_job'
  set :delayed_job_env, 'production'
  set :base_ruby_path,    '/usr'
  
  namespace :delayed_job do
    desc "Start delayed_job process"
    task :start, :roles => :app do
      run "cd #{current_path} && #{sudo} #{base_ruby_path}/bin/ruby #{delayed_script_path} start #{delayed_job_env}"
    end

    desc "Stop delayed_job process"
    task :stop, :roles => :app do
      run "cd #{current_path} && #{sudo} #{base_ruby_path}/bin/ruby #{delayed_script_path} stop #{delayed_job_env}"
    end

    desc "Restart delayed_job process"
    task :restart, :roles => :app do
      # run "cd #{current_path} && #{sudo} #{base_ruby_path}/bin/ruby #{delayed_script_path} restart #{delayed_job_env}"
      delayed_job.stop
      sleep(4)
      try_sudo "killall -s TERM delayed_job"
      delayed_job.start
    end
  end
end
