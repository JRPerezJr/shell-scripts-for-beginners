#!/bin/bash

function add(){
  sum=$(( $1 + $2 ))
}

result=$(add 3 5)

# Solve print error
function add(){
  return $(( $1 + $2 ))
}

add 3 5

echo "The result is result $?"