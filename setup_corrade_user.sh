#!/bin/bash

CORRADE_HOME="/opt/corrade"

if [[ $EUID -eq 0 ]]
then
  SUDO=
else
  SUDO=sudo
fi

${SUDO} adduser --system --no-create-home --group corrade

if [ -d ${CORRADE_HOME} ]; then
  ${SUDO} chown -R corrade:corrade ${CORRADE_HOME}
else
  echo "${CORRADE_HOME} does not exist. Skipping ownership/group setting."
fi

# Systemd Unit setup
#${SUDO} cp ${CORRADE_HOME}/Anya_Ordinary/corrade-anya.service /lib/systemd/system
#${SUDO} systemctl daemon-reload

#${SUDO} systemctl enable corrade-anya.service
#${SUDO} systemctl start corrade-anya.service
