require 'bigdecimal'

class ProjectSummary
  attr_accessor :result
  def initialize
    @result = {}
  end
  def count(timeslip)
    result[timeslip.project] = (result[timeslip.project] || 0) + timeslip.hours
  end
  def print_raw
    @result.each_pair { |k,v| puts "project: #{k}, total hours: #{sprintf '%.1f', v}" }
  end
  def total
    @result.inject(0) { |sum, pair| sum + pair[1]; }
  end
end

if __FILE__==$0
  # Simple unit test
  class Timeslip
    attr_accessor :project, :hours
    def initialize(project, hours)
      @project = project
      @hours = hours
    end
  end
  p = ProjectSummary.new
  p.count Timeslip.new('project1', 10)
  p.count Timeslip.new('project2', 5)
  p.count Timeslip.new('project1', 2)
  p.print_raw
  puts "Total hours: #{p.total}"
end
