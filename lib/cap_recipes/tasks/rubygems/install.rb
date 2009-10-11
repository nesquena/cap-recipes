Capistrano::Configuration.instance(true).load do
  set :rubygems_version, "1.3.5"

  namespace :rubygems do
    before "rubygems:setup", "ruby:setup"

    desc "install rubygems"
    task :setup, :roles => :app do
      run "wget http://rubyforge.org/frs/download.php/60718/rubygems-#{rubygems_version}.tgz"
      run "tar xvzf rubygems-#{rubygems_version}.tgz"
      run "cd rubygems-#{rubygems_version}; sudo ruby setup.rb"
      run "#{sudo} rm /usr/bin/gem; #{sudo} ln -s /usr/bin/gem1.8 /usr/bin/gem"
    end

    desc "cleanup the files"
    task :cleanup do
      run "cd; rm -rf rubygems-#{rubygems_version}; rm -rf rubygems-#{rubygems_version}.*"
    end
    before "rubygems:setup", "rubygems:cleanup"
    after "rubygems:setup", "rubygems:cleanup"

  end
end