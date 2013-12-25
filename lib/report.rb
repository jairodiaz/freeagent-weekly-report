require 'freeagent'
require 'pry'
require 'dotenv'
Dotenv.load

require_relative 'date_helper'
require_relative 'freeagent_helper'
require_relative 'project_summary'

puts 'Retrieving weekly timesheet entries...'

# Follow instructions from https://dev.freeagent.com/docs/quick_start
FreeAgent.environment = :production #:sandbox #:production
FreeAgent.access_details(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], ENV['ACCESS_TOKEN'])

report_date = week_for(DateTime.now-7)
timeslips = FreeAgent::Timeslip.filter(:from_date => report_date)

summary = ProjectSummary.new

timeslips.each { |timeslip| summary.count(timeslip) }
puts "Date Range: #{report_date.sub(/&to_date=/,' to ')}"
puts "*" * 30
puts "Hours per Project"
summary.result.each_pair { |p,h| puts "Project: #{project(p).name}, Total hours: #{sprintf '%.1f', h}" }
puts "Total hours: #{sprintf '%.1f', summary.total}"
puts "*" * 30
