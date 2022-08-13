#!/bin/bash 

# Anything which start with # is a comment
<<COM
echo "Demo on multi line comment"
a=10
echo $a
COM
echo "We could not print because lines were inside multiline comment block COM"