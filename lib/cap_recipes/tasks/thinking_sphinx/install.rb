require File.expand_path(File.dirname(__FILE__) + '/../utilities')

Capistrano::Configuration.instance(true).load do
  namespace :thinking_sphinx do
    desc 'Installs sphinx and thinking_sphinx'
    task :install, :roles => :app do
      puts 'Installing thinking_sphinx'
      utilities.apt_upgrade
      utilities.apt_install 'build-essential libmysqlclient15-dev libmysql++-dev'
      run "cd /tmp; #{sudo} wget http://www.sphinxsearch.com/downloads/sphinx-0.9.8.1.tar.gz"
      run "cd /tmp; #{sudo} tar xvzf sphinx-0.9.8.1.tar.gz"
      run "cd /tmp/sphinx-0.9.8.1/; #{sudo} ./configure --with-mysql-includes=/usr/include/mysql --with-mysql-libs=/usr/lib/mysql"
      run "cd /tmp/sphinx-0.9.8.1/; #{sudo} make; #{sudo} make install"
      sudo "gem install thinking-sphinx --source http://gemcutter.org --no-ri --no-rdoc"
    end
  end
end