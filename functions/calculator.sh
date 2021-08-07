#!/bin/bash

function read_numbers(){
    read -p "Enter Number1: " num1
    read -p "Enter Number2: " num2
    return $(( "$num1 $1 $num2" ))
}

while true
do
  echo "1. Add"
  echo "2. Subtract"
  echo "3. Multiply"
  echo "4. Divide"
  echo "5. Quit"

  read -p "Enter your choice: " choice

  case $choice in
    1)  read_numbers +
        echo Answer is $(( $? )) ;;
    2)
        read_numbers -
        echo Answer is $(( $? )) ;;

    3)
        read_numbers *
        echo Answer is $(( $? )) ;;
    4)
        read_numbers /
        echo Answer is $(( $? )) ;;
    5)
        break
        ;;
  esac

done

# Version that works

#!/bin/bash

function read_numbers(){
  read -p "Enter Number1: " number1
  read -p "Enter Number2: " number2
}

while true
do
  echo "1. Add"
  echo "2. Subtract"
  echo "3. Multiply"
  echo "4. Divide"
  echo "5. Quit"

  read -p "Enter your choice: " choice

  case $choice in
    1)  read_numbers
        echo $(( $number1 + $number2 )) ;;
    2)
        read_numbers
        echo $(( $number1 - $number2 )) ;;

    3)
        read_numbers
        echo $(( $number1 * $number2 )) ;;

    4)
        read_numbers
        echo $(( $number1 / $number2 )) ;;

    5)  break
  esac

done