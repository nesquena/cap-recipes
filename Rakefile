=begin
Using Jeweler for Gem Packaging...

  * Update the version and release version to github: 
    $ rake version:bump:patch && rake release && rake gemcutter:release
    
  * Build and install the latest version locally:
    $ rake install
    
=end

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "cap-recipes"
    s.summary = %Q{Battle-tested capistrano recipes for passenger, delayed_job, and more}
    s.email = "nesquena@gmail.com"
    s.homepage = "http://github.com/nesquena/cap-recipes"
    s.description = "Battle-tested capistrano recipes for debian, passenger, apache, delayed_job, juggernaut, rubygems, backgroundrb, rails and more"
    s.authors = ["Nathan Esquenazi"]
    s.rubyforge_project = 'cap-recipes'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'cap-recipes'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end
rescue LoadError
end

desc "Run all specs in spec directory"
task :spec do |t|
  options = "--colour --format progress --loadby --reverse"
  files = FileList['spec/**/*_spec.rb']
  system("spec #{options} #{files}")
end

task :default => :spec