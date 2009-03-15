# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cap-recipes}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Esquenazi"]
  s.date = %q{2009-03-14}
  s.description = %q{Battle-tested capistrano recipes for passenger, apache, and more}
  s.email = %q{nesquena@gmail.com}
  s.extra_rdoc_files = ["README.textile", "LICENSE"]
  s.files = ["README.textile", "VERSION.yml", "lib/cap_recipes", "lib/cap_recipes/tasks", "lib/cap_recipes/tasks/apache", "lib/cap_recipes/tasks/apache/install.rb", "lib/cap_recipes/tasks/apache/manage.rb", "lib/cap_recipes/tasks/apache.rb", "lib/cap_recipes/tasks/backgroundrb", "lib/cap_recipes/tasks/backgroundrb/hooks.rb", "lib/cap_recipes/tasks/backgroundrb/manage.rb", "lib/cap_recipes/tasks/backgroundrb.rb", "lib/cap_recipes/tasks/juggernaut", "lib/cap_recipes/tasks/juggernaut/hooks.rb", "lib/cap_recipes/tasks/juggernaut/manage.rb", "lib/cap_recipes/tasks/juggernaut.rb", "lib/cap_recipes/tasks/memcache", "lib/cap_recipes/tasks/memcache/hooks.rb", "lib/cap_recipes/tasks/memcache/install.rb", "lib/cap_recipes/tasks/memcache/manage.rb", "lib/cap_recipes/tasks/memcache.rb", "lib/cap_recipes/tasks/passenger", "lib/cap_recipes/tasks/passenger/install.rb", "lib/cap_recipes/tasks/passenger/manage.rb", "lib/cap_recipes/tasks/passenger.rb", "lib/cap_recipes/tasks/rails", "lib/cap_recipes/tasks/rails/hooks.rb", "lib/cap_recipes/tasks/rails/manage.rb", "lib/cap_recipes/tasks/rails.rb", "lib/cap_recipes/tasks/with_scope.rb", "lib/cap_recipes.rb", "spec/cap", "spec/cap/all", "spec/cap/all/Capfile", "spec/cap/helper.rb", "spec/cap_recipes_spec.rb", "spec/spec_helper.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nesquena/cap-recipes}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Battle-tested capistrano recipes for passenger, apache, and more}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
