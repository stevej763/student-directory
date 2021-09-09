
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex Delarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddie Kruger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]

def print_header
  puts "The students of VIllains Academy"
  puts "----------"
end

def print_student_names(students)
  students.each do |student|
    puts student
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

print_header
print_student_names(students)
print_footer(students)