require 'date'

def this_monday(today)
  day = today.strftime("%a")
  today - { 'Mon' => 0, 'Tue' => 1, 'Wed' => 2, 'Thu' => 3, 'Fri' => 4, 'Sat' => 5, 'Sun' => 6 }[day]
end

def this_sunday(today)
  day = today.strftime("%a")
  today + { 'Mon' => 6, 'Tue' => 5, 'Wed' => 4, 'Thu' => 3, 'Fri' => 2, 'Sat' => 1, 'Sun' => 0}[day]
end

def week_for(today)
  "#{this_monday(today).strftime("%Y-%m-%d")}&to_date=#{this_sunday(today).strftime("%Y-%m-%d")}"
end

if __FILE__==$0
  d = DateTime.now
  puts "today is #{d}"
  puts "this monday is #{this_monday(d)}"
  puts "this sunday is #{this_sunday(d)}"
  puts week_for(d)
end
