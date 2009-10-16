Capistrano::Configuration.instance(true).load do
  after "deploy:update_code", "thinking_sphinx:symlink_config" # sym thinking_sphinx.yml on update code
  after "deploy:restart"    , "thinking_sphinx:restart"     # restart thinking_sphinx on app restart
end