#!/bin/bash
#
# Adjust this list of services for your custom deployment
all_services="corrade-anya corrade-easy nginx shoutcast"
services=

usage() {
  printf "\nUsage: slsvc [-a] [-e] [-n] [-s] [-S service] [-u] [action]"
  printf "\nWhere:"
  printf "\n\t-a indicates perform action on corrade-anya service"
  printf "\n\t-e indicates perform action on corrade-easy service"
  printf "\n\t-n indicates perform action on nginx service"
  printf "\n\t-s indicates perform action on shoutcast service"
  printf "\n\t-S service specifies a service to perform action on"
  printf "\n\t   if none of -a,-e,-n,-s,-S is specified then services used are:"
  printf "\n\t     ${all_services}"
  printf "\n\taction indicates the action to perform [default: status]"
  printf "\n\t    typical actions include start/stop/enable/disable/restart/status"
  printf "\n\t -u displays this usage message and exits\n"
  exit 1
}

while getopts ":aensS:u" flag; do
  case $flag in
    a)
      services="${services} corrade-anya"
      ;;
    e)
      services="${services} corrade-easy"
      ;;
    n)
      services="${services} nginx"
      ;;
    s)
      services="${services} shoutcast"
      ;;
    S)
      services="${services} ${OPTARG}"
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

action="$1"
[ "${action}" ] || action=status

[ "${services}" ] || services="${all_services}"

if [[ $EUID -eq 0 ]]
then
  SUDO=
else
  SUDO=sudo
fi

export TERM="xterm-256color"
for script in ${services}
do
  ${SUDO} systemctl ${action} ${script}.service
done
