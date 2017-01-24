
=begin
Get three pieces of information:
- the loan amount
- the APR (annual percentage rate)
- the loan duration

Calculate:
- monthly interest rate
- loan duration in months

Use the formula:
m = p * (j / (1 - (1 + j)**(-n)))
where
m = monthly payment
p = loan amount
j = monthly interest rate
n = loan duration in months

Pseudo-code

Ask for the loan amount (number)
  validate, accounting for commas, dollar signs, etc
Ask for the APR in percentage (X.X%)
  validate
  convert to 0.XXX format
Ask for the loan duration (in years)
  validate

Calculate loan duration in months (loan duration in years * 12)
Calculate the monthly interest rate (APR / 12)
Calculate the monthly payment

Output the montly payment
Output the number of months


http://stackoverflow.com/questions/3730019/why-not-use-double-or-float-to-represent-currency
tells me to use an integer with cents to represent money
e.g. 1025 = $10.25

=end

def prompt(message)
  puts "$-> #{message}"
end

def is_integer?(input)
  input == input.to_i.to_s
end

def is_valid_number?(number)
  not [0, 0.0].include?(number)
end

def format_money(float)
  '%.2f' % float
end

def display_money(value_in_cents)
  "$" + (value_in_cents.to_i * 0.01).to_s
end

def get_float
  loop do
    input = gets.chomp().to_f
    if is_valid_number?(input)
      return input
    end
    prompt("Hmm... that number was invalid. Please try again.")
  end
end

def get_monthly_payment(loan_amount, monthly_interest_rate, duration_in_months)
  # m = p * (j / (1 - (1 + j)**(-n)))
  loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-duration_in_months)))
end


puts("---")
prompt("MORTGAGE CALCULATOR TIME!")

prompt("What is your total loan amount? (numbers only, please)")
loan_amount = get_float
prompt("Okay, great. Your loan amount is $#{format_money(loan_amount)}.")

prompt("Now, what is your Annual Percentage Rate (APR)?")
prompt("Please enter numbers only, as percentage points (e.g. 5 for 5%)")
apr_display = get_float
prompt("Okay, your APR is #{apr_display}%")

prompt("What is the length of your loan (in years)?")
years = get_float
years_display = years.to_i
prompt("Got it, your loan length is #{years_display} years.")

# re-calculating...
apr = apr_display * 0.01
months = years * 12.0
monthly_interest_rate = apr / 12.0
monthly_payment = get_monthly_payment(loan_amount, monthly_interest_rate, months)

prompt("Calculating your numbers now...")
sleep 2

prompt("Looks like you'll be paying $#{format_money(monthly_payment)} per month for #{months.to_i} months.")