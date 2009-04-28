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
  # Baseclass for all Migrator specific exceptions
  class Error < RuntimeError; end

  # Baseclass for exceptions describing adapter errors
  class AdapterError < Error; end
  class AdapterMissingError < AdapterError; end
  class AdapterMethodMissingError < AdapterError; end
  class CurrentVersionInvalidError < AdapterError; end

  # Baseclass for exceptions describing errors while processing migrations
  class MigrationError < Error; end
  class AlreadyOnTopError < MigrationError; end
  class AlreadyOnBottomError < MigrationError; end
  class TargetVersionInvalidError < MigrationError; end
  class UpMigrationInvalidError < MigrationError; end
  class DownMigrationInvalidError < MigrationError; end
  class MigrationUnneccessaryError < MigrationError; end
end
