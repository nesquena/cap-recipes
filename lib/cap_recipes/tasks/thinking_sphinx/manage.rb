Capistrano::Configuration.instance(true).load do
  set :sphinx_role, :app
  
  namespace :thinking_sphinx do
    # ===============================================================
    # PROCESS MANAGEMENT
    # ===============================================================

    desc "Starts the thinking sphinx searchd server"
    task :start, :roles => sphinx_role do
      utilities.with_role(sphinx_role) do
        puts "Starting thinking sphinx searchd server"
        rake = fetch(:rake, "rake")
        rails_env = fetch(:rails_env, "production")

        run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} thinking_sphinx:configure"
        run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} ts:start"
      end
    end

    desc "Stops the thinking sphinx searchd server"
    task :stop, :roles => sphinx_role do
      utilities.with_role(sphinx_role) do
        puts "Stopping thinking sphinx searchd server"
        rake = fetch(:rake, "rake")
        rails_env = fetch(:rails_env, "production")

        run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} thinking_sphinx:configure"
        run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} ts:stop"
      end
    end

    desc "Restarts the thinking sphinx searchd server"
    task :restart, :roles => sphinx_role do
      utilities.with_role(sphinx_role) do
        thinking_sphinx.stop
        thinking_sphinx.index
        thinking_sphinx.start
      end
    end

    # ===============================================================
    # FILE MANAGEMENT
    # ===============================================================

    desc "Copies the shared/config/sphinx yaml to release/config/"
    task :symlink_config, :roles => :app do
      run "ln -s #{shared_path}/config/sphinx.yml #{release_path}/config/sphinx.yml"
    end

    desc "Displays the thinking sphinx log from the server"
    task :tail, :roles => :app do
      stream "tail -f #{shared_path}/log/searchd.log"
    end

    desc "Runs Thinking Sphinx indexer"
    task :index, :roles => sphinx_role do
      rake = fetch(:rake, "rake")
      rails_env = fetch(:rails_env, "production")
      puts "Updating search index"

      run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} ts:index"
    end
  end
end
