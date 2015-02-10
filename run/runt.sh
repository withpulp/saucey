#!/bin/bash

# runt.sh : Use $FUNCNAME
runt(){
  cd ..
  bin/behat --tags "@$1" -p "Local$2" --format html --out "reports/$1.html"
}

runt $1 $2
