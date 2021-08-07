to_number=$1
number=0
while [ $number -lt $to_number ]; do
  echo $(( number++ ))
done