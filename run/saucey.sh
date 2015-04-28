#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
nc='\033[0m' # No Color

# If saucelabs cloud
if [ "$1" = "drunk" ]
then
  # drunk.sh : Use $FUNCNAME
  drunk(){
    bin/behat --tags "$2" -p "sauce_$3_$4"
  }
  drunk $1 $2 $3 $4 $5

# If selenium local
elif [ "$1" = "tipsy" ]
then
  # tipsy.sh : Use $FUNCNAME
  tipsy(){
    bin/behat --tags "$2" -p "local_$3"
  }
  tipsy $1 $2 $3


# If init
elif [ "$1" = "init" ]
then
  # init.sh : Use $FUNCNAME
  init(){
    curl -sS https://getcomposer.org/installer | php
  }
  init

# If install/update
elif [ "$1" = "install" ]
then
  # install.sh : Use $FUNCNAME
  install(){
    php composer.phar install && php composer.phar update
  }
  install

# If test
elif [ "$1" = "test" ]
then

  echo "Yo, you try'na get saucey?"

fi

