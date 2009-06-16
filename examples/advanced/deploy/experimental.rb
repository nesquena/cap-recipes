# Domain
role :web, "stage.app.com"
role :app, "stage.app.com"
role :db,  "stage.app.com", :primary => true

# GENERAL
set :user, "deploy"
set :runner, "deploy"
set :password, "demo567"
set :use_sudo, true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "demo")]

# Branch
set :branch, 'develop'