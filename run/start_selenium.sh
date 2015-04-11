#!/bin/sh

# TODO test this on Windows
# TODO add support for Linux (merge w/ OS X option)
# TODO check paths/existence of java/selenium-server jar
# TODO general cleanup

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
nc='\033[0m' # No Color

if [ "$1" = "windows" ]; then
  arg='-Dwebdriver.ie.driver=vendor\saucey\drivers\IEDriverServer.exe'
elif [ "$1" = "mac" ]; then
  arg='-Dwebdriver.chrome.driver=vendor/saucey/drivers/chromedriver'
else
  echo "* ${red}ERROR${nc}: Check passed argument. You can only use windows or mac"
  echo "* ${yellow}EXAMPLE${nc}: ./start_selenium mac"
  exit 1
fi

# start_selenium.sh : Use $FUNCNAME
start_selenium() {
  java -jar vendor/saucey/drivers/selenium-server-standalone-2.44.0.jar $1
}

echo "* ${green}Starting ($1) with arg \"$arg\"${nc}"
start_selenium $arg
