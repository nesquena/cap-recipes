require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do
  set :rubygem_paths, '/usr/bin/gem'
  
  namespace :rubygems do
    desc "Performs a rubygems upgrade, updates all gems and cleans up old ones"
    task :full_update, :roles => :app do
      rubygems.upgrade
      rubygems.update
      rubygems.cleanup
    end

    desc "Upgrades the rubygem package installation"
    task :upgrade, :roles => :app do
      Array(rubygem_paths).each { |path| sudo "#{path} update --system" }
    end

    desc "Updates all installed gems on app servers"
    task :update, :roles => :app do
      Array(rubygem_paths).each { |path| sudo "#{path} update" }
    end

    desc "Removes old gems which have been outdated"
    task :cleanup, :roles => :app do
      Array(rubygem_paths).each { |path| sudo "#{path} cleanup" }
    end

    desc "Install a gem on the app servers"
    task :install, :roles => :app do
      gem_name = utilities.ask "Enter the name of the gem you'd like to install:"
      logger.info "trying to install '#{gem_name}'"
      Array(rubygem_paths).each {|path| sudo "#{path} install #{gem_name} --no-ri --no-rdoc" }
    end

    desc "Uninstall a gem from app servers"
    task :uninstall, :roles => :app do
      gem_name = utilities.ask "Enter the name of the gem you'd like to remove:"
      logger.info "trying to remove '#{gem_name}'"
      Array(rubygem_paths).each { |path| sudo "#{path} uninstall #{gem_name} -x" }
    end
  end
end
