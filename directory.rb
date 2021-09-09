def display_centered_text(text)
  display_centered_text_with_symbol(text, "-")
end

def display_centered_text_with_symbol(text, symbol)
  puts text.center(50, symbol)
end

def display_intro
  puts
  display_centered_text_with_symbol("", "*")
  display_centered_text("VILLAINS ACADEMY STUDENT DIRECTORY")
  display_centered_text_with_symbol("", "*")
  puts
  display_centered_text_with_symbol("", ".")
  display_centered_text("Please enter the names of the students")
  display_centered_text("you wish to register")
  display_centered_text_with_symbol("", ".")
  display_centered_text("To finish, press option 2")
  display_centered_text_with_symbol("", ".")
  display_centered_text_with_symbol("", " ")
end

def get_input(instruction)
  response = ""
  while response == ""
    print instruction
    response = gets.chomp
  end
  return response
end

def get_student_details
  name = get_input("Student Name:")
  age = get_input("Student age:").to_i
  height = get_input("Student height:").to_f
  cohort = get_input("Student cohort:")
  hobbies = get_input("List of hobbies:")
  student = {name: name, age: age, height: height, cohort: cohort.to_sym, hobbies: hobbies}
  return student
end

def input_students
  should_exit = false
  students = []
  display_intro
  loop do
    puts "Enter the corresponding number for the command"
    puts "1. Add new student"
    puts "2. Exit student creation"

    gets.chomp.to_i == 2 ? break : nil

    new_student = get_student_details
    students << new_student
    puts
    display_centered_text("There are now #{students.count} registered students")
    puts
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
  puts "-----------------".center(20)
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
    puts "#{index + 1}. name:#{student[:name]} age:#{student[:age]} (#{student[:cohort]} cohort)"
  end
end

def print_all_student_names_with_while_loop(students)
  student_index = 0
  while student_index < students.count
    puts "#{student_index + 1}. #{students[student_index][:name]} age:#{student[:age]} height: #{students[student_index][:height]} (#{students[student_index][:cohort]} cohort)"
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