(in /Users/nesquena/Documents/Development/TextMate/cap_recipes)
Gem::Specification.new do |s|
  s.name = %q{cap-recipes}
  s.version = "0.0.3"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Esquenazi"]
  s.date = %q{2008-04-26}
  s.description = %q{My collection of capistrano recipes}
  s.email = ["xgamerx10@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "website/index.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "lib/cap_recipes.rb", "lib/cap_recipes/version.rb", "lib/cap_recipes/tasks/apache.rb", "lib/cap_recipes/tasks/backgroundrb.rb", "lib/cap_recipes/tasks/juggernaut.rb", "lib/cap_recipes/tasks/passenger.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "tasks/development.rake", "tasks/environment.rake", "tasks/website.rake", "test/test_cap_recipes.rb", "test/test_helper.rb", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://caprecipes.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{caprecipes}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{My collection of capistrano recipes}
  s.test_files = ["test/test_cap_recipes.rb", "test/test_helper.rb"]
end
