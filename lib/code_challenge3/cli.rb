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

require 'optparse'

require 'code_challenge3'
require 'code_challenge3/logging'

module CodeChallenge3
  # CLI class
  #
  # This class manages all the CLI mechanisms that the user would interact with
  class CLI
    include Logging

    def initialize
      @options = {
        base_url: 'https://jobs.github.com',
        url_path: '/positions.json',
        locations: ['Boston', 'San Francisco', 'Los Angeles', 'Denver',
                    'Boulder', 'Chicago', 'New York', 'Raleigh'],
        descriptions: ['Java', 'C#', 'Python', 'Swift', 'Objective-C', 'Ruby',
                       'Kotlin', 'Go', 'C++', 'JavaScript'],
        log_level: :warn
      }
    end

    def parse!(input_arr: ARGV)
      optparse = OptionParser.new do |opts|
        opts.banner = 'USAGE: code-challenge3 [OPTIONS]'
        opts.version = "0.0.1 Copyright (C) #{Time.now.year}  M. Adam Price"

        define_base_url_option(opts)
        define_url_path_option(opts)
        define_locations_option(opts)
        define_languages_option(opts)
        define_log_level_option(opts)
      end

      optparse.parse!(input_arr)
    end

    def find_me_a_job!
      processor = Processor.new(
        locations: @options[:locations],
        descriptions: @options[:descriptions],
        api: API.new(@options[:base_url], @options[:url_path], log_level: @options[:log_level]),
        log_level: @options[:log_level]
      )
      processor.process!
    end

    private

    def define_base_url_option(opts)
      opts.on('--base-url URL',
              String,
              'Scheme and hostname of the server to request.',
              "(default: #{@options[:base_url]})") do |base_url|
        @options[:base_url] = base_url
      end
    end

    def define_url_path_option(opts)
      opts.on('--url-path PATH',
              String,
              'Path to request from the server.',
              "(default: #{@options[:url_path]})") do |url_path|
        @options[:url_path] = url_path
      end
    end

    def define_locations_option(opts)
      opts.on('--locations LOCATIONS',
              Array,
              'Comma-seperated list of locations to check for job listings.',
              '(default: Boston, San Francisco, Los Angeles, Denver, Boulder,',
              'Chicago, New York, Raleigh)') do |locations|
        @options[:locations] = locations
      end
    end

    def define_languages_option(opts)
      opts.on('--languages LANGUAGES',
              Array,
              'Comma-seperated list of programming languages to search for.',
              '(default: Java, C#, Python, Swift, Objective-C, Ruby, Kotlin,',
              'Go, C++, JavaScript)') do |languages|
        @options[:descriptions] = languages
      end
    end

    def define_log_level_option(opts)
      opts.on('--log-level LEVEL',
              %i[debug info warn],
              'Set the log level. [debug, info, warn]',
              "(default: #{@options[:log_level]})") do |log_level|
        @options[:log_level] = log_level
      end
    end
  end
end
