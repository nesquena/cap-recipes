Gem::Specification.new do |s|
  s.name = "cap-recipes"
  s.version = "0.0.1"
  s.date = "2008-04-26"
  s.summary = "My collection of capistrano tasks"
  s.email = "xgamerx10@gmail.com"
  s.homepage = "http://github.com/xgamerx/cap_recipes"
  s.description = "My collection of capistrano tasks for use with passenger, juggernaut and backgroundrb"
  s.has_rdoc = false
  s.authors = ["Nathan Esquenazi"]
  
  s.files = [ 
  "History.txt",
  "License.txt",
  "Manifest.txt",
  "README.txt",
  "Rakefile",
  "config/hoe.rb",
  "config/requirements.rb",
  "lib/cap_recipes.rb",
  "lib/cap_recipes/version.rb",
  "lib/cap_recipes/tasks/apache.rb",
  "lib/cap_recipes/tasks/backgroundrb.rb",
  "lib/cap_recipes/tasks/juggernaut.rb",
  "lib/cap_recipes/tasks/passenger.rb",
  "script/console",
  "script/destroy",
  "script/generate",
  "script/txt2html",
  "setup.rb",
  "test/test_cap_recipes.rb",
  "test/test_helper.rb",
  "website/index.html",
  "website/index.txt",
  "website/javascripts/rounded_corners_lite.inc.js",
  "website/stylesheets/screen.css",
  "website/template.html.erb" ]
  
  s.test_files = ["test/test_cap_recipes.rb", "test/test_helper.rb" ]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("capistrano", ["> 2.2.0"])
end