# -*- ruby -*-

require 'rubygems'
require 'hoe'

Hoe.spec('migrator') do
  developer('Alexander E. Fischer', 'aef@raxys.net')

  self.rubyforge_name = 'migrator'
  self.extra_dev_deps = {
    'rspec' => '>= 1.2.8'
  }
  self.url = 'https://rubyforge.org/projects/migrator/'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = %w{README.rdoc}
  self.spec_extras = {
    :rdoc_options => ['--main', 'README.rdoc', '--inline-source', '--line-numbers', '--title', 'Migrator']
  }
  self.rspec_options = ['--options', 'spec/spec.opts']
  self.remote_rdoc_dir = ''
end

# vim: syntax=Ruby
