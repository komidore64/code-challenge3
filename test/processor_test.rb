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

require 'json'

require 'test_helper'
require 'minitest/autorun'
require 'minitest/mock'

require 'code_challenge3'
require 'code_challenge3/logging'

module CodeChallenge3
  class ProcessorTest < Minitest::Test
    def setup; end

    def teardown; end

    def test_gather_data
      mockapi = MiniTest::Mock.new
      mockapi.expect(:request, TestHelper.fixture('boston_ruby.json'), [{ location: 'Boston', description: 'Ruby' }])
      processor = Processor.new(locations: ['Boston'], descriptions: ['Ruby'], api: mockapi)

      expected = {
        'Boston' => {
          'Ruby' => 0
        }
      }
      assert_equal(expected, processor.send(:gather_data))
    end

    def test_gather_location_data
      mockapi = MiniTest::Mock.new
      mockapi.expect(:request, TestHelper.fixture('boston_ruby.json'), [{ location: 'Boston', description: 'Ruby' }])
      processor = Processor.new(locations: ['Boston'], descriptions: ['Ruby'], api: mockapi)

      expected = {
        'Ruby' => 0
      }
      assert_equal(expected, processor.send(:gather_location_data, 'Boston'))
    end

    def test_acquire_job_listings
      mockapi = MiniTest::Mock.new
      mockapi.expect(:request, TestHelper.fixture('boston_ruby.json'), [{ location: 'Boston', description: 'Ruby' }])
      processor = Processor.new(locations: ['Boston'], descriptions: ['Ruby'], api: mockapi)

      expected = []
      assert_equal(expected, processor.send(:acquire_job_listings, 'Boston', 'Ruby'))
    end
  end
end
