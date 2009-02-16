Capistrano::Configuration.instance(true).load do  
  after "deploy:update_code"   , "backgroundrb:symlink_config"
  after "deploy:restart"       , "backgroundrb:restart"
  after "backgroundrb:restart" , "backgroundrb:repair_permissions"
end