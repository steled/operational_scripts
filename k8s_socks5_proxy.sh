#!/bin/bash

#################################################################################
#                                                                               #
# This script is used to create a SOCKS5 proxy to access the k8s API.           #
# For more information check:                                                   #
#   https://kubernetes.io/docs/tasks/extend-kubernetes/socks5-proxy-access-api/ #
#                                                                               #
#################################################################################

sourced=0

if [ "$#" -eq 0 ]
then
  echo "No arguments supplied"
  echo "start script: source ./ssh_proxy.sh start|stop"
  exit 1
fi

(return 0 2>/dev/null) && sourced=1


if [ "$sourced" != 1 ]
then
  echo "script is not sourced"
  echo "start script: source ./ssh_proxy.sh start|stop"
  exit 1
fi

if [ "$1" = "start" ]
then
  echo "starting ssh proxy"
  ssh -D 1080 -qNf jumphost
  echo "setting HTTPS_PROXY env variable"
  export HTTPS_PROXY="socks5://localhost:1080"
elif [ "$1" = "stop" ]
then
  echo "stopping ssh proxy"
  pidof ssh | xargs kill
  echo "removing HTTPS_PROXY env variable"
  export HTTPS_PROXY=""
fi
