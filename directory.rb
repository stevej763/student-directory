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
  puts "Enter a letter to filter, otherwise press enter:"
  letter = gets.chomp
  return letter.upcase
end

def get_max_length
  puts "Enter a maximum length for student names in the list:"
  max_length = gets.chomp.to_i
  if max_length == "" ||  max_length == 0
    max_length = 99
  end

  return max_length
end

def print_header
  puts "The students of Villains Academy"
  puts "----------"
end

def print_student_names(max_length, filter, students)
  if filter.length == 1 
    students = filter_student_names_beginning_with(filter, students)
  end
  students = filter_student_names_by_length(max_length, students)
  print_all_student_names_with_while_loop(students)
end

def print_all_student_names(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_all_student_names_with_while_loop(students)
  student_index = 0
  while student_index < students.count
    puts "#{student_index + 1}. #{students[student_index][:name]} (#{students[student_index][:cohort]} cohort)"
    student_index += 1
  end
end



def filter_student_names_beginning_with(filter, students)
  filtered_students = students.select {|student| 
    student[:name].chars.first.upcase == filter
  }
  return filtered_students
end

def filter_student_names_by_length(max_length, students)
  filtered_students = students.select {|student| 
    student[:name].length <= max_length
  } 
  return filtered_students
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end


students = input_students
letter_filter = get_filter
max_length = get_max_length
print_header
print_student_names(max_length, letter_filter, students)
print_footer(students)