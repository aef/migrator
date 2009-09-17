# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{migrator}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexander E. Fischer"]
  s.date = %q{2009-09-17}
  s.description = %q{Migrator is a Ruby library for building general purpose versioning systems in
the style of ActiveRecord's migrations.}
  s.email = ["aef@raxys.net"]
  s.extra_rdoc_files = ["Manifest.txt", "History.txt", "README.rdoc"]
  s.files = ["lib/aef/migrator/adapter.rb", "lib/aef/migrator/migrator.rb", "lib/aef/migrator/abstract_adapter.rb", "lib/aef/migrator.rb", "Manifest.txt", "History.txt", "Rakefile", ".autotest", "spec/spec_helper.rb", "spec/mock_adapter.rb", "spec/spec.opts", "spec/migrator_spec.rb", "README.rdoc"]
  s.homepage = %q{https://rubyforge.org/projects/migrator/}
  s.rdoc_options = ["--main", "README.rdoc", "--inline-source", "--line-numbers", "--title", "Migrator"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{migrator}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Migrator is a Ruby library for building general purpose versioning systems in the style of ActiveRecord's migrations.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.8"])
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
  end
end
