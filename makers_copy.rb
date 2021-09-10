@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_list_of_students
  when "3"
    save_students_to_csv
  when "4"
    load_students_from
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def insert_student_into_directory(student)
  @students << student
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    student = {name: name, cohort: :november}
    insert_student_into_directory(student)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def show_list_of_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students_to_csv
  print"save as (blank for default 'students.csv'):"
  file_name = STDIN.gets.chomp
  if file_name == ""
    file_name == "students.csv"
  elsif file_name.chars.last(4).join('') != ".csv"
    file_name += ".csv"
  end
  puts "Saving students to #{file_name}..."
  # open the file for writing
  File.open(file_name, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
  # iterate over the array of students
  
  puts "#{file_name}.csv saved!"
  file.close
end

def load_students_from
  print"load from (blank for default 'students.csv'):"
  file_name = STDIN.gets.chomp
  if file_name == " "
    file_name == "students.csv"
  end
    load_file_if_exists(file_name) 
end

def load_students_into_directory(filename = "students.csv")
  File.open(filename, "r") do |lines|
    lines.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      student = {name: name, cohort: cohort.to_sym}
      insert_student_into_directory(student)
    end
  end
  puts "We now have #{@students.count} in the directory"
end

def load_file_if_exists(filename)
  if File.exists?(filename) # if it exists
    load_students_into_directory(filename)
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def try_load_students
  filename = ARGV.first# first argument from the command line
  if filename.nil?
    filename = "students.csv"
  end
  load_file_if_exists(filename)
end

try_load_students
interactive_menu