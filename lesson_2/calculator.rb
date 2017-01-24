# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

# answer = Kernel.gets()
# Kernel.puts(answer)

require 'yaml'

MESSAGES = YAML.load_file('calculator_messages.yml')

puts MESSAGES.inspect

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(number)
  # these are only tests for an integer
  number == number.to_i.to_s
  # number.to_i() != 0
  # /^\d+$/.match(number)
end

def number?(input)
  # accept integers or floats
  input == input.to_f.to_s
  # could regex
end

def get_number(message = "Enter a number")
  loop do
    prompt(message)
    number = Kernel.gets().chomp()
    break if valid_number?(number)
    prompt("Hmm... that doesn't look like a number.")
  end
end

def operation_to_message(op)
  output = case op
           when '1'
             'Adding'
           when '2'
             'Subtracting'
           when '3'
             'Multiplying'
           when '4'
             'Dividing'
           end
  something = '' # just spressin'
  output
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()
  break unless name.empty?()
  prompt(MESSAGES['valid_name'])
end

prompt("Hi, #{name}!")

loop do
  number1 = get_number("What's the first number?")
  number2 = get_number("What's the second number?")

  operator_prompt = <<-MSG
What operation would you like to perform?
  1) add
  2) subtract
  3) multiply
  4) divide
  MSG
  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operator)
    prompt("Must choose 1, 2, 3 or 4")
  end

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           else
             'that you didn\'t enter 1, 2, 3, or 4 to specify the operation'
           end

  prompt("#{operation_to_message(operator)} the numbers...")
  prompt("The result is #{result}")
  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the calculator! Goodbye!")
