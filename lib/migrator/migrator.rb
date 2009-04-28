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

class Aef::Migrator
  attr_accessor :adapter

  def initialize(adapter)
    @adapter = adapter
  end

  # Checks if a migration is possible
  def migratable?(target_version, direction = nil)
    !!migration_steps(target_version, direction)
  rescue MigrationError
    false
  end

  # Checks if an up migration is possible
  def upable?(target_version = nil)
    migratable?(target_version, :up)
  end

  # Checks if a down migration is possible
  def downable?(target_version = nil)
    migratable?(target_version, :down)
  end

  # Process a migration
  #
  # Raises MigratorError in case of invalid actions
  def migrate(target_version, direction = nil)
    params = migration_steps(target_version, direction)

    params[:steps].each do |version|
      @adapter.send(params[:action], version)
    end

    self
  end

  # Process an up migration
  #
  # Raises MigratorError in case of invalid actions
  def up(target_version = nil)
    migrate(target_version, :up)
  end

  # Process a down migration
  #
  # Raises MigratorError in case of invalid actions
  def down(target_version = nil)
    migrate(target_version, :down)
  end

  # Current version
  def version
    @adapter.version
  end

  # All possible versions in correct order
  def versions
    @adapter.versions
  end

  protected

  # Returns a hash with an :action value and a :steps array with all versions
  # to reach the target
  def migration_steps(target_version, direction)
    raise ArgumentError, 'Invalid direction' unless [nil, :up, :down].include?(direction)

    unless @adapter
      raise AdapterMissingError, 'No adapter set'
    else
      Adapter.instance_methods(false).each do |method|
        raise AdapterMethodMissingError, "Adapter must respond to #{method}" unless @adapter.respond_to?(method)
      end
    end

    version_list = versions
    current_version = version

    indices = {:current => version_list.index(current_version)}

    raise CurrentVersionInvalidError, "Current version not in version list: " +
      "'#{current_version}'" unless indices[:current]

    # When direction is set and target_version is unset step up/down by one
    unless target_version
      case direction
      when :up
        step_up = indices[:current] + 1
        raise AlreadyOnTopError, 'Already on highest version' unless step_up < version_list.size
        indices[:target] = step_up
        target_version = version_list[step_up]
      when :down
        step_down = indices[:current] - 1
        raise AlreadyOnBottomError, 'Already on lowest version' unless step_down >= 0
        indices[:target] = step_down
        target_version = version_list[step_down]
      else
        raise ArgumentError, 'No target version specified'
      end
    else
      indices[:target] = version_list.index(target_version)

      raise TargetVersionInvalidError, 'Target version not in version list: ' +
        "'#{target_version}'" unless indices[:target]
    end

    if indices[:current] < indices[:target]
      raise DownMigrationInvalidError, "Current version '#{current_version}' " +
        "is lower than '#{target_version}'"  if direction == :down

      indices[:current] += 1
      
      {:action => :process, :steps => version_list[indices.values.min..indices.values.max]}
    elsif indices[:current] > indices[:target]
      raise UpMigrationInvalidError, "Current version '#{current_version}' " +
        "is higher than '#{target_version}'" if direction == :up

      indices[:current] -= 1

      {:action => :revert, :steps => version_list[indices.values.min..indices.values.max].reverse}
    else
      raise MigrationUnneccessaryError, "Current version equals target version: '#{current_version}'"
    end
  end
end
