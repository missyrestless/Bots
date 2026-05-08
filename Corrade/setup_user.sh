#!/bin/bash

sudo adduser --system --no-create-home --group corrade

sudo chown -R corrade:corrade /opt/corrade

sudo cp /opt/corrade/Easy_Islay/corrade-easy.service /lib/systemd/system
sudo systemctl daemon-reload

sudo systemctl enable corrade-easy.service
sudo systemctl start corrade-easy.service
