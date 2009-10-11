require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do
  namespace :aptitude do
    desc "Updates all installed packages on aptitude package system"
    task :updates do
      sudo "apt-get -qy update"
      utilities.apt_upgrade
      sudo "apt-get -qy autoremove"
    end

    desc "Installs a specified aptitude package"
    task :install do
      deb_pkg_name = utilities.ask "Enter name of the package(s) you wish to install:"
      raise "Please specify deb_pkg_name" if deb_pkg_name == ''
      logger.info "Updating packages..."
      sudo "aptitude update"
      logger.info "Installing #{deb_pkg_name}..."
      utilities.apt_install deb_pkg_name
    end

    desc "Removes a specified aptitude package"
    task :remove do
      deb_pkg_name = utilities.ask "Enter name of the package(s) you wish to remove:"
      raise "Please specify deb_pkg_name" if deb_pkg_name == ''
      logger.info "Updating packages..."
      sudo "aptitude update"
      logger.info "Removing #{deb_pkg_name}..."
      utilities.sudo_with_input "apt-get remove --purge #{deb_pkg_name}", /^Do you want to continue\?/
    end
  end
end
