#!/bin/bash
#
printf "\nChecking Shoutcast and Corrade bots service status:"
for script in corrade-anya corrade-easy shoutcast
do
  systemctl is-active ${script}.service >/dev/null 2>&1 && \
    active="active" || active="inactive"
  systemctl is-enabled ${script}.service >/dev/null 2>&1 && \
    enabled="enabled " || enabled="disabled"
  if [ "${script}" == "shoutcast" ]; then
    printf "\n\t${script}    is:\t${active} and ${enabled}"
  else
    printf "\n\t${script} is:\t${active} and ${enabled}"
  fi
done
printf "\n"
