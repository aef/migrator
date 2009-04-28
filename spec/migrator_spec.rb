# Copyright 2009 Alexander E. Fischer <aef@raxys.net>
#
# This file is part of Migrator.
#
# Migrator is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'lib/migrator'
require 'spec/mock_adapter'

describe Aef::Migrator do
  before(:all) do
    class BrokenAdapter < described_class::AbstractAdapter
      undef :process
    end
  end

  before(:each) do
    @adapter = MockAdapter.new
    @adapter.verbose = false
    @migrator = described_class.new(@adapter)
  end

  it "should complain about invalid direction params" do
    lambda {
      @migrator.migrate('a', :invalid)
    }.should raise_error(ArgumentError)
  end

  it "should complain when no adapter is set" do
    lambda {
      @migrator.adapter = nil
      @migrator.migrate('a')
    }.should raise_error(described_class::AdapterMissingError)
  end

  it "should complain about missing adapter methods" do
    lambda {
      @migrator.adapter = BrokenAdapter.new
      @migrator.migrate('a')
    }.should raise_error(described_class::AdapterMethodMissingError)
  end

  it "should complain about current versions which are not in versions" do
    lambda {
      @adapter.version = 'f'
      @migrator.migrate('a')
    }.should raise_error(described_class::CurrentVersionInvalidError)
  end

  it "should complain about target versions which are not in versions" do
    lambda {
      @migrator.migrate('invalid')
    }.should raise_error(described_class::TargetVersionInvalidError)
  end

  it "should complain about migrating to the current version" do
    lambda {
      @migrator.migrate('c')
    }.should raise_error(described_class::MigrationUnneccessaryError)
  end

  it "should be able to implicitly migrate one version up" do
    lambda {
      @migrator.up
    }.should change{@migrator.version}.from('c').to('d')
  end

  it "should be able to implicitly migrate one version down" do
    lambda {
      @migrator.down
    }.should change{@migrator.version}.from('c').to('b')
  end

  it "should be able to explicitly migrate one version up" do
    lambda {
      @migrator.up('d')
    }.should change{@migrator.version}.from('c').to('d')
  end

  it "should be able to explicitly migrate one version down" do
    lambda {
      @migrator.down('b')
    }.should change{@migrator.version}.from('c').to('b')
  end

  it "should be able to migrate multiple version up with one call" do
    lambda {
      @migrator.up('e')
    }.should change{@migrator.version}.from('c').to('e')
  end

  it "should be able to migrate multiple version down with one call" do
    lambda {
      @migrator.down('a')
    }.should change{@migrator.version}.from('c').to('a')
  end

  it "should prohibit migration in wrong direction when up method is used" do
    lambda {
      @migrator.up('a')
    }.should raise_error(described_class::UpMigrationInvalidError)
  end

  it "should prohibit migration in wrong direction when down method is used" do
    lambda {
      @migrator.down('e')
    }.should raise_error(described_class::DownMigrationInvalidError)
  end

  it "should allow up migration with generic migrate method" do
    lambda {
      @migrator.migrate('e')
    }.should change{@migrator.version}.from('c').to('e')
  end

  it "should allow down migration with generic migrate method" do
    lambda {
      @migrator.migrate('a')
    }.should change{@migrator.version}.from('c').to('a')
  end

  it "should complain about invalid direction params when migratable? is called" do
    lambda {
      @migrator.migratable?('a', :invalid)
    }.should raise_error(ArgumentError)
  end

  it "should complain when no adapter is set when migratable? is called" do
    lambda {
      @migrator.adapter = nil
      @migrator.migrate('a')
    }.should raise_error(described_class::AdapterMissingError)
  end

  it "should complain about missing adapter methods when migratable? is called" do
    lambda {
      @migrator.adapter = BrokenAdapter.new
      @migrator.migratable?('a')
    }.should raise_error(described_class::AdapterMethodMissingError)
  end

  it "should complain about current versions which are not in versions when migratable? is called" do
    lambda {
      @adapter.version = 'f'
      @migrator.migratable?('a')
    }.should raise_error(described_class::CurrentVersionInvalidError)
  end

  it "should indicate that a migration to an invalid target version is impossible" do
    @migrator.migratable?('invalid').should be_false
  end

  it "should indicate that implicitly migrating one version up is possible" do
    @migrator.upable?.should be_true
  end

  it "should indicate that implicitly migrating one version down is possible" do
    @migrator.downable?.should be_true
  end

  it "should indicate that migrating one version up is possible" do
    @migrator.upable?('d').should be_true
  end

  it "should indicate that migrating one version down is possible" do
    @migrator.downable?('b').should be_true
  end

  it "should indicate that a multi-step migration up is possible" do
    @migrator.upable?('e').should be_true
  end

  it "should indicate that a multi-step migration down is possible" do
    @migrator.downable?('a').should be_true
  end

  it "should indicate a wrong direction migration is impossible when upable? method is used" do
    @migrator.upable?('a').should be_false
  end

  it "should indicate a wrong direction migration is impossible when downable? method is used" do
    @migrator.downable?('e').should be_false
  end

  it "should indicate that up migration is possible when migratable? method is used" do
    @migrator.migratable?('e').should be_true
  end

  it "should indicate that down migration is possible when migratable? method is used" do
    @migrator.migratable?('a').should be_true
  end

  it "should return itself for method changing through method migrate" do
    @migrator.migrate('d').should eql(@migrator)
  end

  it "should return itself for method changing through method up" do
    @migrator.up.should eql(@migrator)
  end

  it "should return itself for method changing through method down" do
    @migrator.down.should eql(@migrator)
  end
end
