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

require 'webmock'
include WebMock::API
WebMock.enable!

require 'minitest/autorun'

require 'code_challenge3'
require 'code_challenge3/logging'

module CodeChallenge3
  class APITest < Minitest::Test
    include Logging

    BASE_URL = 'https://jobs.github.com'
    PATH = '/positions.json'

    def setup
      logger.level = :warn
      @api = API.new(BASE_URL, PATH)
    end

    def teardown
      @api = nil
    end

    def test_request
      stub_request(:get, BASE_URL + PATH).to_return(body: '[]')
      assert_equal('[]', @api.request)
    end

    def test_request_with_loc
      stub_request(:get, BASE_URL + PATH + '?location=Los+Angeles').to_return(body: '[]')
      assert_equal('[]', @api.request(location: 'Los Angeles'))
    end

    def test_request_with_desc
      stub_request(:get, BASE_URL + PATH + '?description=Python').to_return(body: '[]')
      assert_equal('[]', @api.request(description: 'Python'))
    end

    def test_request_with_loc_and_desc
      stub_request(:get, BASE_URL + PATH + '?description=Ruby&location=Boston').to_return(body: '[]')
      assert_equal('[]', @api.request(description: 'Ruby', location: 'Boston'))
    end
  end
end
