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

require 'rake/testtask'
require 'rubocop/rake_task'
require 'rake/notes/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = Rake::FileList.new(File.join('test', '*_test.rb'))
  t.verbose = true
  t.options = '-v'
end

RuboCop::RakeTask.new(:lint) do |t|
  t.options = ['--display-style-guide']
end

task :sep do
  puts
  puts ' -----'
  puts
end

task all: %i[test sep lint]

task default: :all
