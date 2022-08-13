#!/bin/bash 

### A Variable is something whichs holds the values dynamically.

a=10 
# 10 s a string here 
b=abc
d=300


# abc is also a string 

# When to use Double Quotes ??? When your input us having any special characters, then you need to enclose them in QUOTES.

echo $a  # $a is printing the value of a 
echo $b
echo ${b}
echo "The value of c is $c"

echo Value of d is $d    ### Accessing a varianble from shell

# rm -rf /data/${DATA_DIR} ---> /data/

# $a or  ${a}

# Varaibles that are declared inside the scripts are local variables 
# Variables that are declared as shell using export are environment variables. When the values are not consistent and would based on the running, then go with env variables.

# Always, local varaibles > Env Variables 
# Local variables will have higher precedence than ENV Variables
