require 'cap_recipes/tasks/with_scope.rb'

Capistrano::Configuration.instance(true).load do
  after "deploy:update_code", "rails:copy_config" # copy database.yml file to release path
  after "deploy:update_code", "rails:sweep:cache" # clear cache after updating code
  after "deploy:restart"    , "rails:repair_permissions" # fix the permissions to work properly
  after "deploy:restart"    , "rails:ping" # ping passenger to start the rails instance
end