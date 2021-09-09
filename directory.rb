
# [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex Delarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddie Kruger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]

def input_students
  students = []
  
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = gets.chomp

  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  return students
end

def get_filter
  letter = ""
  puts "Enter a letter to filter, otherwise press enter"
  letter = gets.chomp
  return letter
end

def print_header
  puts "The students of Villains Academy"
  puts "----------"
end

def print_student_names(filter, students)
  if filter.length == 1 
    return print_student_names_beginning_with(filter, students)
  end
  print_all_student_names(students)

end

def print_all_student_names(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_student_names_beginning_with(filter, students)
  filtered_students = students.select{|student| student[:name].chars.first == filter}
  print_all_student_names(filtered_students)
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end


students = input_students
filter = get_filter
puts "The filter is #{filter}"
print_header
print_student_names(filter, students)
print_footer(students)