require 'freeagent'
require 'pry'
require 'dotenv'
Dotenv.load

require_relative 'date_helper'
require_relative 'freeagent_helper'
require_relative 'summary'

puts 'Retrieving weekly timesheet entries...'

# Follow instructions from https://dev.freeagent.com/docs/quick_start
FreeAgent.environment = :production #:sandbox #:production
FreeAgent.access_details(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], ENV['ACCESS_TOKEN'])

report_date = week_for(DateTime.now - (ENV['WEEKS_AGO'].to_i * 7))
timeslips = FreeAgent::Timeslip.filter(:from_date => report_date[0], :to_date => report_date[1])

summary = Summary.new

timeslips.each { |timeslip| summary.count(timeslip) }
puts "Date Range: #{report_date[0]} to #{report_date[1]}"
puts "*" * 30
puts "Hours per Project"
summary.result_per_project.each_pair { |p,h| puts "Project: #{project(p).name}, Total hours: #{sprintf '%.1f', h}" }
puts "Total hours: #{sprintf '%.1f', summary.total}"
puts "*" * 30
puts "Hours per User"
summary.result_per_user.each_pair { |u,h| puts "User: #{user(u).first_name} #{user(u).last_name}, Total hours: #{sprintf '%.1f', h}" }
