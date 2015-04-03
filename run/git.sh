#!/bin/bash
# Colors!
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
nc='\033[0m' # No Color

# If initializing remotes
if [ "$1" = "init" ]
then
  # init : Use $FUNCNAME
  init(){
    git remote add $2
    git remote add $3
    git remote add $4
    git remote add $5
  }
  init $1 $2 $3 $4 $5
  echo -e "gitty added\n$2\n$3\n$4\n$5\nremoties >:P"

# If pushing to all repos
elif [ "$1" = "shove" ]
then
  # shove : Use $FUNCNAME
  shove(){
    git push origin
    git push saucey
    git push withpulp
    git push sajjad
  }
  shove
  echo -e "gitty shoved to remoties >:P"

else
  echo -e "${red}ERROR: ${red}Check your statement. You can only use init -or- shove${nc}"
fi
