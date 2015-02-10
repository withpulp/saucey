#!/bin/bash

# saucy.sh : Use $FUNCNAME
saucy(){
  cd ..
  bin/behat --tags "@$1" -p "Sauce$2$3" --format html --out "reports/$1.html"
}

saucy $1 $2 $3
