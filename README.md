# Second Life Bots

This repository contains commands, configuration, and management scripts for Second Life
scripted agents (bots). Included are management systems for `Corrade` and `LifeBots`.

**[NOTE:]** Missy Restless and the Truth &amp; Beauty Lab are not affiliated with
`Corrade` or `LifeBots` other than contributing `LifeBots` Knowledge Base articles.
This repository provides 3rd party tools for `Corrade` and `LifeBots` and is not
the official product of either. The official `LifeBots` site can be found at
[https://lifebots.cloud](https://lifebots.cloud) and `Corrade` at
[https://grimore.org/secondlife/scripted_agents/corrade](https://grimore.org/secondlife/scripted_agents/corrade).

## Table of Contents

- [Repository Contents](#repository-contents)
- [LifeBots](#lifebots)
  - [Requirements](#requirements)
  - [Install lifebot](#install-lifebot)
  - [Configure lifebot](#configure-lifebot)
  - [Supported Bot Actions and Examples](#supported-bot-actions-and-examples)
  - [Usage and Source of lifebot command](#usage-and-source-of-lifebot-command)
  - [Scheduling Bot Actions](#scheduling-bot-actions)
  - [Using the JSON return as Input](#using-the-json-return-as-input)
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

[LifeBots](https://lifebots.cloud) bills itself as:

> The most advanced bot platform for Second Life. From AI characters to
> complete group automation, we've got everything your community needs.

I cannot disagree - `LifeBots` is the most advanced bot platform for Second Life.

`LifeBots` offers 2 subscription plans, `Lite` and `Full`. The plans provide these features:

| `LifeBots` Lite (`L$165/wk`) | `LifeBots` Full (`L$450/wk`) |
|:---------------------------- |:---------------------------- |
| Basic bot functionality      | All Lite Bot features        |
| Greeter Bot addon            | Group Notice scheduling      |
| HUD Support                  | Group IM scheduling          |
| Dialog Menu Interactions     | Group Web Chat               |
| RLV capabilities             | Group Discord Sync           |
| Compatible addons support    | Complete addon support       |
| API access                   | Advanced AI integration      |
| Email support                | Priority support             |
| Web dashboard access         | Custom scripting             |
| AI Access                    | AI Functions                 |
|                              | Avatar Specific Memory       |
|                              | Advanced analytics           |

This repository provides a command line management system for `LifeBots`.

Both `LifeBots` subscription plans provide a web UI and HUD that can be used for
interactive control of `LifeBots` bots and, for many users, this is sufficient.

For those power users who wish to automate their `LifeBots` using the command line
and tools such as `cron` and `jq` the `lifebot` command and associated utilities
found here may provide additional power and flexibility. The `LifeBots` command line
management system is open source and free to download, deploy, modify, and distribute.

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

#### Basic Commands

- `bot_location` : get precise bot location
- `key2name` : convert an avatar name to avatar UUID
- `login` : login bot
- `logout` : logout bot
- `name2key` : convert an avatar UUID to avatar name
- `status` : get bot status

#### Movement Commands

- `sit` : sit on a specified object UUID
- `stand` : make bot stand up
- `teleport` : teleport bot to specified location
- `walkto` : walk bot to a location

#### Communication

- `im` : send an instant message to an avatar
- `reply_dialog` : reply to a dialog menu (requires channel, UUID, and button text)
- `say_chat_channel` : send a message to the specified chat channel
- `send_group_im` : send an instant message to a group
- `send_notice` : send an official group notice to all group members

#### Inventory Management

- `get_outfit` : list currently worn bot outfit
- `get_outfits` : list available bot outfits
- `listinventory` : list bot inventory, optionally specify an inventory folder UUID
- `set_hoverheight` : adjust bot hover height
- `takeoff` : remove a worn item
- `wear` : wear an inventory item (uses "add" rather than "wear")
- `wear_outfit` : wear a specified outfit

#### Group Management

- `activate_group` : activate a group tag

#### Money &amp; Transactions

- `get_balance` : get your bot's L$ balance
- `give_money` : pay another avatar L$ from your bot
- `give_money_object` : pay an object L$ from your bot

#### Object Interaction

- `attachments` : list bot attachments, optionally specify a filter to match
- `touch_attachment` : touch a specified bot attachment
- `touch_prim` : touch a specified object by UUID

#### Lifebot Configuration

- `listalias` : list configured `lifebot` aliases in `$HOME/.lifebots`

**[NOTE:]** the examples below all assume you have configured `$HOME/.lifebots`
with your `LifeBots` API key and the bot secret:

```bash
# LifeBots Developer API Key
export LB_API_KEY='<redacted>'
## John Doebot LifeBots secret
export LB_SECRET_John_Doebot='<redacted>'
```

<details><summary>Click here to view the

**lifebot command examples**

</summary>

The following actions and commands, along with example command line invocations,
are supported by the `lifebot` command.

- `activate_group` : activate a group tag
  - `Example` : activate the specified group tag for bot `John Doebot`
  - `lifebot -a activate -n "John Doebot" -u "f8e95201-20af-b85f-a682-7ac25ab9fcaf"`
    - If `~/.lifebots` contains : `export UUID_pay2play="f8e95201-20af-b85f-a682-7ac25ab9fcaf"`
    - `lifebot -a activate -n "John Doebot" -u pay2play`
- `attachments` : list bot attachments, optionally specify a filter to match
  - `Example` : list bot named `John Doebot` attachments with name containing the string `HUD`
  - `lifebot -a attachments -F "HUD" -n "John Doebot"`
- `bot_location` : get precise bot location
  - `Example` : get location of bot named `John Doebot`
  - `lifebot -a location -n "John Doebot"`
- `get_balance` : get your bot's L$ balance
  - `Example` : get the L$ balance of bot `John Doebot`
  - `lifebot -a balance -n "John Doebot"`
- `get_outfit` : list currently worn bot outfit
  - `Example` : list currently worn outfit of bot named `John Doebot`
  - `lifebot -a get_outfit -n "John Doebot"`
- `get_outfits` : list available bot outfits
  - `Example` : list available outfits for bot named `John Doebot`
  - `lifebot -a get_outfits -n "John Doebot"`
- `give_money` : pay another avatar L$ from your bot
  - `Example` : pay avatar with specified UUID L$300 from bot `John Doebot`
  - `lifebot -a give_money -n "John Doebot" -u "3506213c-29c8-4aa1-a38f-e12f6d41b804" -z 300`
- `give_money_object` : pay an object L$ from your bot
  - `Example` : pay a tip jar with specified UUID L$100 from bot `John Doebot`
  - `lifebot -a give_money_object -n "John Doebot" -u "47cb1fc7-8144-b538-6716-c723fb1332d6" -z 100`
- `im` : send an instant message to an avatar
  - `Example` : send IM from `John Doebot` to avatar "Jane Free"
  - `lifebot -a im -n "John Doebot" -N "Jane Free" -M 'Hi Jane, do you want to meetup?'`
- `key2name` : convert an avatar UUID to avatar name
  - `Example` : use `John Doebot` bot to get avatar name of specified UUID
  - `lifebot -a key2name -n "John Doebot" -u "3506213c-29c8-4aa1-a38f-e12f6d41b804"`
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
- `name2key` : convert an avatar name to avatar UUID
  - `Example` : use `John Doebot` bot to get avatar UUID of Missy Restless
  - `lifebot -a name2key -n "John Doebot" -N "Missy Restless"`
- `reply_dialog` : reply to a dialog menu (requires channel, UUID, and button text)
  - `Example` : click couch menu button "Male" on channel 99999
  - `lifebot -a reply -n "John Doebot" -C 99999 -B Male -u "a811d6fe-de59-2f4e-ee19-0cc48da48981"`
- `say_chat_channel` : send a message to the specified chat channel
  - `Example` : send a message on channel 0, visible to everyone nearby
  - `lifebot -a say -n "John Doebot" -C 0 -M "Hi everyone, you look great"`
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
- `stand` :  make bot stand up
  - `Example` : make bot `John Doebot` stand up
  - `lifebot -a stand -n "John Doebot"`
- `status` : get bot status
  - `Example` : get status of bot `John Doebot` (status is default action)
  - `lifebot -n "John Doebot"`
- `takeoff` : remove a worn item
  - `Example` : bot `John Doebot` remove the specified inventory item
  - `lifebot -a takeoff -n "John Doebot" -u "d666e910-ba72-0c11-a66e-c3759d8af0f5"`
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
- `wear` : wear an inventory item (uses "add" rather than "wear")
  - `Example` : bot `John Doebot` wear the specified inventory item
  - `lifebot -a wear -n "John Doebot" -u "d666e910-ba72-0c11-a66e-c3759d8af0f5"`
- `wear_outfit` : wear a specified outfit
  - `Example` : bot named `John Doebot` wear the outfit named "Business Casual"
  - `lifebot -a wear_outfit -n "John Doebot" -O "Business Casual"`
    - If `~/.lifebots` contains : `export LB_BOT_NAME='John Doebot'`
    - `lifebot -a wear_outfit -O "Business Casual"`

</details>

Development is in rapid progress for additional actions.

Let us know which `LifeBots` API requests you would like supported.

### Usage and Source of lifebot command

<details><summary>Click here to view the

**lifebot command usage message**

</summary>

```
Usage: lifebot [-deih] [-a action] [-l location] [-n name] [-k apikey] [-B text] [-C channel]
	[-F filter] [-M message] [-N name] [-O name] [-S subject] [-s secret] [-u uuid] [-z num]
Where:
	-a action specifies the API action (sit, teleport, login, ...)
	Supported actions:
	  login, logout, status (default), bot_location, walkto, sit, teleport, listalias, key2name,
	  name2key, listinventory, im, reply_dialog, send_notice, send_group_im, attachments,
	  touch_attachment, touch_prim, activate_group, wear, takeoff, set_hoverheight,
	  get_outfit, get_outfits, wear_outfit, get_balance, give_money, give_money_object
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
		can also be used to specify a payment amount
	-d indicates dryrun mode - tell me what you would do without doing anything
	-e displays a list of supported commands and examples then exits
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
#   login, logout, status, bot_location, walkto, sit, stand, teleport, listalias, key2name,
#   name2key, listinventory, im, reply_dialog, send_notice, send_group_im, attachments,
#   touch_attachment, touch_prim, activate_group, wear, takeoff, say_chat_channel, set_hoverheight,
#   get_outfit, get_outfits, wear_outfit, get_balance, give_money, give_money_object
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
  printf "\n${BOLD}${LINE}Usage:${NORM} ${BOLD}lifebot [-deih] [-a action] [-l location] [-n name] [-k apikey] [-B text] [-C channel]"
  printf "\n\t[-F filter] [-M message] [-N name] [-O name] [-S subject] [-s secret] [-u uuid] [-z num]${NORM}"
  [ "$1" == "brief" ] && {
    printf "\n\n"
    exit 1
  }
  printf "\n${BOLD}${LINE}Where:${NORM}"
  printf "\n\t${BOLD}${LINE}-a action${NORM} specifies the API action (sit, teleport, login, ...)"
  printf "\n\tSupported actions:"
  printf "\n\t  login, logout, status (default), bot_location, walkto, sit, stand, teleport, listalias, key2name,"
  printf "\n\t  name2key, listinventory, im, reply_dialog, send_notice, send_group_im, attachments,"
  printf "\n\t  touch_attachment, touch_prim, activate_group, wear, takeoff, say_chat_channel, set_hoverheight,"
  printf "\n\t  get_outfit, get_outfits, wear_outfit, get_balance, give_money, give_money_object"
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
  printf "\n\t\tcan also be used to specify a payment amount"
  printf "\n\t${BOLD}${LINE}-d${NORM} indicates dryrun mode - tell me what you would do without doing anything"
  printf "\n\t${BOLD}${LINE}-e${NORM} displays a list of supported commands and examples then exits"
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

examples() {
  printf "\nThe following actions and commands, along with example command"
  printf "\nline invocations, are supported by the lifebot command.\n"

  printf "\nactivate_group : activate a group tag"
  printf "\n\tExample : activate the specified group tag for bot John Doebot"
  printf "\n\tlifebot -a activate -n \"John Doebot\" -u \"f8e95201-20af-b85f-a682-7ac25ab9fcaf\""
  printf "\n\t\tIf ~/.lifebots contains : export UUID_pay2play=\"f8e95201-20af-b85f-a682-7ac25ab9fcaf\""
  printf "\n\t\tlifebot -a activate -n \"John Doebot\" -u pay2play"
  printf "\nattachments : list bot attachments, optionally specify a filter to match"
  printf "\n\tExample : list bot named John Doebot attachments with name containing the string HUD"
  printf "\n\tlifebot -a attachments -F \"HUD\" -n \"John Doebot\""
  printf "\nbot_location : get precise bot location"
  printf "\n\tExample : get location of bot named John Doebot"
  printf "\n\tlifebot -a location -n \"John Doebot\""
  printf "\nget_balance : get your bot's L$ balance"
  printf "\n\tExample : get the L$ balance of bot John Doebot"
  printf "\n\tlifebot -a balance -n \"John Doebot\""
  printf "\nget_outfit : list currently worn bot outfit"
  printf "\n\tExample : list currently worn outfit of bot named John Doebot"
  printf "\n\tlifebot -a get_outfit -n \"John Doebot\""
  printf "\nget_outfits : list available bot outfits"
  printf "\n\tExample : list available outfits for bot named John Doebot"
  printf "\n\tlifebot -a get_outfits -n \"John Doebot\""
  printf "\ngive_money : pay another avatar L$ from your bot"
  printf "\n\tExample : pay avatar with specified UUID L$300 from bot John Doebot"
  printf "\n\tlifebot -a give_money -n \"John Doebot\" -u \"3506213c-29c8-4aa1-a38f-e12f6d41b804\" -z 300"
  printf "\ngive_money_object : pay an object L$ from your bot"
  printf "\n\tExample : pay a tip jar with specified UUID L$100 from bot John Doebot"
  printf "\n\tlifebot -a give_money_object -n \"John Doebot\" -u \"47cb1fc7-8144-b538-6716-c723fb1332d6\" -z 100"
  printf "\nim : send an instant message to an avatar"
  printf "\n\tExample : send IM from John Doebot to avatar \"Jane Free\""
  printf "\n\tlifebot -a im -n \"John Doebot\" -N \"Jane Free\" -M 'Hi Jane, do you want to meetup?'"
  printf "\nkey2name : convert an avatar UUID to avatar name"
  printf "\n\tExample : use John Doebot bot to get avatar name of specified UUID"
  printf "\n\tlifebot -a key2name -n \"John Doebot\" -u \"3506213c-29c8-4aa1-a38f-e12f6d41b804\""
  printf "\nlistalias : list configured lifebot aliases in $HOME/.lifebots"
  printf "\n\tExample : list all configured lifebot aliases"
  printf "\n\tlifebot -a listalias"
  printf "\n\tExample : list configured lifebot bot aliases only"
  printf "\n\tlifebot -a botalias"
  printf "\n\tExample : list configured lifebot location aliases only"
  printf "\n\tlifebot -a slurlalias"
  printf "\n\tExample : list configured lifebot UUID aliases only"
  printf "\n\tlifebot -a uuidalias"
  printf "\nlistinventory : list bot inventory, optionally specify an inventory folder UUID"
  printf "\n\tExample : list inventory of bot named John Doebot"
  printf "\n\tlifebot -a listinventory -n \"John Doebot\""
  printf "\nlogin : login bot"
  printf "\n\tExample : login bot named John Doebot"
  printf "\n\tlifebot -a login -n \"John Doebot\""
  printf "\nlogout : logout bot"
  printf "\n\tExample : logout bot named John Doebot"
  printf "\n\tlifebot -a logout -n \"John Doebot\""
  printf "\nname2key : convert an avatar name to avatar UUID"
  printf "\n\tExample : use John Doebot bot to get avatar UUID of Missy Restless"
  printf "\n\tlifebot -a name2key -n \"John Doebot\" -N \"Missy Restless\""
  printf "\nreply_dialog : reply to a dialog menu (requires channel, UUID, and button text)"
  printf "\n\tExample : click couch menu button \"Male\" on channel 99999"
  printf "\n\tlifebot -a reply -n \"John Doebot\" -C 99999 -B Male -u \"a811d6fe-de59-2f4e-ee19-0cc48da48981\""
  printf "\nsay_chat_channel : send a message to the specified chat channel"
  printf "\n\tExample : send a message on channel 0, visible to everyone nearby"
  printf "\n\tlifebot -a say -n \"John Doebot\" -C 0 -M \"Hi everyone, you look great\""
  printf "\nsend_group_im : send an instant message to a group"
  printf "\n\tExample : send IM to a group from bot named John Doebot"
  printf "\n\tlifebot -a send_group_im -n \"John Doebot\" -u \"f7d3c1b9-a141-9546-7e2d-dfd698c5df7c\" -M \"Meeting at Noon SLT tomorrow\""
  printf "\nsend_notice : send an official group notice to all group members"
  printf "\n\tExample : send group notice with subject and message from bot named John Doebot"
  printf "\n\tlifebot -a send_notice -n \"John Doebot\" -u \"f7d3c1b9-a141-9546-7e2d-dfd698c5df7c\" -M \"Meeting at Noon SLT tomorrow\" -S \"Meeting Tomorrow\""
  printf "\nset_hoverheight : adjust bot hover height"
  printf "\n\tExample : lower hover height of bot John Doebot by 0.05"
  printf "\n\tlifebot -a height -n \"John Doebot\" -z \"-0.05\""
  printf "\nsit : sit on a specified object UUID"
  printf "\n\tExample : sit bot named John Doebot on an object"
  printf "\n\tlifebot -a sit -n \"John Doebot\" -u \"d46e217b-fb5c-4796-bae3-ea016b280210\""
  printf "\nstand : make a bot stand up"
  printf "\n\tExample : make bot John Doebot stand up"
  printf "\n\tlifebot -a stand -n \"John Doebot\""
  printf "\nstatus : get bot status"
  printf "\n\tExample : get status of bot John Doebot (status is default action)"
  printf "\n\tlifebot -n \"John Doebot\""
  printf "\ntakeoff : remove a worn item"
  printf "\n\tExample : bot John Doebot remove the specified inventory item"
  printf "\n\tlifebot -a takeoff -n \"John Doebot\" -u \"d666e910-ba72-0c11-a66e-c3759d8af0f5\""
  printf "\nteleport : teleport bot to specified location"
  printf "\n\tExample : teleport bot John Doebot to the aliased location \"club\""
  printf "\n\tRequires an entry of the following form in $HOME/.lifebots"
  printf "\n\t\texport SLURL_club=\"http://maps.secondlife.com/secondlife/Scylla/226/32/78\""
  printf "\n\tlifebot -a teleport -n \"John Doebot\" -l club"
  printf "\ntouch_attachment : touch a specified bot attachment"
  printf "\n\tExample : bot John Doebot touch attachment named \"HUD Controller\""
  printf "\n\tlifebot -a touch_attachment -n \"John Doebot\" -O \"HUD Controller\""
  printf "\ntouch_prim : touch a specified object by UUID"
  printf "\n\tExample : bot named John Doebot touch an object"
  printf "\n\tlifebot -a touch_prim -n \"John Doebot\" -u \"f11781d0-763f-52f9-4e23-3a2b97759fa2\""
  printf "\n\t\tIf ~/.lifebots contains : export UUID_spoton=\"f11781d0-763f-52f9-4e23-3a2b97759fa2\""
  printf "\n\t\tlifebot -a touch_prim -n \"John Doebot\" -u spoton"
  printf "\nwalkto : walk bot to a location"
  printf "\n\tExample : bot named John Doebot walk to X/Y/Z coordinates 100/50/28"
  printf "\n\tlifebot -a walkto -n \"John Doebot\" -l \"100/50/28\""
  printf "\nwear : wear an inventory item (uses \"add\" rather than \"wear\")"
  printf "\n\tExample : bot John Doebot wear the specified inventory item"
  printf "\n\tlifebot -a wear -n \"John Doebot\" -u \"d666e910-ba72-0c11-a66e-c3759d8af0f5\""
  printf "\nwear_outfit : wear a specified outfit"
  printf "\n\tExample : bot named John Doebot wear the outfit named \"Business Casual\""
  printf "\n\tlifebot -a wear_outfit -n \"John Doebot\" -O \"Business Casual\""
  printf "\n\t\tIf ~/.lifebots contains : export LB_BOT_NAME='John Doebot'"
  printf "\n\t\tlifebot -a wear_outfit -O \"Business Casual\"\n"
  exit 1
}

is_valid_uuid() {
  local uuid="$1"
  if [[ "$uuid" =~ ^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$ ]]; then
    return 0 # Valid UUID
  else
    return 1 # Invalid UUID
  fi
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
    key2name)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"key\": \"${UUID}\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"key\": \"${UUID}\"
        }"
      fi
      ;;
    name2key)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"name\": \"${SL_NAME}\",
          \"request_case\": \"1\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"name\": \"${SL_NAME}\",
          \"request_case\": \"1\"
        }"
      fi
      ;;
    give_money|give_money_object)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"avatar\": \"${AVATAR_UUID}\",
          \"object_uuid\": \"${OBJECT_UUID}\",
          \"amount\": ${AMOUNT}
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"avatar\": \"${AVATAR_UUID}\",
          \"object_uuid\": \"${OBJECT_UUID}\",
          \"amount\": ${AMOUNT}
        }"
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
    activate_group|im|say_chat_channel|send_group_im|send_notice)
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
    takeoff|wear)
      if [ "${dryrun}" ]; then
        echo "curl -s -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"uuid\": \"${UUID}\",
          \"wear\": \"add\"
        }\""
      else
        curl -s -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"uuid\": \"${UUID}\",
          \"wear\": \"add\"
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

ACTION_STR= AMOUNT= BOT_NAME= BUTTON= FILTER= GROUP_ID=
LOGIN_SITON= MESSAGE= OBJ_NAME= SL_NAME= SUBJECT= UUID=

[ -f ${HOME}/.lifebots ] && source ${HOME}/.lifebots

# Use jq to format JSON return if it is available
have_jq=$(type -p jq)

command_line_secret= details= dryrun= nobold=
while getopts ":a:B:C:dijF:l:M:N:n:O:k:S:s:u:z:Heh" flag; do
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
      AMOUNT="${OPTARG}"
      ;;
    e)
      examples
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
  # Check if UUID is a valid Second Life UUID, if not then check for alias
  is_valid_uuid "${UUID}" || {
    botuuid=$(echo "${UUID}" | sed -e "s/ /_/g")
    envuuid="UUID_${botuuid}"
    [ "${!envuuid}" ] && UUID="${!envuuid}"
  }
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
  get_balance|balance)
    if [ "${have_jq}" ]; then
      send_request "get_balance" | jq -r .
    else
      send_request "get_balance"
    fi
    ;;
  pay_avatar|give_money)
    show_usage=
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires an Avatar UUID specified with -u uuid"
      show_usage=1
    }
    [ "${AMOUNT}" ] || {
      echo "The ${ACTION} action requires an amount to pay in L\$ specified with -z num"
      show_usage=1
    }
    [ "${show_usage}" ] && usage brief

    if [[ "${AMOUNT}" =~ ^[0-9]+$ ]]; then
      AVATAR_UUID="${UUID}"
      if [ "${have_jq}" ]; then
        send_request "give_money" | jq -r .
      else
        send_request "give_money"
      fi
    else
      echo "Amount specified to pay must be a positive integer."
      usage brief
    fi
    ;;
  pay_object|give_money_object)
    show_usage=
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires an Object UUID specified with -u uuid"
      show_usage=1
    }
    [ "${AMOUNT}" ] || {
      echo "The ${ACTION} action requires an amount to pay in L\$ specified with -z num"
      show_usage=1
    }
    [ "${show_usage}" ] && usage brief

    if [[ "${AMOUNT}" =~ ^[0-9]+$ ]]; then
      OBJECT_UUID="${UUID}"
      if [ "${have_jq}" ]; then
        send_request "give_money_object" | jq -r .
      else
        send_request "give_money_object"
      fi
    else
      echo "Amount specified to pay must be a positive integer."
      usage brief
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
  activate*)
    if [ "${UUID}" ]; then
      GROUP_ID="${UUID}"
    else
      echo "The ${ACTION} action requires a Group UUID specified with -u uuid"
      usage brief
    fi
    if [ "${have_jq}" ]; then
      send_request "activate_group" | jq -r .
    else
      send_request "activate_group"
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
  key*name)
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires an avatar UUID specified with -u uuid"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "key2name" | jq -r .
    else
      send_request "key2name"
    fi
    ;;
  name*key)
    [ "${SL_NAME}" ] || {
      echo "The ${ACTION} action requires an SL Name specified with -N name"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "name2key" | jq -r .
    else
      send_request "name2key"
    fi
    ;;
  im|instantm*)
    show_usage=
    # If recipient SL name was not specified on command line then use UUID
    [ "${SL_NAME}" ] || {
      if [ "${UUID}" ]; then
        SL_NAME="${UUID}"
      else
        echo "The ${ACTION} action requires an SL Name or UUID specified with -N name or -u uuid"
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
  takeoff|remove)
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires an item UUID to remove specified with -u uuid"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "takeoff" | jq -r .
    else
      send_request "takeoff"
    fi
    ;;
  wear)
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires an item UUID to wear specified with -u uuid"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "wear" | jq -r .
    else
      send_request "wear"
    fi
    ;;
  wear*|replace*outfit)
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
  attach*|list*attach*)
    if [ "${have_jq}" ]; then
      send_request "attachments" | jq -r .
    else
      send_request "attachments"
    fi
    ;;
  *)
    echo "Action '${ACTION}' not yet supported"
    echo "Currently supported actions:"
    echo "  login, logout, status, bot_location, walkto, sit, stand, teleport, listalias, key2name,"
    echo "  name2key, listinventory, im, reply_dialog, send_notice, send_group_im, attachments,"
    echo "  touch_attachment, touch_prim, activate_group, wear, takeoff, say_chat_channel, set_hoverheight,"
    echo "  get_outfit, get_outfits, wear_outfit, get_balance, give_money, give_money_object"
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

### Using the JSON return as Input

The `lifebot` command returns a JSON object containing the results of the API request. This
object can be parsed with `jq` and the return values used as input to another `lifebot` command.

For example, if you want to send all of the L$ balance of your bot to yourself:

```bash
#!/bin/bash
#
# Get the John Doebot bot's balance and send it to myself

MY_UUID="3506213c-29c8-4aa1-a38f-e12f6d41b804"
MY_BOT="John Doebot"

# Get the bot's balance
BALANCE=$(lifebot -a balance -n "${MY_BOT}" | jq -r '.balance')

# Send balance to myself if it is greater than 0
[ ${BALANCE} -gt 0 ] && {
  lifebot -a give_money -n "${MY_BOT}" -u "${MY_UUID}" -z ${BALANCE}
}
```

A script like this could be used to automate transfer of L$ from your bots to your
primary avatar. For example, automated transfer of a bot's L$ balance on the 1st of
every month could be setup to run as a `cron` job with the following `crontab` entry:

```
# Send the Easy Islay bot's L$ balance to myself on the 1st of every month
0 0 1 * * /bin/bash -lc /usr/local/LifeBots/send_easy_balance >> /usr/local/LifeBots/log/easy.log 2>&1
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
