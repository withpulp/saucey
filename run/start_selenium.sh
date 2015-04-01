#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
nc='\033[0m' # No Color

if [ "$1" = "windows" ]
then
  # start_selenium.sh : Use $FUNCNAME
  start_selenium(){
    java -jar vendor\saucey\drivers\selenium-server-standalone-2.45.0.jar -Dwebdriver.ie.driver=vendor\saucey\drivers\IEDriverServer.exe
  }

  start_selenium $1

elif [ "$1" = "mac" ]
then
  # start_selenium.sh : Use $FUNCNAME
  start_selenium(){
    java -jar vendor/saucey/drivers/selenium-server-standalone-2.45.0.jar -Dwebdriver.chrome.driver=vendor/saucey/drivers/chromedriver
  }

  start_selenium $1

else
  echo -e "${red}ERROR: Check your statement. You can only use windows or mac"
  echo -e "${yellow}EXAMPLE: start_selenium windows -or- start_selenium mac"

fi
