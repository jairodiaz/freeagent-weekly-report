require 'bigdecimal'

class Summary
  attr_accessor :result_per_project, :result_per_user
  def initialize
    @result_per_project, @result_per_user = {}, {}
  end
  def count(timeslip)
    @result_per_project[timeslip.project] = (@result_per_project[timeslip.project] || 0) + timeslip.hours
    @result_per_user[timeslip.user] = (@result_per_user[timeslip.user] || 0) + timeslip.hours
  end
  def print_raw
    @result_per_project.each_pair { |k,v| puts "project: #{k}, total hours: #{sprintf '%.1f', v}" }
    @result_per_user.each_pair { |k,v| puts "project: #{k}, total hours: #{sprintf '%.1f', v}" }
  end
  def total
    @result_per_project.inject(0) { |sum, pair| sum + pair[1]; }
  end
end

if __FILE__==$0
  # Simple unit test
  class Timeslip
    attr_accessor :project, :user, :hours
    def initialize(project, user, hours)
      @project = project
      @hours = hours
      @user = user
    end
  end
  p = Summary.new
  p.count Timeslip.new('project1', 'me', 10)
  p.count Timeslip.new('project2', 'you', 5)
  p.count Timeslip.new('project1', 'you', 2)
  p.print_raw
  puts "Total hours: #{p.total}"
end
