require File.expand_path(File.dirname(__FILE__) + '/../utilities')
require File.expand_path(File.dirname(__FILE__) + '/install')

Capistrano::Configuration.instance(true).load do
  set :mongodb_log, "/var/log/mongodb.log"

  namespace :mongodb do
    desc "Starts the mongodb server"
    task :start, :role => :app do
      sudo "#{mongodb_bin_path}/bin/mongod --fork --logpath #{mongodb_log} --logappend --dbpath #{mongodb_data_path}"
    end

    desc "Stop the mongodb server"
    task :stop, :role => :app do
      pid = capture("ps -o pid,command ax | grep mongod | awk '!/awk/ && !/grep/ {print $1}'")
      sudo "kill -2 #{pid}" unless pid.strip.empty?
    end

    desc "Restart the mongodb server"
    task :restart, :role => :app do
      pid = capture("ps -o pid,command ax | grep mongod | awk '!/awk/ && !/grep/ {print $1}'")
      mongodb.stop unless pid.strip.empty?
      mongodb.start
    end

  end
end
