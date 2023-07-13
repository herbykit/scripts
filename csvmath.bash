#! /bin/env fish

# Checking if the argument is correct. Ignores arguments outside of the first.
if test (count $argv) = 0
  # There was no argument given.
  echo "Dude, I'm starving. Don't tease me like this."
  echo "Usage: ./csvmath.bash <filename.csv"
  exit 404
else if not string match -q '*.csv' $argv[1]
  # The argument is not a CSV file.
  echo "I can't eat that. Why aren't you giving me a csv to eat?"
  echo "Usage: ./csvmath.bash <filename.csv>"
  exit 400
else if not test -f $argv[1]
  # The file given in the argument does not exist.
  echo "I'm hungry. How dare you taunt me like this."
  echo "Usage: ./csvmath.bash <filename.csv>"
  exit 400
end

# Breaking up the line into each number
set line (string split -r "," (cat $argv[1]))

# Initialising the total variable with 0
set total 0

for num in $line
  # Adding each number to the total one by one
  set total (math "$total + $num")
end

# Returning the total to be used elsewhere
echo $total
