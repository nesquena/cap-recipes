# =============================================================================
# GENERAL SETTINGS
# =============================================================================

set :application,  "demo"
set :deploy_to,  "/var/apps/#{application}"
set :deploy_via, :remote_cache
set :scm, :git
set :repository, "deploy@dev.demo.com:/home/demo.git"
set :git_enable_submodules, 1
set :keep_releases, 3

# =============================================================================
# STAGE SETTINGS
# =============================================================================

# set :default_stage, "experimental"
set :stages, %w(production experimental)
set :default_stage, "experimental"
require 'capistrano/ext/multistage'

# =============================================================================
# RECIPE INCLUDES
# =============================================================================

require 'rubygems'
require 'cap_recipes/tasks/whenever'
require 'cap_recipes/tasks/apache'
require 'cap_recipes/tasks/passenger'
require 'cap_recipes/tasks/memcache'
require 'cap_recipes/tasks/juggernaut'
require 'cap_recipes/tasks/delayed_job'
require 'cap_recipes/tasks/rails'

ssh_options[:paranoid] = false
default_run_options[:pty] = true

# PASSENGER
set :base_ruby_path, '/opt/ruby-enterprise' # not /usr