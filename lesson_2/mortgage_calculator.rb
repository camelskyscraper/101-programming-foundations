
# Get three pieces of information:
# - the loan amount
# - the APR (annual percentage rate)
# - the loan duration

# Calculate:
# - monthly interest rate
# - loan duration in months

# Use the formula:
# m = p * (j / (1 - (1 + j)**(-n)))
# where
# m = monthly payment
# p = loan amount
# j = monthly interest rate
# n = loan duration in months

# Pseudo-code

# Ask for the loan amount (number)
#   validate, accounting for commas, dollar signs, etc
# Ask for the APR in percentage (X.X%)
#   validate
#   convert to 0.XXX format
# Ask for the loan duration (in years)
#   validate

# Calculate loan duration in months (loan duration in years * 12)
# Calculate the monthly interest rate (APR / 12)
# Calculate the monthly payment

# Output the montly payment
# Output the number of months

# http://stackoverflow.com/questions/3730019/why-not-use-double-or-float-to-represent-currency
# tells me to use an integer with cents to represent money
# e.g. 1025 = $10.25

def prompt(message)
  puts "$-> #{message}"
end

def error(message)
  puts "ERROR: #{message}"
end

def input_money
  input = 0
  loop do
    input = sanitize_money(gets.chomp).to_f
    break if input > 0
    error("Please enter a non-zero number.")
  end
  (input * 100).to_i # store the money as cents
end

def sanitize_money(string)
  output = ''
  string.chars.each do |letter|
    # strip out certain characters
    output << letter unless ['$', ',', ' '].include?(letter)
  end
  output
end

def input_float
  loop do
    input = gets.chomp().to_f
    return input if valid_number?(input)
    error("Please enter a non-zero number.")
  end
end

def valid_number?(number)
  ![0, 0.0].include?(number)
end

def display_money(value_in_cents)
  value = (value_in_cents.to_i * 0.01) # convert to dollars
  value = format('%.2f', value).to_s # make sure there are two decimal places
  # add commas (in a convoluted way)
  dollars, cents = value.split('.')
  dollars = dollars.reverse.scan(/.{1,3}/) # create groups of 3 after reversing
  value = dollars.join(',').reverse + '.' + cents
  # holla
  "$" + value
end

# I'd like to use more descriptive argument names
# but rubocop is sqawking at me for line length
def get_monthly_payment(loan_amount, j, n)
  # m = p * (j / (1 - (1 + j)**(-n)))
  # m: monthly payment
  # p: loan amount
  # j: monthly interest rate
  # n: loan duration in months
  loan_amount * (j / (1 - (1 + j)**-n))
end

# welcome
puts("---")
prompt("MORTGAGE CALCULATOR TIME!")

# loan amount
prompt("What is your total loan amount?")
loan_amount = input_money
prompt("Okay, great. Your loan amount is #{display_money(loan_amount)}.")

# apr
prompt("Now, what is your Annual Percentage Rate (APR)?")
prompt("Please enter numbers only, as percentage points (e.g. 5 for 5%)")
apr_display = input_float
prompt("Okay, your APR is #{apr_display}%")

# loan length
prompt("What is the length of your loan (in years)?")
years = input_float
years_display = years.to_i
prompt("Got it, your loan length is #{years_display} years.")

# calculations
apr = apr_display * 0.01
months = years * 12.0
monthly_interest_rate = apr / 12.0
monthly_payment = \
  get_monthly_payment(loan_amount, monthly_interest_rate, months)

# output
prompt("Calculating your numbers now...")
sleep 1
prompt("Looks like you'll be paying #{display_money(monthly_payment)}" \
" per month for #{months.to_i} months.")
prompt("Over #{years_display} years you'll pay #{display_money(monthly_payment * months)}.")
