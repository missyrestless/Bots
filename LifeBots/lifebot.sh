#!/bin/bash
#
# lifebot - control a LifeBot using the API
#
# Author:  Missy Restless <missyrestless@gmail.com>
# Date:    15-Nov-2025
# License: MIT
#
# Currently supported actions:
#   login, logout, status, location, stand, sit, teleport
#
# ----------------- $HOME/.lifebots Format ----------------------
# Entries in ~/.lifebots can be LB_API_KEY, LB_SECRET, or entries
# of the form LB_SECRET_BOT_NAME in order to support multiple bots
#
# Entries can specify a Slurl alias. For example:
#   export SLURL_club="http://maps.secondlife.com/secondlife/Scylla/226/32/78"
# A Slurl alias can be used with the -l command line argument, e.g. -l club
#
# Entries can also specify a UUID alias. For example:
#   export UUID_couch="xxxxxxxx-yyyy-zzzz-aaaa-bbbbbbbbbbbb"
# A UUID alias can be used with the -u command line argument, e.g. -u couch
# ---------------------------------------------------------------
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
# No default UUID
UUID=

usage() {
  printf "\nUsage: lifebot [-a action] [-l location] [-n name]"
  printf "\n\t[-k apikey] [-s secret] [-u uuid] [-d] [-h]\n\n"
  exit 1
}

# Regex to match the basic SLURL format
# secondlife://RegionName/X/Y/Z (X, Y, Z are optional, and can be floats)
# or
# http://maps.secondlife.com/secondlife/RegionName/X/Y/Z
is_valid_slurl() {
  local slurl="$1"
  if [[ "$slurl" =~ ^secondlife://%[0-9a-fA-F]{2}|[a-zA-Z0-9_]+(/[0-9]+(\.[0-9]+)?(/[0-9]+(\.[0-9]+)?(/[0-9]+(\.[0-9]+)?)?)?)?$ ]]; then
    return 0 # Valid SLURL
  else
    if [[ "$slurl" =~ ^http://maps.secondlife.com/secondlife/%[0-9a-fA-F]{2}|[a-zA-Z0-9_]+(/[0-9]+(\.[0-9]+)?(/[0-9]+(\.[0-9]+)?(/[0-9]+(\.[0-9]+)?)?)?)?$ ]]; then
      return 0 # Valid SLURL
    else
      return 1 # Invalid SLURL
    fi
  fi
}

send_request() {
  local act="$1"
  [ "${act}" ] || {
    echo "Empty action. Exiting."
    usage
  }
  case "${act}" in
    sit)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\",
          \"uuid\": \"${UUID}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\",
          \"uuid\": \"${UUID}\"
        }"
      fi
      ;;
    login|teleport)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\",
          \"location\": \"${LOCATION}\"
        }\""
      else
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
      fi
      ;;
    *)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\"
        }"
      fi
      ;;
  esac
}

[ -f ${HOME}/.lifebots ] && source ${HOME}/.lifebots

command_line_secret=
dryrun=
while getopts ":a:dl:n:k:s:u:h" flag; do
  case $flag in
    a)
      ACTION="${OPTARG}"
      ;;
    d)
      dryrun=1
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
      UUID="${OPTARG}"
      ;;
    h)
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

# Check for location alias in ~/.lifebots
[ "${LOCATION}" ] && {
  envloc="SLURL_${LOCATION}"
  [ "${!envloc}" ] && LOCATION="${!envloc}"
}

# Check for UUID alias in ~/.lifebots
[ "${UUID}" ] && {
  envuuid="UUID_${UUID}"
  [ "${!envuuid}" ] && UUID="${!envuuid}"
}

[ "${LB_API_KEY}" ] && [ "${LB_SECRET}" ] || {
  echo "LB_API_KEY and LB_SECRET must be set in the environment. Exiting."
  exit 1
}

case "${ACTION}" in
  teleport|Teleport|tp|TP)
    [ "${LOCATION}" ] || {
      echo "The teleport action requires a location specified with -l location"
      usage
    }
    [ "${LOCATION}" == "Last location" ] && {
      echo "The teleport action requires a location specified with -l location"
      usage
    }
    if is_valid_slurl "${LOCATION}"; then
      send_request "teleport"
    else
      echo "${LOCATION} is NOT a valid SLURL."
    fi
    ;;
  sit|Sit)
    [ "${UUID}" ] || {
      echo "The sit action requires a UUID specified with -u uuid"
      usage
    }
    send_request "stand"
    send_request "sit"
    ;;
  stand|Stand)
    send_request "stand"
    ;;
  status|Status)
    send_request "status"
    ;;
  login|Login)
    send_request "login"
    ;;
  logout|Logout)
    send_request "logout"
    ;;
  location|Location|loc|Loc)
    send_request "bot_location"
    ;;
  *)
    echo "Action ${ACTION} not yet supported"
    echo "Currently supported actions:"
    echo "  login, logout, status, location, stand, sit, teleport"
    ;;
esac
