require 'cap_recipes/tasks/utilities.rb'
 
Capistrano::Configuration.instance(true).load do
 
  namespace :ruby do
 
    desc "install ruby"
    task :setup, :roles => :app do
      utilities.apt_install %w[ruby ri rdoc ruby1.8-dev irb1.8 libreadline-ruby1.8
            libruby1.8 rdoc1.8 ri1.8 ruby1.8 irb libopenssl-ruby libopenssl-ruby1.8]
    end
    before "ruby:setup", "aptitude:updates"
 
  end
end