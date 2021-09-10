puts "I am going to read my own code:"
puts "Reading file: #{ __FILE__}"
puts "........"
def read_self
 File.open(__FILE__, "r") do |file|
  file.each do |line|
    puts line
  end
 end
end

puts read_self