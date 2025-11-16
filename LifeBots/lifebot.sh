#!/bin/bash
#
# lifebot - control a LifeBot using the API
#
# Author:  Missy Restless <missyrestless@gmail.com>
# Date:    15-Nov-2025
# License: MIT
#
# Entries in ~/.lifebots can be LB_API_KEY, LB_SECRET, or entries
# of the form LB_SECRET_BOT_NAME in order to support multiple bots
#
# Command line arguments can be used to override the settings in .lifebots
# NOTE: command line arguments are stored in the shell history
#       environment variables are preferable over command line arguments
#
# Set the default Bot name, can be specified with -n name
BOT_NAME="Easy Islay"
# Set the default action, can be specified with -a action
ACTION="status"
# LifeBots API endpoint
ENDPOINT="https://api.lifebots.cloud/api/bot.html"
# Set the default login location
LOCATION="Last location"

usage() {
  printf "\nUsage: lifebot [-a action] [-l location] [-n name] [-k apikey] [-s secret] [-u]\n\n"
  exit 1
}

send_request() {
  act="$1"
  [ "${act}" ] || {
    echo "Empty action. Exiting."
    usage
  }
  curl -s -X POST ${ENDPOINT} \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{
    \"action\": \"${act}\",
    \"apikey\": \"${LB_API_KEY}\",
    \"botname\": \"${BOT_NAME}\",
    \"secret\": \"${LB_SECRET}\",
    \"location\": \"${LOCATION}\"
  }"
}

[ -f ${HOME}/.lifebots ] && source ${HOME}/.lifebots

command_line_secret=
while getopts ":a:l:n:k:s:u" flag; do
  case $flag in
    a)
      ACTION="${OPTARG}"
      ;;
    l)
      LOCATION="${OPTARG}"
      ;;
    n)
      BOT_NAME="${OPTARG}"
      ;;
    k)
      LB_API_KEY="${OPTARG}"
      ;;
    s)
      LB_SECRET="${OPTARG}"
      command_line_secret=1
      ;;
    u)
      usage
      ;;
    \?)
      echo "Invalid option: $flag"
      usage
      ;;
  esac
done
shift $(( OPTIND - 1 ))

# Check for a bot specific secret
[ "${command_line_secret}" ] || {
  botname=$(echo "${BOT_NAME}" | sed -e "s/ /_/g")
  envsecret="LB_SECRET_${botname}"
  [ "${!envsecret}" ] && LB_SECRET="${!envsecret}"
}

[ "${LB_API_KEY}" ] && [ "${LB_SECRET}" ] || {
  echo "LB_API_KEY and LB_SECRET must be set in the environment. Exiting."
  exit 1
}

case "${ACTION}" in
  status|Status)
    send_request status
    ;;
  login|Login)
    send_request login
    ;;
  logout|Logout)
    send_request logout
    ;;
  *)
    echo "Action ${ACTION} not yet supported"
    ;;
esac
