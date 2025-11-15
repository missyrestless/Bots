#!/bin/bash

curl -X POST https://api.lifebots.cloud/api/bot.html \
  -H "Content-Type: application/json" \
  -d '{
  "action": "login",
  "apikey": "lbk_oZ17pnmYlHBaHRzyjUy93IXpy9gqabjC",
  "botname": "Joe Resident",
  "secret": "your-bot-secret",
  "location": "Last location"
}'
