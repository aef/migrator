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

# This class implements the interface for an adapter required by Aef::Migrator
# and could be used as an abstract base class. See also: Adapter
class Aef::Migrator::AbstractAdapter
  include Aef::Migrator::Adapter

  def initialize
    raise NotImplementedError, 'Abstract class' if self.class == Aef::Migrator::AbstractAdapter
  end
end
