# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/migrator.rb'

Hoe.new('migrator', Aef::Migrator::VERSION) do |p|
  p.rubyforge_name = 'aef'
  p.developer('Alexander E. Fischer', 'aef@raxys.net')
  p.extra_dev_deps = %w{rspec}
  p.url = 'https://rubyforge.org/projects/aef/'
  p.readme_file = 'README.rdoc'
  p.extra_rdoc_files = %w{README.rdoc}
  p.spec_extras = {
    :rdoc_options => ['--main', 'README.rdoc', '--inline-source', '--line-numbers', '--title', 'Migrator']
  }
end

# vim: syntax=Ruby
