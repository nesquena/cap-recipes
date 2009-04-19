Capistrano::Configuration.instance(true).load do
  after "deploy:start",   "delayed_job:start"
  after "deploy:stop",    "delayed_job:stop"
  after "deploy:restart", "delayed_job:restart"
end
