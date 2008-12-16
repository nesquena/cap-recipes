# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cap-recipes}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Esquenazi"]
  s.date = %q{2008-12-16}
  s.email = %q{nesquena@gmail.com}
  s.files = ["Rakefile", "README.textile", "lib/cap_recipes/tasks/apache.rb", "lib/cap_recipes/tasks/backgroundrb.rb", "lib/cap_recipes/tasks/juggernaut.rb", "lib/cap_recipes/tasks/passenger.rb", "lib/cap_recipes.rb", "spec/cap-recipes-spec.rb"]
  s.homepage = %q{http://caprecipes.rubyforge.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{cap-recipes}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Collection of capistrano recipes for apache, passenger, juggernaut and backgroundrb}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
