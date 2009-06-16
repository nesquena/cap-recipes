# Domain
role :web, "demo.app.com"
role :app, "demo.app.com"
role :db,  "demo.app.com", :primary => true
role :juggernaut,  "juggernaut.app.com", :no_release => true
role :delayed_job, "dj.app.com", :no_release => true
role :memcache,    "memcache.app.com", :no_release => true

# GENERAL
set :user, "deploy"
set :runner, "deploy"
set :password, "demo567"
set :use_sudo, true
set :juggernaut_role,  :juggernaut
set :delayed_job_role, :delayed_job
set :memcache_role,    :memcache
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "demo")]

# Branch
set :branch, 'master'