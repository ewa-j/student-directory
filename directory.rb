@students = []

def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end

def print_students_list(students)
  @students.each_with_index { |student, index| 
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)" 
  }
end

def print_footer(students)
  puts "Now we have #{@students.count} great students." if @students.count > 1
  puts "Now we have #{@students.count} great student." if @students.count == 1
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice."

  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Enter the cohort: "
    cohort = STDIN.gets.chomp
    # add the student hash to the array
    if cohort.empty?
      @students << {name: name, cohort: :november}
    else
      @students << {name: name, cohort: cohort}
    end

    # get another name from the user
    name = STDIN.gets.chomp
  end
  # return the array of students
  @students
end

#printing menu
def print_menu
  puts "1. Input the students"
  puts "2. Show the list of students"
  puts "3. Save the list to students.csv"
  puts "4. Load the students.csv file"
  puts "9. Exit"
end

#showing the list of students
def show_students
  print_header
  print_students_list(students)
  print "/n"
  print_footer(students)
end

# saving students to the file
def save_students
  #opening the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

# checking if file exists and loading it
def try_load_students
  filename = ARGV.first # fisrt argument from the command line
  return if filename.nil? # get out of the method if arg is not given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}."
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

# method to load the file
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

# selection for the interactive menu
def process(selection)
  case selection
  when "1"
    @students = input_students
  when "2"
    print_header
    print_students_list(@students)
    print_footer(@students)
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "Invalid entry, please try again"
  end
end

#interactive menu
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end
# calling previously defined methods
interactive_menu