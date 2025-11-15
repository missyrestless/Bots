#!/bin/bash

curl -X POST https://api.lifebots.cloud/api/bot.html \
  -H "Content-Type: application/json" \
  -d '{
  "action": "logout",
  "apikey": "lbk_oZ17pnmYlHBaHRzyjUy93IXpy9gqabjC",
  "botname": "Joe Resident",
  "secret": "your-bot-secret"
}'