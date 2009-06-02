Capistrano::Configuration.instance(true).load do
  
  after "deploy:symlink", "whenever:update_crontab" # update crontab after symlink
  
end