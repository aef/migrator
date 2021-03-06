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

class MockAdapter < Aef::Migrator::AbstractAdapter
  attr_accessor :version, :versions_hash, :verbose

  def initialize
    @versions_hash = {
      'a' => 'a.version',
      'b' => 'b.version',
      'c' => 'c.version',
      'd' => 'd.version',
      'e' => 'e.version'
    }
    self.version = 'c'
  end

  def process(target_version)
    puts "Migrating from #{version} to #{target_version} (#{versions_hash[target_version]})" if @verbose

    self.version = target_version
  end

  def revert(target_version)
    puts "Unmigrating from #{version} to #{target_version} (#{versions_hash[version]})" if @verbose

    self.version = target_version
  end

  def versions
    versions_hash.keys.sort
  end
end
