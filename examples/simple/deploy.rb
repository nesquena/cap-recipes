# =============================================================================
# GENERAL SETTINGS
# =============================================================================

role :web, "demo.app.com"
role :app, "demo.app.com"
role :db,  "demo.app.com", :primary => true

set :application,  "demo"
set :deploy_to,  "/var/apps/#{application}"
set :deploy_via, :remote_cache
set :scm, :git
set :repository, "deploy@dev.demo.com:/home/demo.git"
set :git_enable_submodules, 1
set :keep_releases, 3
set :user, "deploy"
set :runner, "deploy"
set :password, "demo567"
set :use_sudo, true
set :branch, 'production'

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
ssh_options[:paranoid] = false
default_run_options[:pty] = true

# =============================================================================
# RECIPE INCLUDES
# =============================================================================

require 'rubygems'
require "bundler/capistrano"
# require 'cap_recipes/tasks/whenever'
# require 'cap_recipes/tasks/passenger'
# require 'cap_recipes/tasks/apache'
# require 'cap_recipes/tasks/memcache'
# require 'cap_recipes/tasks/juggernaut'
# require 'cap_recipes/tasks/delayed_job'
# require 'cap_recipes/tasks/rails'

