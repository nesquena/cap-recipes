require 'cap_recipes/tasks/utilities.rb'

Capistrano::Configuration.instance(true).load do
  namespace :aptitude do
    desc "Updates all installed packages on apt-get package system"
    task :updates do
      sudo "apt-get -qy update"
      sudo "apt-get -qy upgrade"
      sudo "apt-get -qy autoremove"
    end

    desc "Installs a specified apt-get package"
    task :install do
      puts "What is the name of the package(s) you wish to install?"
      deb_pkg_name = $stdin.gets.chomp
      raise "Please specify deb_pkg_name" if deb_pkg_name == ''
      logger.info "Updating packages..."
      sudo "aptitude update"
      logger.info "Installing #{deb_pkg_name}..."
      utilities.sudo_with_input "apt-get install #{deb_pkg_name}", /^Do you want to continue\?/
    end

    desc "Removes a specified apt-get package"
    task :remove do
      puts "What is the name of the package(s) you wish to install?"
      deb_pkg_name = $stdin.gets.chomp
      raise "Please specify deb_pkg_name" if deb_pkg_name == ''
      logger.info "Updating packages..."
      sudo "aptitude update"
      logger.info "Removing #{deb_pkg_name}..."
      utilities.sudo_with_input "apt-get remove --purge #{deb_pkg_name}", /^Do you want to continue\?/
    end
  end
end
