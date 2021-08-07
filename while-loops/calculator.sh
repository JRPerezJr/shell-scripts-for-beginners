# Version 1
while true; do
    echo "1. Add"
    echo "2. Subtract"
    echo "3. Multiply"
    echo "4. Divide"
    echo "5. Quit"
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
    read -p "Enter the 1st and 2nd number to add: " number1 number2
    echo "Answer=$(( number1 + number2 ))"
    
    elif [ $choice -eq 2 ]; then
    read -p "Enter 1st and 2nd number to subtract: " number1 number2
    echo "Answer=$(( number1 - number2 ))"
    
    elif [ $choice -eq 3 ]; then
    read -p "Enter 1st and 2nd number to multiply: " number1 number2
    echo "Answer=$(( number1 * number2 ))"
    
    elif [ $choice -eq 4 ]; then
    read -p "Enter 1st and 2nd number to divide: " number1 number2
    echo "Answer=$(( number1 / number2 ))"

    elif [ $choice -eq 5 ]; then
        break

    else
        continue

    fi
done

# Version 2
while true; do
    echo "1. Add"
    echo "2. Subtract"
    echo "3. Multiply"
    echo "4. Divide"
    echo "5. Quit"
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
    read -p "Enter Number1: " number1 
    read -p "Enter Number2: " number2
    echo "Answer=$(( number1 + number2 ))"
    
    elif [ $choice -eq 2 ]; then
    read -p "Enter Number1: " number1 
    read -p "Enter Number2: " number2
    echo "Answer=$(( number1 - number2 ))"
    
    elif [ $choice -eq 3 ]; then
    read -p "Enter Number1: " number1 
    read -p "Enter Number2: " number2
    echo "Answer=$(( number1 * number2 ))"
    
    elif [ $choice -eq 4 ]; then
    read -p "Enter Number1: " number1 
    read -p "Enter Number2: " number2
    echo "Answer=$(( number1 / number2 ))"

    elif [ $choice -eq 5 ]; then
        break

    else
        continue

    fi
done
