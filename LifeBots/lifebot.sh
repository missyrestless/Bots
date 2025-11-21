#!/usr/bin/env bash
#
# lifebot - control a LifeBot using the API
#
# Author:  Missy Restless <missyrestless@gmail.com>
# Date:    15-Nov-2025
# License: MIT
#
# Currently supported actions:
#   login, logout, status, location, walkto, sit, teleport, listalias, listinventory,
#   touch, im, send_notice, send_group_im, touch
#
# TODO: stand action not working yet, no stand API endpoint
# TODO: get bot details not working yet, need to generate an access token
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
# Set the default Bot name
# Setting in .lifebots overrides, setting on command line with -n name overrides all
LB_BOT_NAME="Easy Islay"
# Set the default action, can be specified with -a action
ACTION="status"
# LifeBots API endpoint
APIURL="https://api.lifebots.cloud/api"
ENDPOINT="${APIURL}/bot.html"
# Set the default login location
LOCATION="Last location"

BOLD=$(tput bold 2> /dev/null)
NORM=$(tput sgr0 2> /dev/null)
LINE=$(tput smul 2> /dev/null)

usage() {
  [ "${nobold}" ] && {
    BOLD=
    LINE=
    NORM=
  }
  printf "\n${BOLD}${LINE}Usage:${NORM} ${BOLD}lifebot [-a action] [-l location] [-n name] [-k apikey]"
  printf "\n\t[-C channel] [-M message] [-N name] [-S subject] [-s secret] [-u uuid] [-dih]${NORM}"
  printf "\n${BOLD}${LINE}Where:${NORM}"
  printf "\n\t${BOLD}${LINE}-a action${NORM} specifies the API action (sit, teleport, login, ...)"
  printf "\n\t  Supported actions: login, logout, status (default), location, walkto, sit, teleport,"
  printf "\n\t                     listalias, listinventory, im, send_notice, send_group_im, touch"
  printf "\n\t${BOLD}${LINE}-l location${NORM} specifies a location for login and teleport actions"
  printf "\n\t\tDefault: Last location, teleport action requires a Slurl location"
  printf "\n\t${BOLD}${LINE}-n name${NORM} specifies a Bot name, Default: Easy Islay"
  printf "\n\t${BOLD}${LINE}-k apikey${NORM} specifies an API Key, use environment instead"
  printf "\n\t${BOLD}${LINE}-C channel${NORM} specifies the channel for a message [default: 0]"
  printf "\n\t${BOLD}${LINE}-M message${NORM} specifies the message body for a group notice/im"
  printf "\n\t${BOLD}${LINE}-N name${NORM} specifies the SL name of the recipient of an IM"
  printf "\n\t${BOLD}${LINE}-S subject${NORM} specifies the subject for a group notice"
  printf "\n\t${BOLD}${LINE}-s secret${NORM} specifies a Bot secret, use environment instead"
  printf "\n\t${BOLD}${LINE}-u uuid${NORM} specifies a UUID for use with actions that require one (e.g. sit)"
  printf "\n\t${BOLD}${LINE}-d${NORM} indicates dryrun mode - tell me what you would do without doing anything"
  printf "\n\t${BOLD}${LINE}-i${NORM} retrieves Bot details"
  printf "\n\t${BOLD}${LINE}-h${NORM} displays this usage message and exits"
  printf "\n${BOLD}${LINE}Environment:${NORM}"
  printf "\n  Entries in ~/.lifebots can be LB_API_KEY, LB_SECRET, or entries"
  printf "\n  of the form LB_SECRET_BOT_NAME in order to support multiple bots"
  printf "\n  Entries can specify a Slurl alias. For example:"
  printf "\n    export SLURL_club='http://maps.secondlife.com/secondlife/Scylla/226/32/78'"
  printf "\n  A Slurl alias can be used with the -l command line argument, e.g. -l club"
  printf "\n  Entries can also specify a UUID alias. For example:"
  printf "\n    export UUID_Mover='xxxxxxxx-yyyy-zzzz-aaaa-bbbbbbbbbbbb'"
  printf "\n  A UUID alias can be used with the -u command line argument, e.g. -u Mover"
  printf "\n${BOLD}${LINE}Examples:${NORM}"
  printf "\n  lifebot  # Displays the status of the default Bot"
  printf "\n  lifebot -a login -l Home # Default Bot login to Home location"
  printf "\n  lifebot -a touch -n 'Jane Doe' -u Mover # Jane Doe bot touch object with aliased UUID"
  printf "\n  lifebot -a teleport -l club  # Uses a 'club' location alias defined in .lifebots\n"
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

# Validate coordinates provided with -l coords are in supported format, X,Y,Z or X/Y/Z.
is_valid_coords() {
  local coords="$1"
  if [[ "${coords}" =~ ^[[:digit:]]+,[[:digit:]]+,[[:digit:]]+$ ]]; then
    return 0 # Valid Coordinates
  else
    if [[ "${coords}" =~ ^[[:digit:]]+/[[:digit:]]+/[[:digit:]]+$ ]]; then
      return 0 # Valid Coordinates
    else
      return 1 # Invalid Coordinates
    fi
  fi
}

# TODO: get_details not yet working
get_details() {
  local access_token="${LB_SECRET}"
  [ "${LB_BOT_ID}" ] || {
    echo "No Bot ID set in .lifebots"
    usage
  }
  if [ "${dryrun}" ]; then
    echo "curl -s GET ${APIURL}/v1/bots/${LB_BOT_ID} \
      -H \"Authorization: Bearer ${access_token}\" \
      -H \"Accept: application/json\" \
      -H \"Content-Type: application/json\""
  else
    curl -s GET ${APIURL}/v1/bots/${LB_BOT_ID} \
      -H "Authorization: Bearer ${access_token}" \
      -H "Accept: application/json" \
      -H "Content-Type: application/json"
  fi
}

show_alias() {
  local astr="$1"
  local argl="$2"
  if env | grep ^${astr}_ >/dev/null; then
    env | grep ^${astr}_ | while read entr
    do
      [ "${entr}" ] && {
        alias=$(echo "${entr}" | awk -F '=' '{ print $1 }' | sed -e "s/${astr}_//")
        along=$(echo "${entr}" | awk -F '=' '{ print $2 }')
        alen=${#alias}
        if [ ${alen} -lt 5 ]; then
          printf "\n${BOLD}${LINE}-%s %s${NORM}\t\talias for: ${BOLD}-%s %s${NORM}" \
                 "${argl}" "${alias}" "${argl}" "${along}"
        else
          printf "\n${BOLD}${LINE}-%s %s${NORM}\talias for: ${BOLD}-%s %s${NORM}" \
                 "${argl}" "${alias}" "${argl}" "${along}"
        fi
      }
    done
  else
    printf "\nNo ${astr} aliases defined in ${HOME}/.lifebots"
  fi
}

list_aliases() {
  local ali="$1"
  [ "${ali}" ] || ali="aliases"

  case "${ali}" in
    botalias*|aliasbot*)
      printf "\n${BOLD}${LINE}Bot Name Aliases${NORM}\n"
      show_alias BOT_NAME n
      ;;
    slurlalias*|alias*url*)
      printf "\n${BOLD}${LINE}Slurl Aliases${NORM}\n"
      show_alias SLURL l
      ;;
    uuidalias*|aliasuu*)
      printf "\n${BOLD}${LINE}UUID Aliases${NORM}\n"
      show_alias UUID u
      ;;
    *)
      printf "\n${BOLD}${LINE}Bot Name Aliases${NORM}\n"
      show_alias BOT_NAME n
      printf "\n\n${BOLD}${LINE}Slurl Aliases${NORM}\n"
      show_alias SLURL l
      printf "\n\n${BOLD}${LINE}UUID Aliases${NORM}\n"
      show_alias UUID u
      ;;
  esac
  echo ""
}

send_request() {
  local act="$1"
  [ "${act}" ] || {
    echo "Empty action. Exiting."
    usage
  }
  case "${act}" in
    listinventory|sit|touch_prim)
      if [ "${dryrun}" ]; then
        if [ "${UUID}" ]; then
          echo "curl -s -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            \"action\": \"${act}\",
            \"apikey\": \"${LB_API_KEY}\",
            \"botname\": \"${LB_BOT_NAME}\",
            \"secret\": \"${LB_SECRET}\",
            \"dataType\": \"json\",
            \"uuid\": \"${UUID}\"
          }\""
        else
          echo "curl -s -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            \"action\": \"${act}\",
            \"apikey\": \"${LB_API_KEY}\",
            \"botname\": \"${LB_BOT_NAME}\",
            \"dataType\": \"json\",
            \"secret\": \"${LB_SECRET}\"
          }\""
        fi
      else
        if [ "${UUID}" ]; then
          curl -s -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            \"action\": \"${act}\",
            \"apikey\": \"${LB_API_KEY}\",
            \"botname\": \"${LB_BOT_NAME}\",
            \"secret\": \"${LB_SECRET}\",
            \"dataType\": \"json\",
            \"uuid\": \"${UUID}\"
          }"
        else
          curl -s -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            \"action\": \"${act}\",
            \"apikey\": \"${LB_API_KEY}\",
            \"botname\": \"${LB_BOT_NAME}\",
            \"dataType\": \"json\",
            \"secret\": \"${LB_SECRET}\"
          }"
        fi
      fi
      ;;
    login|teleport)
      if [ "${LOGIN_SITON}" ] && [ "${act}" == "login" ]; then
        if [ "${dryrun}" ]; then
          echo "curl -s -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            \"action\": \"${act}\",
            \"apikey\": \"${LB_API_KEY}\",
            \"botname\": \"${LB_BOT_NAME}\",
            \"secret\": \"${LB_SECRET}\",
            \"siton\": \"${LOGIN_SITON}\",
            \"dataType\": \"json\",
            \"location\": \"${LOCATION}\"
          }\""
        else
          curl -s -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            \"action\": \"${act}\",
            \"apikey\": \"${LB_API_KEY}\",
            \"botname\": \"${LB_BOT_NAME}\",
            \"secret\": \"${LB_SECRET}\",
            \"siton\": \"${LOGIN_SITON}\",
            \"dataType\": \"json\",
            \"location\": \"${LOCATION}\"
          }"
        fi
      else
        if [ "${dryrun}" ]; then
          echo "curl -s -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            \"action\": \"${act}\",
            \"apikey\": \"${LB_API_KEY}\",
            \"botname\": \"${LB_BOT_NAME}\",
            \"secret\": \"${LB_SECRET}\",
            \"dataType\": \"json\",
            \"location\": \"${LOCATION}\"
          }\""
        else
          curl -s -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            \"action\": \"${act}\",
            \"apikey\": \"${LB_API_KEY}\",
            \"botname\": \"${LB_BOT_NAME}\",
            \"secret\": \"${LB_SECRET}\",
            \"dataType\": \"json\",
            \"location\": \"${LOCATION}\"
          }"
        fi
      fi
      ;;
    im|say_chat_channel|send_group_im|send_notice)
      msg_label="message"
      [ "${act}" == "send_notice" ] && msg_label="text"
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${LB_BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\",
          \"slname\": \"${SL_NAME}\",
          \"groupuuid\": \"${GROUP_ID}\",
          \"subject\": \"${SUBJECT}\",
          \"channel\": \"${CHANNEL}\",
          \"${msg_label}\": \"${MESSAGE}\",
          \"autodelay\": \"1\",
          \"dataType\": \"json\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${LB_BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\",
          \"slname\": \"${SL_NAME}\",
          \"groupuuid\": \"${GROUP_ID}\",
          \"subject\": \"${SUBJECT}\",
          \"channel\": \"${CHANNEL}\",
          \"${msg_label}\": \"${MESSAGE}\",
          \"autodelay\": \"1\",
          \"dataType\": \"json\"
        }"
      fi
      ;;
    walkto)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${LB_BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\",
          \"dataType\": \"json\",
          \"coords\": \"${LOCATION}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${LB_BOT_NAME}\",
          \"secret\": \"${LB_SECRET}\",
          \"dataType\": \"json\",
          \"coords\": \"${LOCATION}\"
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
          \"botname\": \"${LB_BOT_NAME}\",
          \"dataType\": \"json\",
          \"secret\": \"${LB_SECRET}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          \"action\": \"${act}\",
          \"apikey\": \"${LB_API_KEY}\",
          \"botname\": \"${LB_BOT_NAME}\",
          \"dataType\": \"json\",
          \"secret\": \"${LB_SECRET}\"
        }"
      fi
      ;;
  esac
}

BOT_NAME=
CHANNEL=0
GROUP_ID=
LOGIN_SITON=
MESSAGE=
SL_NAME=
SUBJECT=
UUID=

[ -f ${HOME}/.lifebots ] && source ${HOME}/.lifebots

# Use jq to format JSON return if it is available
have_jq=$(type -p jq)

command_line_secret=
details=
dryrun=
nobold=
while getopts ":a:C:dijl:M:N:n:k:S:s:u:Hh" flag; do
  case $flag in
    a)
      ACTION="${OPTARG}"
      ;;
    C)
      CHANNEL="${OPTARG}"
      ;;
    d)
      dryrun=1
      have_jq=
      ;;
    i)
      details=1
      ;;
    j)
      have_jq=
      ;;
    l)
      LOCATION="${OPTARG}"
      ;;
    M)
      MESSAGE="${OPTARG}"
      ;;
    N)
      SL_NAME="${OPTARG}"
      ;;
    n)
      BOT_NAME="${OPTARG}"
      ;;
    k)
      LB_API_KEY="${OPTARG}"
      ;;
    S)
      SUBJECT="${OPTARG}"
      ;;
    s)
      LB_SECRET="${OPTARG}"
      command_line_secret=1
      ;;
    u)
      UUID="${OPTARG}"
      ;;
    H)
      nobold=1
      usage
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

# Check for Name alias in ~/.lifebots
[ "${BOT_NAME}" ] && {
  botname=$(echo "${BOT_NAME}" | sed -e "s/ /_/g")
  envname="BOT_NAME_${botname}"
  [ "${!envname}" ] && LB_BOT_NAME="${!envname}"
}

# Check for a bot specific secret
[ "${command_line_secret}" ] || {
  botname=$(echo "${LB_BOT_NAME}" | sed -e "s/ /_/g")
  envsecret="LB_SECRET_${botname}"
  [ "${!envsecret}" ] && LB_SECRET="${!envsecret}"
}

# Check for Bot ID alias in ~/.lifebots
[ "${LB_BOT_ID}" ] && {
  botid=$(echo "${LB_BOT_ID}" | sed -e "s/ /_/g")
  envid="LB_BOT_ID_${botid}"
  [ "${!envid}" ] && LB_BOT_ID="${!envid}"
}

# Check for location alias in ~/.lifebots
[ "${LOCATION}" ] && {
  botloc=$(echo "${LOCATION}" | sed -e "s/ /_/g")
  envloc="SLURL_${botloc}"
  [ "${!envloc}" ] && LOCATION="${!envloc}"
}

# Check for UUID alias in ~/.lifebots
[ "${UUID}" ] && {
  botuuid=$(echo "${UUID}" | sed -e "s/ /_/g")
  envuuid="UUID_${botuuid}"
  [ "${!envuuid}" ] && UUID="${!envuuid}"
}

# Set the object UUID to sit on when logging in
if [ "${UUID}" ]; then
  LOGIN_SITON="${UUID}"
else
  botuuid=$(echo "${LB_BOT_NAME}" | sed -e "s/ /_/g")
  envuuid="LOGIN_SITON_${botuuid}"
  [ "${!envuuid}" ] && LOGIN_SITON="${!envuuid}"
fi

[ "${LB_API_KEY}" ] && [ "${LB_SECRET}" ] || {
  echo "LB_API_KEY and LB_SECRET must be set in the environment. Exiting."
  exit 1
}

[ "${details}" ] && {
  get_details
  exit 0
}

case "${ACTION}" in
  walkto|walk|Walkto|Walk)
    [ "${LOCATION}" ] || {
      echo "The ${ACTION} action requires coordinates specified with -l coords"
      usage
    }
    [ "${LOCATION}" == "Last location" ] && {
      echo "The ${ACTION} action requires coordinates specified with -l coords"
      usage
    }
    if is_valid_coords "${LOCATION}"; then
      if [ "${have_jq}" ]; then
        send_request "walkto" | jq -r .
      else
        send_request "walkto"
      fi
    else
      echo "${LOCATION} is NOT valid Coordinates."
    fi
    ;;
  sendnotice|Sendnotice|send_notice|Send_notice)
    show_usage=
    if [ "${UUID}" ]; then
      GROUP_ID="${UUID}"
    else
      echo "The ${ACTION} action requires a Group UUID specified with -u uuid"
      show_usage=1
    fi
    [ "${SUBJECT}" ] || {
      echo "The ${ACTION} action requires a Subject specified with -S subject"
      show_usage=1
    }
    [ "${MESSAGE}" ] || {
      echo "The ${ACTION} action requires a Message body specified with -M message"
      show_usage=1
    }
    [ "${show_usage}" ] && usage
    if [ "${have_jq}" ]; then
      send_request "send_notice" | jq -r .
    else
      send_request "send_notice"
    fi
    ;;
  sendgroupim|Sendgroupim|send_group_im|Send_group_im)
    show_usage=
    if [ "${UUID}" ]; then
      GROUP_ID="${UUID}"
    else
      echo "The ${ACTION} action requires a Group UUID specified with -u uuid"
      show_usage=1
    fi
    [ "${MESSAGE}" ] || {
      echo "The ${ACTION} action requires a Message body specified with -M message"
      show_usage=1
    }
    [ "${show_usage}" ] && usage
    if [ "${have_jq}" ]; then
      send_request "send_group_im" | jq -r .
    else
      send_request "send_group_im"
    fi
    ;;
  im|IM)
    show_usage=
    # If recipient SL name was not specified on command line then use UUID
    [ "${SL_NAME}" ] || {
      if [ "${UUID}" ]; then
        SL_NAME="${UUID}"
      else
        echo "The ${ACTION} action requires an SL Nem or UUID specified with -N name or -u uuid"
        show_usage=1
      fi
    }
    [ "${MESSAGE}" ] || {
      echo "The ${ACTION} action requires a Message body specified with -M message"
      show_usage=1
    }
    [ "${show_usage}" ] && usage
    if [ "${have_jq}" ]; then
      send_request "im" | jq -r .
    else
      send_request "im"
    fi
    ;;
  say|Say|say_*|Say_*)
    [ "${MESSAGE}" ] || {
      echo "The ${ACTION} action requires a Message body specified with -M message"
      usage
    }
    if [ "${have_jq}" ]; then
      send_request "say_chat_channel" | jq -r .
    else
      send_request "say_chat_channel"
    fi
    ;;
  touch|Touch|touch_prim|touchprim)
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires a UUID specified with -u uuid"
      usage
    }
    if [ "${have_jq}" ]; then
      send_request "touch_prim" | jq -r .
    else
      send_request "touch_prim"
    fi
    ;;
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
      if [ "${have_jq}" ]; then
        send_request "teleport" | jq -r .
      else
        send_request "teleport"
      fi
    else
      echo "${LOCATION} is NOT a valid SLURL."
    fi
    ;;
  sit|Sit)
    [ "${UUID}" ] || {
      echo "The sit action requires a UUID specified with -u uuid"
      usage
    }
    if [ "${have_jq}" ]; then
      send_request "sit" | jq -r .
    else
      send_request "sit"
    fi
    ;;
  stand|Stand)
    if [ "${have_jq}" ]; then
      send_request "stand" | jq -r .
    else
      send_request "stand"
    fi
    ;;
  status|Status)
    if [ "${have_jq}" ]; then
      send_request "status" | jq -r .
    else
      send_request "status"
    fi
    ;;
  listinventory|Listinventory|inventory)
    if [ "${have_jq}" ]; then
      send_request "listinventory" | jq -r .
    else
      send_request "listinventory"
    fi
    ;;
  botalias*|slurlalias*|uuidalias*|listalias*|Listalias*|alias*|Alias*)
    list_aliases "${ACTION}"
    ;;
  login|Login)
    if [ "${have_jq}" ]; then
      send_request "login" | jq -r .
    else
      send_request "login"
    fi
    ;;
  logout|Logout)
    if [ "${have_jq}" ]; then
      send_request "logout" | jq -r .
    else
      send_request "logout"
    fi
    ;;
  location|Location|loc|Loc)
    if [ "${have_jq}" ]; then
      send_request "bot_location" | jq -r .
    else
      send_request "bot_location"
    fi
    ;;
  get_outfit|GetOutfit|getoutfit)
    if [ "${have_jq}" ]; then
      send_request "get_outfit" | jq -r .
    else
      send_request "get_outfit"
    fi
    ;;
  *)
    echo "Action '${ACTION}' not yet supported"
    echo "Currently supported actions:"
    echo "  login, logout, status, location, walkto, sit, teleport, listalias, listinventory,"
    echo "  im, send_notice, send_group_im, touch"
    ;;
esac
