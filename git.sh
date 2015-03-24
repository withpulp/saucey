#!/bin/bash
#gitaddremote(){
#    git remote add sajjad https://github.com/sajjadhossain/saucey.git
#    git remote add saucey https://github.com/saucey-io/saucey.git
#    git remote add withpulp https://github.com/withpulp/saucey.git
#  }

gitpushall(){
    git push
    git push saucey
    git push withpulp
    git push sajjad
  }

gitpushall
