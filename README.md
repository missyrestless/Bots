# Second Life Bots

This repository contains commands, configuration, and management scripts for
Second Life bots. Included are management systems for `Corrade` bots and `LifeBots`.

**[NOTE:]** The Truth & Beauty Lab and Missy Restless are not associated in any way
with either `Corrade` or `LifeBots`.

## Table of Contents

- [Repository Contents](#repository-contents)
- [LifeBots](#lifebots)
  - [Requirements](#requirements)
  - [Install lifebot](#install-lifebot)
  - [Configure lifebot](#configure-lifebot)
  - [Supported Bot Actions and Examples](#supported-bot-actions-and-examples)
  - [Usage and Source of lifebot command](#usage-and-source-of-lifebot-command)
  - [Scheduling Bot Actions](#scheduling-bot-actions)
- [Corrade](#corrade)
- [Corrade HUD](#corrade-hud)

## Repository Contents

- `Avatars`: Specifications for free male and female avatars
- `bin`: convenience scripts to manage Corrade services on the server-side
- `etc`: Corrade, Nginx, and Shoutcast configuration and systemd units
- `Evade_Region_Restart`: Script and configuration notecard to evade region restarts
- `Examples`: some simple examples of how to use the Corrade system
- `HUD`: the Corrade HUD, control bots in-world with this heads-up display
- `LifeBots`: the lifebot command line management system for LifeBots
- `Masters`: Script and configuration notecard to extend some privileges to the Corrade bot owner
- `Pay2Play`: WDC Tipjar settings examples
- `Select_Dialog_Option`: a dialog menu selector for the Corrade bot
- `Sit_Animate`: example sit on object and animate a Corrade bot
- `Toggle_Vista_AO`: example script turning on/off the Vista AO of a bot

## LifeBots

**[DISCLAIMER:]** Truth &amp; Beauty Lab is not officially affiliated with `LifeBots` other
than contributing Knowledge Base articles in exchange for a couple of free `LifeBots` bots.

[LifeBots](https://lifebots.cloud) bills itself as:

> The most advanced bot platform for Second Life. From AI characters to
> complete group automation, we've got everything your community needs.

I cannot disagree - `LifeBots` is the most advanced bot platform for Second Life.

For `L$165/wk` the LifeBots Lite Bot provides:

- Basic bot functionality
- Greeter Bot addon
- HUD Support
- Dialog Menu Interactions
- RLV capabilities
- Compatible addons support
- API access
- Email support
- Web dashboard access
- AI Access (No AI Functions / Avatar Specific Memory)

For `L$450/wk` the LifeBots Full Bot provides:

- All Lite Bot features
- Group Notice scheduling
- Group IM scheduling
- Group Web Chat
- Group Discord Sync
- Complete addon support
- Advanced AI integration
- Priority support
- Custom scripting
- Advanced analytics

This repository provides a command line management system for `LifeBots`.
The `LifeBots` web UI and HUD can be used for interactive control and for
many users this is sufficient. For those power users who wish to automate
their `LifeBots` using the command line and tools such as `cron` and `jq`
the `lifebot` command and associated utilities may provide additional
power and flexibility. The `LifeBots` command line management system is
open source, MIT licensed, and free to download, deploy, modify, and distribute.

`LifeBots` managed by the `lifebot` command line and scheduled using the Unix
`cron` facility can be viewed and interacted with in Second Life at the
[Truth & Beauty Lab](http://maps.secondlife.com/secondlife/Brightbrook%20Isle/56/135/23)
or [Club Truth & Beauty](http://maps.secondlife.com/secondlife/Scylla/226/32/78).

### Requirements

The `lifebot` command line management system requires:

- Unix, Linux, Macos, or Windows Subsystem for Linux (WSL)
- Bash
- Cron
- curl
- git
- [jq](https://jqlang.org)

These requirements, with the exception of `jq`, are typically included in the base
operating system on all supported platforms. If your platform does not have `jq`
installed then you can still use `lifebot`, a few of the helper utilities will not
function properly but the bulk of the system will function without `jq`.

### Install lifebot

To install `lifebot`:

```bash
git clone https://github.com/missyrestless/Bots.git
cd Bots
./install-lifebot
```

Or, you can use the `curl` command to install `lifebot` with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/missyrestless/Bots/refs/heads/main/install-lifebot | bash
```

Alternatively, download the `install-lifebot` release artifact and
execute it. The `install-lifebot` script will clone the repository
and install the system:

```bash
wget -q https://github.com/missyrestless/Bots/releases/latest/download/install-lifebot
chmod 755 install-lifebot
./install-lifebot
```

### Configure lifebot

The `lifebot` command is installed in `/usr/local/bin` along with some
utility scripts for use with `cron` or other management systems. These
utility scripts will need to be modified to suit your specific needs,
configuration and bot names. You can modify the scripts in
`LifeBots/bin/` and re-run `./install-lifebot`.

Add `/usr/local/bin` to your execution `PATH` if it is not already included.

Configure `lifebot` by adding and editing the file `${HOME}/.lifebots`.

At a minimum, you must configure your `LifeBots` developer API key and bot
secrets for the `LifeBots` bots you wish to control using the `lifebot` command.

The following example entries in `$HOME/.lifebots` will allow you to control your
`LifeBots` bot named "Your Botname" using the `lifebot` command:

```bash
## Minimum contents of $HOME/.lifebots
#
# LifeBots Developer API Key
export LB_API_KEY='<your-lifebots-api-key>'
# LifeBots bot secret
export LB_SECRET_Your_Botname='<your-bot-secret>'
```

Add an entry of the form `export LB_SECRET_Firstname_Lastname='<bot-secret>'`
to `$HOME/.lifebots` for each of your `LifeBots` bots.

See `LifeBots/example_dot_lifebots` for a template to use for this file.

See `LifeBots/crontab.in` for example crontab entries to schedule bot activities.

See the section [Scheduling Bot Actions](#scheduling-bot-actions) below for more
details on scheduling bot actions.

### Supported Bot Actions and Examples

The `lifebot` command supports a significant subset of the full `LifeBots` API.

**[NOTE:]** the examples below all assume you have configured `$HOME/.lifebots`
with your `LifeBots` API key and the bot secret:

```bash
# LifeBots Developer API Key
export LB_API_KEY='<redacted>'
## John Doebot LifeBots secret
export LB_SECRET_John_Doebot='<redacted>'
```

The following actions and commands, along with example command line invocations,
are supported by the `lifebot` command.

- `attachments` : list bot attachments, optionally specify a filter to match
  - `Example` : list bot named `John Doebot` attachments with name containing the string `HUD`
  - `lifebot -a attachments -F "HUD" -n "John Doebot"`
- `bot_location` : get precise bot location
  - `Example` : get location of bot named `John Doebot`
  - `lifebot -a location -n "John Doebot"`
- `get_outfit` : list currently worn bot outfit
  - `Example` : list currently worn outfit of bot named `John Doebot`
  - `lifebot -a get_outfit -n "John Doebot"`
- `get_outfits` : list available bot outfits
  - `Example` : list available outfits for bot named `John Doebot`
  - `lifebot -a get_outfits -n "John Doebot"`
- `im` : send an instant message to an avatar
  - `Example` : send IM from `John Doebot` to avatar "Jane Free"
  - `lifebot -a im -n "John Doebot" -N "Jane Free" -M 'Hi Jane, do you want to meetup?'`
- `listalias` : list configured `lifebot` aliases in `$HOME/.lifebots`
  - `Example` : list all configured `lifebot` aliases
  - `lifebot -a listalias`
  - `Example` : list configured `lifebot` bot aliases only
  - `lifebot -a botalias`
  - `Example` : list configured `lifebot` location aliases only
  - `lifebot -a slurlalias`
  - `Example` : list configured `lifebot` UUID aliases only
  - `lifebot -a uuidalias`
- `listinventory` : list bot inventory, optionally specify an inventory folder UUID
  - `Example` : list inventory of bot named `John Doebot`
  - `lifebot -a listinventory -n "John Doebot"`
- `login` : login bot
  - `Example` : login bot named `John Doebot`
  - `lifebot -a login -n "John Doebot"`
- `logout` : logout bot
  - `Example` : logout bot named `John Doebot`
  - `lifebot -a logout -n "John Doebot"`
- `reply_dialog` : reply to a dialog menu (requires channel, UUID, and button text)
  - `Example` : click couch menu button "Male" on channel 99999
  - `lifebot -a reply -n "John Doebot" -C 99999 -B Male -u "a811d6fe-de59-2f4e-ee19-0cc48da48981"`
- `send_group_im` : send an instant message to a group
  - `Example` : send IM to a group from bot named `John Doebot`
  - `lifebot -a send_group_im -n "John Doebot" -u "f7d3c1b9-a141-9546-7e2d-dfd698c5df7c" -M "Meeting at Noon SLT tomorrow"`
- `send_notice` : send an official group notice to all group members
  - `Example` : send group notice with subject and message from bot named `John Doebot`
  - `lifebot -a send_notice -n "John Doebot" -u "f7d3c1b9-a141-9546-7e2d-dfd698c5df7c" -M "Meeting at Noon SLT tomorrow" -S "Meeting Tomorrow"`
- `set_hoverheight` : adjust bot hover height
  - `Example` : lower hover height of bot `John Doebot` by 0.05
  - `lifebot -a height -n "John Doebot" -z "-0.05"`
- `sit` : sit on a specified object UUID
  - `Example` : sit bot named `John Doebot` on an object
  - `lifebot -a sit -n "John Doebot" -u "d46e217b-fb5c-4796-bae3-ea016b280210"`
- `status` : get bot status
  - `Example` : get status of bot `John Doebot` (status is default action)
  - `lifebot -n "John Doebot"`
- `teleport` : teleport bot to specified location
  - `Example` : teleport bot `John Doebot` to the aliased location "club"
  - Requires an entry of the following form in `$HOME/.lifebots`
    - `export SLURL_club="http://maps.secondlife.com/secondlife/Scylla/226/32/78"`
  - `lifebot -a teleport -n "John Doebot" -l club`
- `touch_attachment` : touch a specified bot attachment
  - `Example` : bot `John Doebot` touch attachment named "HUD Controller"
  - `lifebot -a touch_attachment -n "John Doebot" -O "HUD Controller"`
- `touch_prim` : touch a specified object by UUID
  - `Example` : bot named `John Doebot` touch an object
  - `lifebot -a touch_prim -n "John Doebot" -u "f11781d0-763f-52f9-4e23-3a2b97759fa2"`
    - If `~/.lifebots` contains : `export UUID_spoton="f11781d0-763f-52f9-4e23-3a2b97759fa2"`
    - `lifebot -a touch_prim -n "John Doebot" -u spoton`
- `walkto` : walk bot to a location
  - `Example` : bot named `John Doebot` walk to X/Y/Z coordinates 100/50/28
  - `lifebot -a walkto -n "John Doebot" -l "100/50/28"`
- `wear_outfit` : wear a specified outfit
  - `Example` : bot named `John Doebot` wear the outfit named "Business Casual"
  - `lifebot -a wear_outfit -n "John Doebot" -O "Business Casual"`
    - If `~/.lifebots` contains : `export LB_BOT_NAME='John Doebot'`
    - `lifebot -a wear_outfit -O "Business Casual"`

Development is in rapid progress for additional actions.

Let us know which `LifeBots` API requests you would like supported.

### Usage and Source of lifebot command

<details><summary>Click here to view the

**lifebot command usage message**

</summary>

```
Usage: lifebot [-dih] [-a action] [-l location] [-n name] [-k apikey] [-B text]
	 [-C channel] [-F filter] [-M message] [-N name] [-O name] [-S subject] [-s secret] [-u uuid] [-z num]
Where:
	-a action specifies the API action (sit, teleport, login, ...)
	  Supported actions: login, logout, status (default), bot_location, walkto, sit, teleport,
	        listalias, listinventory, im, reply_dialog, send_notice, send_group_im,
	        attachments, touch_attachment, touch_prim, set_hoverheight, get_outfit, get_outfits, wear_outfit
	-l location specifies a location for login and teleport actions
		Default: Last location, teleport action requires a Slurl location
	-n name specifies a Bot name, Default: Easy Islay
	-k apikey specifies an API Key, use environment instead
	-B text specifies the dialog button text for replies to dialog menus
	-C channel specifies the channel for a message [default: 0]
	-F filter specifies a filter to match when listing attachments
	-M message specifies the message body for a group notice/im
	-N name specifies the SL name of the recipient of an IM
	-O name specifies an attachment object name or outfit name
	-S subject specifies the subject for a group notice
	-s secret specifies a Bot secret, use environment instead
	-u uuid specifies a UUID for use with actions that require one (e.g. sit)
	-z num specifies a hover height adjustment size [default: -0.05]
	-d indicates dryrun mode - tell me what you would do without doing anything
	-i retrieves Bot details
	-h displays this usage message and exits
Environment:
  Entries in ~/.lifebots can be LB_API_KEY, LB_SECRET, or entries
  of the form LB_SECRET_BOT_NAME in order to support multiple bots
  Entries can specify a Slurl alias. For example:
    export SLURL_club='http://maps.secondlife.com/secondlife/Scylla/226/32/78'
  A Slurl alias can be used with the -l command line argument, e.g. -l club
  Entries can also specify a UUID alias. For example:
    export UUID_Mover='xxxxxxxx-yyyy-zzzz-aaaa-bbbbbbbbbbbb'
  A UUID alias can be used with the -u command line argument, e.g. -u Mover
Examples:
  lifebot  # Displays the status of the default Bot
  lifebot -a login -l Home # Default Bot login to Home location
  lifebot -a touch_prim -n 'Jane Doe' -u Mover # Jane Doe bot touch object with aliased UUID
  lifebot -a teleport -l club  # Uses a 'club' location alias defined in .lifebots
```

</details>

<details><summary>Click here to view the

**lifebot source code**

</summary>

```bash
#!/usr/bin/env bash
#
# lifebot - control LifeBot bots from the command line using the LifeBot API
#
# Copyright (c) 2025 Truth & Beauty Lab
#
# Author:  Missy Restless <missyrestless@gmail.com>
# Date:    15-Nov-2025
# License: MIT
#
# Currently supported actions:
#   login, logout, status, bot_location, walkto, sit, teleport, listalias,
#   listinventory, reply_dialog, im, send_notice, send_group_im, attachments,
#   touch_attachment, touch_prim, set_hoverheight, get_outfit, get_outfits, wear_outfit
#
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
# Default chat channel
CHANNEL=0
# Default hover height adjustment
HEIGHT="-0.05"

BOLD=$(tput bold 2> /dev/null)
NORM=$(tput sgr0 2> /dev/null)
LINE=$(tput smul 2> /dev/null)

usage() {
  [ "${nobold}" ] && {
    BOLD=
    LINE=
    NORM=
  }
  printf "\n${BOLD}${LINE}Usage:${NORM} ${BOLD}lifebot [-dih] [-a action] [-l location] [-n name] [-k apikey] [-B text]"
  printf "\n\t [-C channel] [-F filter] [-M message] [-N name] [-O name] [-S subject] [-s secret] [-u uuid] [-z num]${NORM}"
  [ "$1" == "brief" ] && {
    printf "\n\n"
    exit 1
  }
  printf "\n${BOLD}${LINE}Where:${NORM}"
  printf "\n\t${BOLD}${LINE}-a action${NORM} specifies the API action (sit, teleport, login, ...)"
  printf "\n\t  Supported actions: login, logout, status (default), bot_location, walkto, sit, teleport,"
  printf "\n\t        listalias, listinventory, im, reply_dialog, send_notice, send_group_im,"
  printf "\n\t        attachments, touch_attachment, touch_prim, set_hoverheight, get_outfit, get_outfits, wear_outfit"
  printf "\n\t${BOLD}${LINE}-l location${NORM} specifies a location for login and teleport actions"
  printf "\n\t\tDefault: Last location, teleport action requires a Slurl location"
  printf "\n\t${BOLD}${LINE}-n name${NORM} specifies a Bot name, Default: Easy Islay"
  printf "\n\t${BOLD}${LINE}-k apikey${NORM} specifies an API Key, use environment instead"
  printf "\n\t${BOLD}${LINE}-B text${NORM} specifies the dialog button text for replies to dialog menus"
  printf "\n\t${BOLD}${LINE}-C channel${NORM} specifies the channel for a message [default: 0]"
  printf "\n\t${BOLD}${LINE}-F filter${NORM} specifies a filter to match when listing attachments"
  printf "\n\t${BOLD}${LINE}-M message${NORM} specifies the message body for a group notice/im"
  printf "\n\t${BOLD}${LINE}-N name${NORM} specifies the SL name of the recipient of an IM"
  printf "\n\t${BOLD}${LINE}-O name${NORM} specifies an attachment object name or outfit name"
  printf "\n\t${BOLD}${LINE}-S subject${NORM} specifies the subject for a group notice"
  printf "\n\t${BOLD}${LINE}-s secret${NORM} specifies a Bot secret, use environment instead"
  printf "\n\t${BOLD}${LINE}-u uuid${NORM} specifies a UUID for use with actions that require one (e.g. sit)"
  printf "\n\t${BOLD}${LINE}-z num${NORM} specifies a hover height adjustment size [default: -0.05]"
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
  printf "\n  lifebot -a touch_prim -n 'Jane Doe' -u Mover # Jane Doe bot touch object with aliased UUID"
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
    localias*|slurlalias*|alias*url*)
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
  COMMON="\"action\": \"${act}\", \
          \"apikey\": \"${LB_API_KEY}\", \
          \"botname\": \"${LB_BOT_NAME}\", \
          \"secret\": \"${LB_SECRET}\", \
          \"dataType\": \"json\""
  case "${act}" in
    listinventory|sit|touch_attachment|touch_prim)
      if [ "${dryrun}" ]; then
        if [ "${UUID}" ]; then
          echo "curl -s -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            ${COMMON},
            \"objectname\": \"${OBJ_NAME}\",
            \"uuid\": \"${UUID}\",
            \"extended\": true
          }\""
        else
          echo "curl -s -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            ${COMMON},
            \"objectname\": \"${OBJ_NAME}\"
          }\""
        fi
      else
        if [ "${UUID}" ]; then
          curl -s -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            ${COMMON},
            \"objectname\": \"${OBJ_NAME}\",
            \"uuid\": \"${UUID}\",
            \"extended\": true
          }"
        else
          curl -s -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            ${COMMON},
            \"objectname\": \"${OBJ_NAME}\"
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
            ${COMMON},
            \"siton\": \"${LOGIN_SITON}\",
            \"location\": \"${LOCATION}\"
          }\""
        else
          curl -s -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            ${COMMON},
            \"siton\": \"${LOGIN_SITON}\",
            \"location\": \"${LOCATION}\"
          }"
        fi
      else
        if [ "${dryrun}" ]; then
          echo "curl -s -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            ${COMMON},
            \"location\": \"${LOCATION}\"
          }\""
        else
          curl -s -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            ${COMMON},
            \"location\": \"${LOCATION}\"
          }"
        fi
      fi
      ;;
    reply_dialog)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"button\": \"${BUTTON}\",
          \"channel\": \"${CHANNEL}\",
          \"object\": \"${UUID}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"button\": \"${BUTTON}\",
          \"channel\": \"${CHANNEL}\",
          \"object\": \"${UUID}\"
        }"
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
          ${COMMON},
          \"slname\": \"${SL_NAME}\",
          \"groupuuid\": \"${GROUP_ID}\",
          \"subject\": \"${SUBJECT}\",
          \"channel\": \"${CHANNEL}\",
          \"${msg_label}\": \"${MESSAGE}\",
          \"autodelay\": \"1\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"slname\": \"${SL_NAME}\",
          \"groupuuid\": \"${GROUP_ID}\",
          \"subject\": \"${SUBJECT}\",
          \"channel\": \"${CHANNEL}\",
          \"${msg_label}\": \"${MESSAGE}\",
          \"autodelay\": \"1\"
        }"
      fi
      ;;
    set_hoverheight)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"height\": \"${HEIGHT}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"height\": \"${HEIGHT}\"
        }"
      fi
      ;;
    wear_outfit)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"outfitname\": \"${OUTFIT_NAME}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"outfitname\": \"${OUTFIT_NAME}\"
        }"
      fi
      ;;
    walkto)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"coords\": \"${LOCATION}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"coords\": \"${LOCATION}\"
        }"
      fi
      ;;
    attachments)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"matchnames\": \"${FILTER}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"matchnames\": \"${FILTER}\"
        }"
      fi
      ;;
    *)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON}
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON}
        }"
      fi
      ;;
  esac
}

ACTION_STR= BOT_NAME= BUTTON= FILTER= GROUP_ID= LOGIN_SITON= MESSAGE= OBJ_NAME= SL_NAME= SUBJECT= UUID=

[ -f ${HOME}/.lifebots ] && source ${HOME}/.lifebots

# Use jq to format JSON return if it is available
have_jq=$(type -p jq)

command_line_secret= details= dryrun= nobold=
while getopts ":a:B:C:dijF:l:M:N:n:O:k:S:s:u:z:Hh" flag; do
  case $flag in
    a)
      ACTION_STR="${OPTARG}"
      ;;
    B)
      BUTTON="${OPTARG}"
      ;;
    C)
      CHANNEL="${OPTARG}"
      ;;
    d)
      dryrun=1
      have_jq=
      ;;
    F)
      FILTER="${OPTARG}"
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
    O)
      OBJ_NAME="${OPTARG}"
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
    z)
      HEIGHT="${OPTARG}"
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

# If an action was specified on the command line, convert it to lowercase
# Use tr for portability
[ "${ACTION_STR}" ] && {
  ACTION=$(echo "${ACTION_STR}" | tr '[:upper:]' '[:lower:]')
}

case "${ACTION}" in
  walk*)
    [ "${LOCATION}" ] || {
      echo "The ${ACTION} action requires coordinates specified with -l coords"
      usage brief
    }
    [ "${LOCATION}" == "Last location" ] && {
      echo "The ${ACTION} action requires coordinates specified with -l coords"
      usage brief
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
  sendnoti*|send_noti*)
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
    [ "${show_usage}" ] && usage brief
    if [ "${have_jq}" ]; then
      send_request "send_notice" | jq -r .
    else
      send_request "send_notice"
    fi
    ;;
  reply*)
    show_usage=
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires an Object UUID specified with -u uuid"
      show_usage=1
    }
    [ "${BUTTON}" ] || {
      echo "The ${ACTION} action requires a button text specified with -B text"
      show_usage=1
    }
    [ ${CHANNEL} -eq 0 ] && {
      echo "The ${ACTION} action requires a non-zero channel specified with -C channel"
      show_usage=1
    }
    [ "${show_usage}" ] && usage brief
    if [ "${have_jq}" ]; then
      send_request "reply_dialog" | jq -r .
    else
      send_request "reply_dialog"
    fi
    ;;
  sendgroupi*|send_group_i*)
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
    [ "${show_usage}" ] && usage brief
    if [ "${have_jq}" ]; then
      send_request "send_group_im" | jq -r .
    else
      send_request "send_group_im"
    fi
    ;;
  im|instantm*)
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
    [ "${show_usage}" ] && usage brief
    if [ "${have_jq}" ]; then
      send_request "im" | jq -r .
    else
      send_request "im"
    fi
    ;;
  say*|say_*)
    [ "${MESSAGE}" ] || {
      echo "The ${ACTION} action requires a Message body specified with -M message"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "say_chat_channel" | jq -r .
    else
      send_request "say_chat_channel"
    fi
    ;;
  *height*|*hover*)
    [ "${HEIGHT}" ] || {
      echo "The ${ACTION} action requires a hover height adjustment specified with -z num"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "set_hoverheight" | jq -r .
    else
      send_request "set_hoverheight"
    fi
    ;;
  wear*|*outfit)
    [ "${OBJ_NAME}" ] && OUTFIT_NAME="${OBJ_NAME}"
    [ "${OUTFIT_NAME}" ] || {
      echo "The ${ACTION} action requires an outfit name specified with -O name"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "wear_outfit" | jq -r .
    else
      send_request "wear_outfit"
    fi
    ;;
  touch*attach*)
    [ "${OBJ_NAME}" ] || {
      echo "The ${ACTION} action requires an attachment object name specified with -O name"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "touch_attachment" | jq -r .
    else
      send_request "touch_attachment"
    fi
    ;;
  touch*)
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires a UUID specified with -u uuid"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "touch_prim" | jq -r .
    else
      send_request "touch_prim"
    fi
    ;;
  teleport|tp)
    [ "${LOCATION}" ] || {
      echo "The teleport action requires a location specified with -l location"
      usage brief
    }
    [ "${LOCATION}" == "Last location" ] && {
      echo "The teleport action requires a location specified with -l location"
      usage brief
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
  sit)
    [ "${UUID}" ] || {
      echo "The sit action requires a UUID specified with -u uuid"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "sit" | jq -r .
    else
      send_request "sit"
    fi
    ;;
  stand)
    if [ "${have_jq}" ]; then
      send_request "stand" | jq -r .
    else
      send_request "stand"
    fi
    ;;
  status)
    if [ "${have_jq}" ]; then
      send_request "status" | jq -r .
    else
      send_request "status"
    fi
    ;;
  listinventory|inventory)
    if [ "${have_jq}" ]; then
      send_request "listinventory" | jq -r .
    else
      send_request "listinventory"
    fi
    ;;
  botalias*|localias*|slurlalias*|uuidalias*|listalias*|alias*)
    list_aliases "${ACTION}"
    ;;
  login)
    if [ "${have_jq}" ]; then
      send_request "login" | jq -r .
    else
      send_request "login"
    fi
    ;;
  logout)
    if [ "${have_jq}" ]; then
      send_request "logout" | jq -r .
    else
      send_request "logout"
    fi
    ;;
  location|loc|bot*loc*)
    if [ "${have_jq}" ]; then
      send_request "bot_location" | jq -r .
    else
      send_request "bot_location"
    fi
    ;;
  get_outfit*|getoutfit*|list_outfit*|listoutfit*)
    if echo "${ACTION}" | grep -i outfits >/dev/null; then
      if [ "${have_jq}" ]; then
        send_request "get_outfits" | jq -r .
      else
        send_request "get_outfits"
      fi
    else
      if [ "${have_jq}" ]; then
        send_request "get_outfit" | jq -r .
      else
        send_request "get_outfit"
      fi
    fi
    ;;
  *attach*)
    if [ "${have_jq}" ]; then
      send_request "attachments" | jq -r .
    else
      send_request "attachments"
    fi
    ;;
  *)
    echo "Action '${ACTION}' not yet supported"
    echo "Currently supported actions:"
    echo "  login, logout, status, bot_location, walkto, sit, teleport, listalias, listinventory,"
    echo "  im, reply_dialog, send_notice, send_group_im, attachments, touch_attachment, touch_prim,"
    echo "  set_hoverheight, get_outfit, get_outfits, wear_outfit"
    ;;
esac
```

</details>

### Scheduling Bot Actions

The Truth & Beauty Lab utilizes the `Cron` subsystem on Linux and Macos to
schedule `LifeBots` actions. Truth & Beauty Lab bots are logged in, teleported
to various locations, seated on various objects, and engaged in a variety of
activities using `crontab` entries that execute `LifeBots` API requests at
scheduled times. Here is an example `crontab` entry with some brief descriptions
in comments of what activities are scheduled:

```
SHELL=/bin/bash
#
# Schedule LifeBots actions
# -------------------------
# Uses the lifebot command line tool at:
#   https://github.com/missyrestless/Bots/blob/main/LifeBots/lifebot
# Assumes some configuration in ~/.lifebots has been performed
#
# m h  dom mon dow   command
#
# Weekdays send Anya bot to the club at 4am
0 4 * * 1-5 /bin/bash -lc /usr/local/LifeBots/anya2club >> /usr/local/LifeBots/log/cron.log 2>&1
# Weekends send Anya bot to the beach at 11am
0 11 * * 0,6 /bin/bash -lc /usr/local/LifeBots/anya2beach >> /usr/local/LifeBots/log/cron.log 2>&1
# Monday at 4pm send Anya bot to DJ at the Media Sphere
0 16 * * 1 /bin/bash -lc /usr/local/LifeBots/anya2msdj >> /usr/local/LifeBots/log/cron.log 2>&1
# Monday at 6pm sit Anya in theater seating after her set
0 18 * * 1 /bin/bash -lc /usr/local/LifeBots/anya2seat >> /usr/local/LifeBots/log/cron.log 2>&1
# Tuesday at 6pm send Angelus bot to DJ at the club
0 18 * * 2 /bin/bash -lc /usr/local/LifeBots/angelus2clubdj >> /usr/local/LifeBots/log/cron.log 2>&1
# Tuesday at 8pm send Angelus bot back to his dance pole
0 20 * * 2 /bin/bash -lc /usr/local/LifeBots/angelus2pole >> /usr/local/LifeBots/log/cron.log 2>&1
# Friday at 6pm send Easy bot to DJ at the club
0 18 * * 5 /bin/bash -lc /usr/local/LifeBots/easy2clubdj >> /usr/local/LifeBots/log/cron.log 2>&1
# Friday at 8pm send Easy bot back to her dance pole
0 20 * * 5 /bin/bash -lc /usr/local/LifeBots/easy2pole >> /usr/local/LifeBots/log/cron.log 2>&1
# Saturday at 6pm send all bots to dance at the club
0 18 * * 6 /bin/bash -lc /usr/local/LifeBots/bots2clubdance >> /usr/local/LifeBots/log/cron.log 2>&1
# Saturday at 9pm send all bots back to their default locations
0 21 * * 6 /bin/bash -lc /usr/local/LifeBots/bots2home >> /usr/local/LifeBots/log/cron.log 2>&1
# Check every hour if Easy bot is at the club greeting visitors
0 * * * * /bin/bash -lc /usr/local/LifeBots/checkeasy >> /usr/local/LifeBots/log/cron.log 2>&1
```

Here is the code for one of the control scripts executed by a `cron` job, the `checkeasy`
script that keeps a Greeter bot in the club:

```bash
#!/usr/bin/env bash

export PATH="/usr/local/bin:${PATH}"
[ -d /opt/homebrew/bin ] && {
  export PATH="/opt/homebrew/bin:${PATH}"
}

have_lb=$(type -p lifebot)
[ "${have_lb}" ] || {
  echo "ERROR: cannot locate lifebot in PATH"
  exit 1
}
have_jq=$(type -p jq)
[ "${have_jq}" ] || {
  echo "ERROR: cannot locate jq in PATH"
  exit 1
}

# Check if Easy is online and if not, login
lifebot -a status -n Easy | jq -r '.status' | grep -i online >/dev/null || {
  lifebot -a login -n Easy -l club
  sleep 20
}

# Check if Easy is at the club and if not, teleport
lifebot -a status -n Easy | jq -r '.location' | grep Scylla >/dev/null || {
  lifebot -a teleport -n Easy -l club
}
```

This script uses a couple of aliases defined in `$HOME/.lifebots`, the `club`
location alias and the `Easy` bot name alias:

```bash
export BOT_NAME_Easy="Easy Islay"
export SLURL_club="http://maps.secondlife.com/secondlife/Scylla/226/32/78"
```

Aliases provide some convenience. For example, the command

```bash
lifebot -a teleport -n Easy -l club
```

is just an easier way of issuing the command

```bash
lifebot -a teleport -n "Easy Islay" -l "http://maps.secondlife.com/secondlife/Scylla/226/32/78"
```

## Corrade

The primary advantage of `Corrade` over `LifeBots` is the ability to
self-host `Corrade` meaning I can run it on my own computers, manage
and update it myself, and my bots are not dependant on some cloud service
that may disappear at any time. This is a significant advantage.

`Corrade` is a multi-purpose, multi-platform scripted agent (bot) that runs
under Windows or Unix natively, as a service or daemon whilst staying connected
to a Linden-based grid (either Second Life or OpenSim) and controlled entirely
by scripts. We like to think of Corrade as a bridge, that gives access to
viewer-commands to LSL scripts. Corrade does not stop at providing viewer-commands
to LSL scripts but reaches into the Internet of Things (IoT), Big Data and
Artificial Intelligence (AI) by implementing the latest technologies and
communication protocols. Corrade's target audience consists of programmers
that will use Corrade as a building block and then create an end-product.

The scripts in this repository are original scripting by Truth & Beauty Lab
along with modified versions of scripts distributed under an Open Source
license found at:

https://grimore.org/secondlife/scripted_agents/corrade/projects/in_world

## Corrade HUD

Current Truth & Beauty Lab Corrade development centers around the
[Corrade HUD](https://github.com/missyrestless/Bots/blob/main/HUD/README.md),
an in-world heads-up display that can be used to control a Corrade scripted agent.
