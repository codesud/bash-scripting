#!/bin/bash 

# Anything which start with # is a comment
<<COMMENT
echo "Demo on multi line comment"
a=10
echo $a
COMMENT
echo "We could not print because lines were inside comment block"