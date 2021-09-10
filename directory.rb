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
  display_centered_text("Please follow the instructions on screen")
  display_centered_text_with_symbol("", ".")
  display_centered_text("To exit, press option 9")
  display_centered_text_with_symbol("", ".")
  display_centered_text_with_symbol("", " ")
end

def save_students(students)
  file = File.open("students.csv", "w")
  students.each do |student|
    student_data = [student[:name], student[:age], student[:height], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  students = []
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, age, height, cohort = line.chomp.split(",")
    students << {name: name, age: age.to_i, height: height.to_f, cohort: cohort.to_sym}
  end
  file.close
  return students
end

def request_order_by_cohort
  display_centered_text("Order By Cohort?")
  puts "1. Yes"
  puts "2. No"
  response = gets.chomp
  return response == "1" ? true : false
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
  student = {name: name, age: age, height: height, cohort: cohort.to_sym}
  return student
end

def get_filter
  letter = ""
  puts "Enter a letter to filter, otherwise press enter:"
  letter = gets.strip
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
  display_centered_text("The students of Villains Academy")
  display_centered_text("-----------------")
end

def print_student_names(order_by_cohort, max_length, filter, students)
  if order_by_cohort
    print_all_student_names_by_cohort(students)
  elsif filter.length == 1 
    students = filter_student_names_beginning_with(filter, students)
    students = filter_student_names_by_length(max_length, students)
    print_all_student_names_with_while_loop(students)
  else
    print_all_student_names_with_while_loop(students)
  end
end

def print_all_student_names_by_cohort(students)
  cohorts = {}
  students.each do |student|
    name = student[:name]
    cohort = student[:cohort]
    if cohorts[cohort] == nil
      cohorts[cohort] = [name]
    else
      cohorts[cohort] << name
    end
  end
  format_and_display_student_names_by_cohort(cohorts)
end

def format_and_display_student_names_by_cohort(cohorts)
  cohorts.each do |cohort, students|
    display_centered_text("#{cohort} cohort")
    students.each do |student|
      puts student
    end
  end
end

def print_all_student_names(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. name:#{student[:name]} age:#{student[:age]} (#{student[:cohort]} cohort)"
  end
end

def print_all_student_names_with_while_loop(students)
  student_index = 0
  while student_index < students.count
    puts "#{student_index + 1}. #{students[student_index][:name]} age: #{students[student_index][:age]} height: #{students[student_index][:height]} (#{students[student_index][:cohort]} cohort)"
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
  if students.length == 1
    display_centered_text("Overall, we have #{students.count} great student")
  else
    display_centered_text("Overall, we have #{students.count} great students")
  end
end

def print_menu_options
  display_centered_text("Menu")
  puts "1. Add new student"
  puts "2. Show student list"
  puts "3. Save the list to students.csv"
  puts "4. Load students from csv"
  puts "9. Exit"
end

def show_student_list(students)
  order_by_cohort = request_order_by_cohort
  letter_filter = get_filter
  max_length = get_max_length
  print_header
  print_student_names(order_by_cohort, max_length, letter_filter, students)
  print_footer(students)
end

def display_student_count(students)
  if students.count == 1
    puts
    display_centered_text("There is now #{students.count} registered student")
    puts
  else
    puts
    display_centered_text("There are now #{students.count} registered students")
    puts
  end
end

def interactive_menu
  students = []
  display_intro
  loop do
    print_menu_options
    selection = gets.chomp
    case selection
      when "1"
        new_student = get_student_details
        students << new_student
        display_student_count(students)
      when "2"
        show_student_list(students)
      when "3"
        save_students(students)
      when "4"
        saved_students = load_students
        students += saved_students
      when "9"
        exit
      else
        puts "Unrecognised command"
      end
  end
  return students
end

interactive_menu
