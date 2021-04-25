# frozen_string_literal: true

# code-challenge3
# Copyright (C) 2021  M. Adam Price
#
# This program is free software: you can redistribute it and/or modify
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
#

require 'net/http'

require 'code_challenge3/logging'

module CodeChallenge3
  # API class
  #
  # The API wraps all the requests to jobs.github.com
  class API
    include Logging

    def initialize(base_url, path)
      @base_url = base_url
      @path = path
      logger.debug("API initialized [ base_url: #{base_url}, path: #{path} ]")
    end

    def request(**query)
      uri = URI(@base_url)
      uri.path = @path
      uri.query = URI.encode_www_form(query) unless query.empty?

      logger.debug("API: sending request [ #{uri} ]")
      Net::HTTP.get(uri)
    end
  end
end
