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

require 'code_challenge3/logging'
require 'code_challenge3/api'

module CodeChallenge3
  # Processor class
  #
  # The Processor submits requests to the API class, analyzes the data, and
  # finally generates the pretty output.
  class Processor
    include Logging

    def initialize(api:, locations: [], descriptions: [], log_level: :warn)
      @locations = locations
      @descriptions = descriptions
      @api = api

      logger.level = log_level
    end

    def process!
      @raw_data = gather_data
      @extrapolated_data = analyze_data(@raw_data)
      pretty_print_results(@extrapolated_data)
    end

    private

    def gather_data
      data = {}
      @locations.each do |loc|
        data[loc] = gather_location_data(loc)
      end
      data
    end

    def analyze_data(input_data)
      data = Marshal.load(Marshal.dump(input_data)) # deep copy

      prune_zeroes(data)
      prune_empty_locations(data)
      total_jobs = deep_sum_jobs(data)

      job_percentages(total_jobs, data)
    end

    def pretty_print_results(data)
      data.each do |location, loc_data|
        puts("#{location}:")
        pretty_print_location_results(loc_data)
      end
    end

    def gather_location_data(loc)
      loc_data = {}
      @descriptions.each do |desc|
        loc_data[desc] = acquire_job_listings(loc, desc).size
      end
      loc_data
    end

    def acquire_job_listings(location, description)
      query_hash = {
        location: location,
        description: description
      }

      JSON.parse(@api.request(query_hash))
    end

    def analyze_location_data(total, location_data)
      metrics = {}

      location_data.each do |lang, count|
        percent = (100.to_f * count / total) # force 100 to a float, otherwise the division gets truncated
        metrics[lang] = percent.round
      end
      metrics
    end

    def prune_zeroes(data)
      data.each_key do |location|
        data[location].delete_if { |_, count| count.zero? }
      end
    end

    def prune_empty_locations(data)
      data.delete_if do |_, loc_data|
        loc_data.empty?
      end
    end

    def deep_sum_jobs(data)
      data.reduce(0) do |sum, (_, loc_data)|
        sum + loc_data.reduce(0) { |isum, (_, count)| isum + count }
      end
    end

    def job_percentages(total_jobs, data)
      metrics = {}
      data.each do |location, loc_data|
        metrics[location] = analyze_location_data(total_jobs, loc_data)
      end
      metrics
    end

    def pretty_print_location_results(data)
      data.each do |lang, percentage|
        puts("  - #{lang}: #{percentage}%")
      end
    end
  end
end
