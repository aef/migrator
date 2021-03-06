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

# This module implements the interface for an adapter required by Aef::Migrator.
# See also: AbstractAdapter.
module Aef::Migrator::Adapter
  def process(target_version)
    raise NotImplementedError, 'The process method needs to be implemented'
  end

  def revert(target_version)
    raise NotImplementedError, 'The revert method needs to be implemented'
  end

  def version
    raise NotImplementedError, 'The version method needs to be implemented'
  end

  def version=(versions)
    raise NotImplementedError, 'The version= method needs to be implemented'
  end

  def versions
    raise NotImplementedError, 'The versions method needs to be implemented'
  end
end
