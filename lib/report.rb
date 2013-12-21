require 'freeagent'
require 'pry'
require 'dotenv'
Dotenv.load

require_relative 'date_helper'
require_relative 'freeagent_helper'

puts 'Retrieving weekly timesheet entries...'

FreeAgent.environment = :sandbox #:production
FreeAgent.access_details(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], ENV['ACCESS_TOKEN'])

projects = FreeAgent::Project.all

projects.each do |project|
  puts project.name
end

timeslips = FreeAgent::Timeslip.all

timeslips.each do |timeslip|
  puts timeslip.user
  puts timeslip.project
  puts timeslip.task
  puts timeslip.comment
  puts sprintf "%.1f", timeslip.hours

  # puts user(timeslip.user).first_name
  # puts project(timeslip.project).name
  # puts task(timeslip.task).name
  puts '-' * 10
end