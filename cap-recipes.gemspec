# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cap-recipes}
  s.version = "0.2.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Esquenazi"]
  s.date = %q{2009-02-03}
  s.description = %q{Battle-tested capistrano recipes for passenger, apache, and more}
  s.email = %q{nesquena@gmail.com}
  s.files = ["README.textile", "VERSION.yml", "lib/cap_recipes", "lib/cap_recipes/tasks", "lib/cap_recipes/tasks/apache.rb", "lib/cap_recipes/tasks/backgroundrb.rb", "lib/cap_recipes/tasks/juggernaut.rb", "lib/cap_recipes/tasks/memcache.rb", "lib/cap_recipes/tasks/passenger.rb", "lib/cap_recipes/tasks/with_scope.rb", "lib/cap_recipes.rb", "test/cap_recipes_test.rb", "test/test_helper.rb"]
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
