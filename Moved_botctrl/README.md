# BotControl Second Life Bots Command Line Control

**NEW** The `botctrl` command now supports management of both `LifeBots` and `Corrade` bots.
To manage a `Corrade` bot simply replace the `-n <bot name or alias>` command line argument
with `-c <bot name or alias>`.

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

Truth & Beauty Lab hosts repositories that provide a command line management
system for `LifeBots` and an in-world scripted object, `LifeBots Control Panel`,
that acts as a bridge between `LifeBots` management scripts and `LifeBots` bots.

Both `LifeBots` subscription plans provide a web UI and HUD that can be used for
interactive control of `LifeBots` bots and, for many users, this is sufficient.

For developers who wish to script `LifeBots` management, command, and control,
the `LifeBots Control Panel` provides and easy to use in-world interface to the
`LifeBots API`, enabling the automation of many of the rich `LifeBots` feature set.

For those power users who wish to automate their `LifeBots` using the command line
and tools such as `cron` and `jq` the `botctrl` command and associated utilities
found here may provide additional power and flexibility. The `BotControl` command line
management system is open source and free to download, deploy, modify, and distribute.

`LifeBots` managed by the `botctrl` command line and scheduled using the Unix
`cron` facility can be viewed and interacted with in Second Life at the
[Truth & Beauty Lab](http://maps.secondlife.com/secondlife/Brightbrook%20Isle/56/135/23)
or [Club Truth & Beauty](http://maps.secondlife.com/secondlife/Scylla/226/32/78).

## Table of Contents

- [BotControl Command Line](#botcontrol-command-line)
  - [Requirements](#requirements)
  - [Install botctrl](#install-botctrl)
  - [Configure Corrade for use with the botctrl command](#configure-corrade-for-use-with-the-botctrl-command)
  - [Configure botctrl](#configure-botctrl)
  - [Supported Bot Actions and Examples](#supported-bot-actions-and-examples)
  - [Usage and Source of botctrl command](#usage-and-source-of-botctrl-command)
  - [Scheduling Bot Actions](#scheduling-bot-actions)
  - [Using the JSON return as Input](#using-the-json-return-as-input)
  - [Botctrl Help](#botctrl-help)
- [LifeBots Control Panel](#lifebots-control-panel)

## BotControl Command Line

The `BotControl Command Line` is a suite of tools that enable control and management of
`Corrade` and `LifeBots` bots via the Unix/Linux command line. These tools are executed in
a terminal using the Bash shell and utilities such as `curl`, `sed`, `awk`, `jq`, and others.

The primary command line tool is the `botctrl` Bash script which acts as a front-end
for `Corrade` and `LifeBots` API requests.

### Requirements

The `botctrl` command line management system requires:

- Unix, Linux, Macos, or Windows Subsystem for Linux (WSL)
- Bash
- Cron
- curl
- git
- [jq](https://jqlang.org)

These requirements, with the exception of `jq`, are typically included in the base
operating system on all supported platforms. If your platform does not have `jq`
installed then you can still use `botctrl`, a few of the helper utilities will not
function properly but the bulk of the system will function without `jq`.

### Install botctrl

To install `botctrl`:

```bash
git clone https://github.com/missyrestless/Bots.git
cd Bots
./install-botctrl
```

Or, you can use the `curl` command to install `botctrl` with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/missyrestless/Bots/refs/heads/main/install-botctrl | bash
```

Alternatively, download the `install-botctrl` release artifact and
execute it. The `install-botctrl` script will clone the repository
and install the system:

```bash
wget -q https://github.com/missyrestless/Bots/releases/latest/download/install-botctrl
chmod 755 install-botctrl
./install-botctrl
```

### Configure Corrade for use with the botctrl command

Version 2 and later of the `botctrl` command supports command and control of both
`LifeBots` and `Corrade` bots.

In order to use the `botctrl` command to manage your `Corrade` bot(s):

- The HTTP server must be enabled in the `Corrade` configuration
- `ScriptLanguage` must be set to `JSON` in the `Corrade` configuration

Example snippet to enable the HTTP server in `CorradeConfiguration.xml`:

```xml
<Servers>
    <HTTPServer>
        <Enable>1</Enable>
        <Prefixes>
            <Prefix>http://+:8082/</Prefix>
        </Prefixes>
    </HTTPServer>
    ...
</Servers>
```

Set the port number in the `Prefix` configuration to an open unused port.
If you have more than one `Corrade` bot then use a different port for each.

To set the `ScriptLanguage` to JSON in `CorradeConfiguration.xml`:

```xml
  <ScriptLanguage>JSON</ScriptLanguage>
```

### Configure botctrl

The `botctrl` command is installed in `/usr/local/bin` along with some
utility scripts for use with `cron` or other management systems. These
utility scripts will need to be modified to suit your specific needs,
configuration and bot names. You can modify the scripts in
`BotControl/bin/` and re-run `./install-botctrl`.

Add `/usr/local/bin` to your execution `PATH` if it is not already included.

Configure `botctrl` by adding and editing the file `${HOME}/.botctrl`.

At a minimum, you must configure your `LifeBots` developer API key and bot
secrets for the `LifeBots` bots you wish to control using the `lifebot` command.

The following example entries in `$HOME/.botctrl` will allow you to control your
`LifeBots` bot named "Your Botname" using the `botctrl` command:

```bash
# Minimum contents of $HOME/.botctrl
#
# LifeBots Developer API Key
export LB_API_KEY='<your-lifebots-api-key>'
# LifeBots bot secret
export LB_SECRET_Your_Botname='<your-bot-secret>'
```

Add an entry of the form `export LB_SECRET_Firstname_Lastname='<bot-secret>'`
to `$HOME/.botctrl` for each of your `LifeBots` bots.

See `BotControl/example_dot_botctrl` for a template to use for this file.

See `BotControl/crontab.in` for example crontab entries to schedule bot activities.

See the section [Scheduling Bot Actions](#scheduling-bot-actions) below for more
details on scheduling bot actions.

### Supported Bot Actions and Examples

The `botctrl` command supports a significant subset of the full `LifeBots` API
and a substantial and growing subset of the extensive `Corrade` API.

#### Basic Commands

- `bot_location` : get precise bot location
- `key2name` : convert an avatar UUID to avatar name
- `login` : login bot
- `logout` : logout bot
- `name2key` : convert an avatar name to avatar UUID
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

#### BotControl Configuration

- `listalias` : list configured `botctrl` aliases in `$HOME/.botctrl`

**[NOTE:]** the examples below all assume you have configured `$HOME/.botctrl`
with your `LifeBots` API key and the bot secret:

```bash
# LifeBots Developer API Key
export LB_API_KEY='<redacted>'
# John Doebot LifeBots secret
export LB_SECRET_John_Doebot='<redacted>'
```

<details><summary>Click here to view the

**botctrl command examples**

</summary>

The following actions and commands, along with example command line invocations,
are supported by the `botctrl` command.

- `activate_group` : activate a group tag
  - `Example` : activate the specified group tag for bot `John Doebot`
  - `botctrl -a activate -n "John Doebot" -u "f8e95201-20af-b85f-a682-7ac25ab9fcaf"`
    - If `~/.botctrl` contains : `export UUID_pay2play="f8e95201-20af-b85f-a682-7ac25ab9fcaf"`
    - `botctrl -a activate -n "John Doebot" -u pay2play`
- `attachments` : list bot attachments, optionally specify a filter to match
  - `Example` : list bot named `John Doebot` attachments with name containing the string `HUD`
  - `botctrl -a attachments -F "HUD" -n "John Doebot"`
- `bot_location` : get precise bot location
  - `Example` : get location of bot named `John Doebot`
  - `botctrl -a location -n "John Doebot"`
- `get_balance` : get your bot's L$ balance
  - `Example` : get the L$ balance of bot `John Doebot`
  - `botctrl -a balance -n "John Doebot"`
- `get_outfit` : list currently worn bot outfit
  - `Example` : list currently worn outfit of bot named `John Doebot`
  - `botctrl -a get_outfit -n "John Doebot"`
- `get_outfits` : list available bot outfits
  - `Example` : list available outfits for bot named `John Doebot`
  - `botctrl -a get_outfits -n "John Doebot"`
- `give_money` : pay another avatar L$ from your bot
  - `Example` : pay avatar with specified UUID L$300 from bot `John Doebot`
  - `botctrl -a give_money -n "John Doebot" -u "3506213c-29c8-4aa1-a38f-e12f6d41b804" -z 300`
- `give_money_object` : pay an object L$ from your bot
  - `Example` : pay a tip jar with specified UUID L$100 from bot `John Doebot`
  - `botctrl -a give_money_object -n "John Doebot" -u "47cb1fc7-8144-b538-6716-c723fb1332d6" -z 100`
- `im` : send an instant message to an avatar
  - `Example` : send IM from `John Doebot` to avatar "Jane Free"
  - `botctrl -a im -n "John Doebot" -N "Jane Free" -M 'Hi Jane, do you want to meetup?'`
- `key2name` : convert an avatar UUID to avatar name
  - `Example` : use `John Doebot` bot to get avatar name of specified UUID
  - `botctrl -a key2name -n "John Doebot" -u "3506213c-29c8-4aa1-a38f-e12f6d41b804"`
- `listalias` : list configured `botctrl` aliases in `$HOME/.botctrl`
  - `Example` : list all configured `botctrl` aliases
  - `botctrl -a listalias`
  - `Example` : list configured `botctrl` bot aliases only
  - `botctrl -a botalias`
  - `Example` : list configured `botctrl` location aliases only
  - `botctrl -a slurlalias`
  - `Example` : list configured `botctrl` UUID aliases only
  - `botctrl -a uuidalias`
- `listinventory` : list bot inventory, optionally specify an inventory folder UUID
  - `Example` : list inventory of bot named `John Doebot`
  - `botctrl -a listinventory -n "John Doebot"`
- `login` : login bot
  - `Example` : login bot named `John Doebot`
  - `botctrl -a login -n "John Doebot"`
- `logout` : logout bot
  - `Example` : logout bot named `John Doebot`
  - `botctrl -a logout -n "John Doebot"`
- `name2key` : convert an avatar name to avatar UUID
  - `Example` : use `John Doebot` bot to get avatar UUID of Missy Restless
  - `botctrl -a name2key -n "John Doebot" -N "Missy Restless"`
- `reply_dialog` : reply to a dialog menu (requires channel, UUID, and button text)
  - `Example` : click couch menu button "Male" on channel 99999
  - `botctrl -a reply -n "John Doebot" -C 99999 -B Male -u "a811d6fe-de59-2f4e-ee19-0cc48da48981"`
- `say_chat_channel` : send a message to the specified chat channel
  - `Example` : send a message on channel 0, visible to everyone nearby
  - `botctrl -a say -n "John Doebot" -C 0 -M "Hi everyone, you look great"`
- `send_group_im` : send an instant message to a group
  - `Example` : send IM to a group from bot named `John Doebot`
  - `botctrl -a send_group_im -n "John Doebot" -u "f7d3c1b9-a141-9546-7e2d-dfd698c5df7c" -M "Meeting at Noon SLT tomorrow"`
- `send_notice` : send an official group notice to all group members
  - `Example` : send group notice with subject and message from bot named `John Doebot`
  - `botctrl -a send_notice -n "John Doebot" -u "f7d3c1b9-a141-9546-7e2d-dfd698c5df7c" -M "Meeting at Noon SLT tomorrow" -S "Meeting Tomorrow"`
- `set_hoverheight` : adjust bot hover height
  - `Example` : lower hover height of bot `John Doebot` by 0.05
  - `botctrl -a height -n "John Doebot" -z "-0.05"`
- `sit` : sit on a specified object UUID
  - `Example` : sit bot named `John Doebot` on an object
  - `botctrl -a sit -n "John Doebot" -u "d46e217b-fb5c-4796-bae3-ea016b280210"`
- `stand` :  make bot stand up
  - `Example` : make bot `John Doebot` stand up
  - `botctrl -a stand -n "John Doebot"`
- `status` : get bot status
  - `Example` : get status of bot `John Doebot` (status is default action)
  - `botctrl -n "John Doebot"`
- `takeoff` : remove a worn item
  - `Example` : bot `John Doebot` remove the specified inventory item
  - `botctrl -a takeoff -n "John Doebot" -u "d666e910-ba72-0c11-a66e-c3759d8af0f5"`
- `teleport` : teleport bot to specified location
  - `Example` : teleport bot `John Doebot` to the aliased location "club"
  - Requires an entry of the following form in `$HOME/.botctrl`
    - `export SLURL_club="http://maps.secondlife.com/secondlife/Scylla/226/32/78"`
  - `botctrl -a teleport -n "John Doebot" -l club`
- `touch_attachment` : touch a specified bot attachment
  - `Example` : bot `John Doebot` touch attachment named "HUD Controller"
  - `botctrl -a touch_attachment -n "John Doebot" -O "HUD Controller"`
- `touch_prim` : touch a specified object by UUID
  - `Example` : bot named `John Doebot` touch an object
  - `botctrl -a touch_prim -n "John Doebot" -u "f11781d0-763f-52f9-4e23-3a2b97759fa2"`
    - If `~/.botctrl` contains : `export UUID_spoton="f11781d0-763f-52f9-4e23-3a2b97759fa2"`
    - `botctrl -a touch_prim -n "John Doebot" -u spoton`
- `walkto` : walk bot to a location
  - `Example` : bot named `John Doebot` walk to X/Y/Z coordinates 100/50/28
  - `botctrl -a walkto -n "John Doebot" -l "100/50/28"`
- `wear` : wear an inventory item (uses "add" rather than "wear")
  - `Example` : bot `John Doebot` wear the specified inventory item
  - `botctrl -a wear -n "John Doebot" -u "d666e910-ba72-0c11-a66e-c3759d8af0f5"`
- `wear_outfit` : wear a specified outfit
  - `Example` : bot named `John Doebot` wear the outfit named "Business Casual"
  - `botctrl -a wear_outfit -n "John Doebot" -O "Business Casual"`
    - If `~/.botctrl` contains : `export LB_BOT_NAME='John Doebot'`
    - `botctrl -a wear_outfit -O "Business Casual"`

</details>

Development is in rapid progress for additional actions.

Let us know which `Corrade` or `LifeBots` API requests you would like supported.

### Usage and Source of botctrl command

<details><summary>Click here to view the

**botctrl command usage message**

</summary>

```
Usage: botctrl [-deih] [-a action] [-A avatar] [-l location] [-n name] [-k apikey] [-C channel]
  [-c corrade] [-F filter] [-M message] [-N name] [-O name] [-S subject] [-s secret] [-T text] [-u uuid] [-z num]
Where:
	-a action specifies the API action (sit, teleport, login, ...)
	-l location specifies a location for login and teleport actions
		Default: Last location, teleport action requires a Slurl location
	-n name specifies a Bot name, Default: Easy Islay
	-k apikey specifies an API Key, use environment instead
	-A avatar specifies an avatar UUID for use with giving money or objects
	-C channel specifies the channel for a message [default: 0]
	-c corrade specifies a Corrade bot name to act upon
	-F filter specifies a filter to match when listing attachments
	-M message specifies the message body for a group notice/im
	-N name specifies the name of the recipient of an IM or landmark/notecard
	-O name specifies an attachment object name or outfit name
	-S subject specifies the subject for a group notice
	-s secret specifies a Bot secret, use environment instead
	-T text specifies the notecard text or dialog button text for reply to menus
	-u uuid specifies a UUID for use with actions that require one (e.g. sit)
	-z num specifies a hover height adjustment size [default: -0.05]
		can also be used to specify a payment amount
	-d indicates dryrun mode - tell me what you would do without doing anything
	-e displays a list of supported commands and examples then exits
	-i retrieves Bot details
	-h displays this usage message and exits
Environment:
  Entries in ~/.botctrl can be LB_API_KEY, LB_SECRET, or entries
  of the form LB_SECRET_BOT_NAME in order to support multiple bots
  Entries can specify a Slurl alias. For example:
    export SLURL_club='http://maps.secondlife.com/secondlife/Scylla/226/32/78'
  A Slurl alias can be used with the -l command line argument, e.g. -l club
  Entries can also specify a UUID alias. For example:
    export UUID_Mover='xxxxxxxx-yyyy-zzzz-aaaa-bbbbbbbbbbbb'
  A UUID alias can be used with the -u command line argument, e.g. -u Mover
Examples:
  botctrl  # Displays the status of the default Bot
  botctrl -a login -l Home # Default Bot login to Home location
  botctrl -a touch_prim -n 'Jane Doe' -u Mover # Jane Doe bot touch object with aliased UUID
  botctrl -a stand -n Jane -c John # Jane bot sends the stand command to Corrade bot John
  botctrl -a teleport -l club  # Uses a 'club' location alias defined in .botctrl
Supported Actions
Supported LifeBots actions:
  login, logout, status, bot_location, walkto, sit, stand, teleport, listalias, key2name, notecard_create,
  avatar_picks, name2key, listinventory, im, reply_dialog, send_notice, send_group_im, attachments,
  rebake, touch_attachment, touch_prim, activate_group, wear, takeoff, say_chat_channel, set_hoverheight,
  get_outfit, get_outfits, wear_outfit, get_balance, give_inventory, give_money, give_money_object
Supported Corrade actions:
  attach, batchavatarkeytoname, batchavatarnametokey, changeappearance, createlandmark,
  createnotecard, detach, fly, flyto, getattachments, getattachmentspath, getmembersonline,
  inventory cwd, inventory list current outfit, inventory list outfits, pay avatar,
  pay object, sit, stand, teleport, touch, unwear, walkto, wear
```

</details>

<details><summary>Click here to view the

**botctrl source code**

</summary>

```bash
#!/usr/bin/env bash
#
# botctrl - control LifeBot or Corrade bots from the command line
#
# Copyright (c) 2025-2026 Truth & Beauty Lab
#
# Author:  Missy Restless <missyrestless@gmail.com>
# Created: 15-Nov-2025
# License: MIT
#
# TODO: get bot details not working yet, need to generate an access token
#
# ----------------- $HOME/.botctrl Format ----------------------
# Entries in ~/.botctrl can be LB_API_KEY, LB_SECRET, or entries
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
# Command line arguments can be used to override the settings in .botctrl
# NOTE: command line arguments are stored in the shell history
#       environment variables are preferable over command line arguments
#
# Set the default Bot name
# Setting in .botctrl overrides, setting on command line with -n name overrides all
LB_BOT_NAME="Anya Ordinary"
# Set the default action, can be specified with -a action
ACTION="status"
# LifeBots API endpoint
APIURL="https://api.botctrl.cloud/api"
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

SCRIPT_FULL_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_NAME="$(basename "$SCRIPT_FULL_PATH")"

usage() {
  [ "${nobold}" ] && {
    BOLD=
    LINE=
    NORM=
  }
  printf "\n${BOLD}${LINE}Usage:${NORM} ${BOLD}${SCRIPT_NAME} [-deih] [-a action] [-A avatar] [-l location] [-n name] [-k apikey] [-C channel]"
  printf "\n  [-c corrade] [-F filter] [-M message] [-N name] [-O name] [-S subject] [-s secret] [-T text] [-u uuid] [-z num]${NORM}"
  [ "$1" == "brief" ] && {
    printf "\n\n"
    exit 1
  }
  printf "\n${BOLD}${LINE}Where:${NORM}"
  printf "\n\t${BOLD}${LINE}-a action${NORM} specifies the API action (sit, teleport, login, ...)"
  printf "\n\t${BOLD}${LINE}-l location${NORM} specifies a location for login and teleport actions"
  printf "\n\t\tDefault: Last location, teleport action requires a Slurl location"
  printf "\n\t${BOLD}${LINE}-n name${NORM} specifies a Bot name, Default: Easy Islay"
  printf "\n\t${BOLD}${LINE}-k apikey${NORM} specifies an API Key, use environment instead"
  printf "\n\t${BOLD}${LINE}-A avatar${NORM} specifies an avatar UUID for use with giving money or objects"
  printf "\n\t${BOLD}${LINE}-C channel${NORM} specifies the channel for a message [default: 0]"
  printf "\n\t${BOLD}${LINE}-c corrade${NORM} specifies a Corrade bot name to act upon"
  printf "\n\t${BOLD}${LINE}-F filter${NORM} specifies a filter to match when listing attachments"
  printf "\n\t${BOLD}${LINE}-M message${NORM} specifies the message body for a group notice/im"
  printf "\n\t${BOLD}${LINE}-N name${NORM} specifies the name of the recipient of an IM or landmark/notecard"
  printf "\n\t${BOLD}${LINE}-O name${NORM} specifies an attachment object name or outfit name"
  printf "\n\t${BOLD}${LINE}-S subject${NORM} specifies the subject for a group notice"
  printf "\n\t${BOLD}${LINE}-s secret${NORM} specifies a Bot secret, use environment instead"
  printf "\n\t${BOLD}${LINE}-T text${NORM} specifies the notecard text or dialog button text for reply to menus"
  printf "\n\t${BOLD}${LINE}-u uuid${NORM} specifies a UUID for use with actions that require one (e.g. sit)"
  printf "\n\t${BOLD}${LINE}-z num${NORM} specifies a hover height adjustment size [default: -0.05]"
  printf "\n\t\tcan also be used to specify a payment amount"
  printf "\n\t${BOLD}${LINE}-d${NORM} indicates dryrun mode - tell me what you would do without doing anything"
  printf "\n\t${BOLD}${LINE}-e${NORM} displays a list of supported commands and examples then exits"
  printf "\n\t${BOLD}${LINE}-i${NORM} retrieves Bot details"
  printf "\n\t${BOLD}${LINE}-h${NORM} displays this usage message and exits"
  printf "\n${BOLD}${LINE}Environment:${NORM}"
  printf "\n  Entries in ~/.botctrl can be LB_API_KEY, LB_SECRET, or entries"
  printf "\n  of the form LB_SECRET_BOT_NAME in order to support multiple bots"
  printf "\n  Entries can specify a Slurl alias. For example:"
  printf "\n    export SLURL_club='http://maps.secondlife.com/secondlife/Scylla/226/32/78'"
  printf "\n  A Slurl alias can be used with the -l command line argument, e.g. -l club"
  printf "\n  Entries can also specify a UUID alias. For example:"
  printf "\n    export UUID_Mover='xxxxxxxx-yyyy-zzzz-aaaa-bbbbbbbbbbbb'"
  printf "\n  A UUID alias can be used with the -u command line argument, e.g. -u Mover"
  printf "\n${BOLD}${LINE}Examples:${NORM}"
  printf "\n  ${SCRIPT_NAME}  # Displays the status of the default Bot"
  printf "\n  ${SCRIPT_NAME} -a login -l Home # Default Bot login to Home location"
  printf "\n  ${SCRIPT_NAME} -a touch_prim -n 'Jane Doe' -u Mover # Jane Doe bot touch object with aliased UUID"
  printf "\n  ${SCRIPT_NAME} -a stand -n Jane -c John # Jane bot sends the stand command to Corrade bot John"
  printf "\n  ${SCRIPT_NAME} -a teleport -l club  # Uses a 'club' location alias defined in .botctrl"
  printf "\n${BOLD}${LINE}Supported Actions${NORM}"
  list_supported_actions
  exit 1
}

examples() {
  printf "\nThe following actions and commands, along with example command"
  printf "\nline invocations, are supported by the ${SCRIPT_NAME} command.\n"

  printf "\nactivate_group : activate a group tag"
  printf "\n\tExample : activate the specified group tag for bot John Doebot"
  printf "\n\t${SCRIPT_NAME} -a activate -n \"John Doebot\" -u \"f8e95201-20af-b85f-a682-7ac25ab9fcaf\""
  printf "\n\t\tIf ~/.botctrl contains : export UUID_pay2play=\"f8e95201-20af-b85f-a682-7ac25ab9fcaf\""
  printf "\n\t\t${SCRIPT_NAME} -a activate -n \"John Doebot\" -u pay2play"
  printf "\nattachments : list bot attachments, optionally specify a filter to match"
  printf "\n\tExample : list bot named John Doebot attachments with name containing the string HUD"
  printf "\n\t${SCRIPT_NAME} -a attachments -F \"HUD\" -n \"John Doebot\""
  printf "\nbot_location : get precise bot location"
  printf "\n\tExample : get location of bot named John Doebot"
  printf "\n\t${SCRIPT_NAME} -a location -n \"John Doebot\""
  printf "\nget_balance : get your bot's L$ balance"
  printf "\n\tExample : get the L$ balance of bot John Doebot"
  printf "\n\t${SCRIPT_NAME} -a balance -n \"John Doebot\""
  printf "\nget_outfit : list currently worn bot outfit"
  printf "\n\tExample : list currently worn outfit of bot named John Doebot"
  printf "\n\t${SCRIPT_NAME} -a get_outfit -n \"John Doebot\""
  printf "\nget_outfits : list available bot outfits"
  printf "\n\tExample : list available outfits for bot named John Doebot"
  printf "\n\t${SCRIPT_NAME} -a get_outfits -n \"John Doebot\""
  printf "\ngive_money : pay another avatar L$ from your bot"
  printf "\n\tExample : pay avatar with specified avatar UUID L$300 from bot John Doebot"
  printf "\n\t${SCRIPT_NAME} -a give_money -n \"John Doebot\" -A \"3506213c-29c8-4aa1-a38f-e12f6d41b804\" -z 300"
  printf "\ngive_money_object : pay an object L$ from your bot"
  printf "\n\tExample : pay a tip jar with specified UUID L$100 from bot John Doebot"
  printf "\n\t${SCRIPT_NAME} -a give_money_object -n \"John Doebot\" -u \"47cb1fc7-8144-b538-6716-c723fb1332d6\" -z 100"
  printf "\nim : send an instant message to an avatar"
  printf "\n\tExample : send IM from John Doebot to avatar \"Jane Free\""
  printf "\n\t${SCRIPT_NAME} -a im -n \"John Doebot\" -N \"Jane Free\" -M 'Hi Jane, do you want to meetup?'"
  printf "\nkey2name : convert an avatar UUID to avatar name"
  printf "\n\tExample : use John Doebot bot to get avatar name of specified UUID"
  printf "\n\t${SCRIPT_NAME} -a key2name -n \"John Doebot\" -u \"3506213c-29c8-4aa1-a38f-e12f6d41b804\""
  printf "\nlistalias : list configured ${SCRIPT_NAME} aliases in $HOME/.botctrl"
  printf "\n\tExample : list all configured ${SCRIPT_NAME} aliases"
  printf "\n\t${SCRIPT_NAME} -a listalias"
  printf "\n\tExample : list configured ${SCRIPT_NAME} bot aliases only"
  printf "\n\t${SCRIPT_NAME} -a botalias"
  printf "\n\tExample : list configured ${SCRIPT_NAME} location aliases only"
  printf "\n\t${SCRIPT_NAME} -a slurlalias"
  printf "\n\tExample : list configured ${SCRIPT_NAME} UUID aliases only"
  printf "\n\t${SCRIPT_NAME} -a uuidalias"
  printf "\nlistinventory : list bot inventory, optionally specify an inventory folder UUID"
  printf "\n\tExample : list inventory of bot named John Doebot"
  printf "\n\t${SCRIPT_NAME} -a listinventory -n \"John Doebot\""
  printf "\nlogin : login bot"
  printf "\n\tExample : login bot named John Doebot"
  printf "\n\t${SCRIPT_NAME} -a login -n \"John Doebot\""
  printf "\nlogout : logout bot"
  printf "\n\tExample : logout bot named John Doebot"
  printf "\n\t${SCRIPT_NAME} -a logout -n \"John Doebot\""
  printf "\nname2key : convert an avatar name to avatar UUID"
  printf "\n\tExample : use John Doebot bot to get avatar UUID of Missy Restless"
  printf "\n\t${SCRIPT_NAME} -a name2key -n \"John Doebot\" -N \"Missy Restless\""
  printf "\nreply_dialog : reply to a dialog menu (requires channel, UUID, and button text)"
  printf "\n\tExample : click couch menu button \"Male\" on channel 99999"
  printf "\n\t${SCRIPT_NAME} -a reply -n \"John Doebot\" -C 99999 -B Male -u \"a811d6fe-de59-2f4e-ee19-0cc48da48981\""
  printf "\nsay_chat_channel : send a message to the specified chat channel"
  printf "\n\tExample : send a message on channel 0, visible to everyone nearby"
  printf "\n\t${SCRIPT_NAME} -a say -n \"John Doebot\" -C 0 -M \"Hi everyone, you look great\""
  printf "\nsend_group_im : send an instant message to a group"
  printf "\n\tExample : send IM to a group from bot named John Doebot"
  printf "\n\t${SCRIPT_NAME} -a send_group_im -n \"John Doebot\" -u \"f7d3c1b9-a141-9546-7e2d-dfd698c5df7c\" -M \"Meeting at Noon SLT tomorrow\""
  printf "\nsend_notice : send an official group notice to all group members"
  printf "\n\tExample : send group notice with subject and message from bot named John Doebot"
  printf "\n\t${SCRIPT_NAME} -a send_notice -n \"John Doebot\" -u \"f7d3c1b9-a141-9546-7e2d-dfd698c5df7c\" -M \"Meeting at Noon SLT tomorrow\" -S \"Meeting Tomorrow\""
  printf "\nset_hoverheight : adjust bot hover height"
  printf "\n\tExample : lower hover height of bot John Doebot by 0.05"
  printf "\n\t${SCRIPT_NAME} -a height -n \"John Doebot\" -z \"-0.05\""
  printf "\nsit : sit on a specified object UUID"
  printf "\n\tExample : sit bot named John Doebot on an object"
  printf "\n\t${SCRIPT_NAME} -a sit -n \"John Doebot\" -u \"d46e217b-fb5c-4796-bae3-ea016b280210\""
  printf "\nstand : make a bot stand up"
  printf "\n\tExample : make bot John Doebot stand up"
  printf "\n\t${SCRIPT_NAME} -a stand -n \"John Doebot\""
  printf "\nstatus : get bot status"
  printf "\n\tExample : get status of bot John Doebot (status is default action)"
  printf "\n\t${SCRIPT_NAME} -n \"John Doebot\""
  printf "\ntakeoff : remove a worn item"
  printf "\n\tExample : bot John Doebot remove the specified inventory item"
  printf "\n\t${SCRIPT_NAME} -a takeoff -n \"John Doebot\" -u \"d666e910-ba72-0c11-a66e-c3759d8af0f5\""
  printf "\nteleport : teleport bot to specified location"
  printf "\n\tExample : teleport bot John Doebot to the aliased location \"club\""
  printf "\n\tRequires an entry of the following form in $HOME/.botctrl"
  printf "\n\t\texport SLURL_club=\"http://maps.secondlife.com/secondlife/Scylla/226/32/78\""
  printf "\n\t${SCRIPT_NAME} -a teleport -n \"John Doebot\" -l club"
  printf "\ntouch_attachment : touch a specified bot attachment"
  printf "\n\tExample : bot John Doebot touch attachment named \"HUD Controller\""
  printf "\n\t${SCRIPT_NAME} -a touch_attachment -n \"John Doebot\" -O \"HUD Controller\""
  printf "\ntouch_prim : touch a specified object by UUID"
  printf "\n\tExample : bot named John Doebot touch an object"
  printf "\n\t${SCRIPT_NAME} -a touch_prim -n \"John Doebot\" -u \"f11781d0-763f-52f9-4e23-3a2b97759fa2\""
  printf "\n\t\tIf ~/.botctrl contains : export UUID_spoton=\"f11781d0-763f-52f9-4e23-3a2b97759fa2\""
  printf "\n\t\t${SCRIPT_NAME} -a touch_prim -n \"John Doebot\" -u spoton"
  printf "\nwalkto : walk bot to a location"
  printf "\n\tExample : bot named John Doebot walk to X/Y/Z coordinates 100/50/28"
  printf "\n\t${SCRIPT_NAME} -a walkto -n \"John Doebot\" -l \"100/50/28\""
  printf "\nwear : wear an inventory item (uses \"add\" rather than \"wear\")"
  printf "\n\tExample : bot John Doebot wear the specified inventory item"
  printf "\n\t${SCRIPT_NAME} -a wear -n \"John Doebot\" -u \"d666e910-ba72-0c11-a66e-c3759d8af0f5\""
  printf "\nwear_outfit : wear a specified outfit"
  printf "\n\tExample : bot named John Doebot wear the outfit named \"Business Casual\""
  printf "\n\t${SCRIPT_NAME} -a wear_outfit -n \"John Doebot\" -O \"Business Casual\""
  printf "\n\t\tIf ~/.botctrl contains : export LB_BOT_NAME='John Doebot'"
  printf "\n\t\t${SCRIPT_NAME} -a wear_outfit -O \"Business Casual\"\n"
  exit 1
}

is_valid_uuid() {
  local uuid="$1"
  if [[ $uuid =~ ^\{?[A-F0-9a-f]{8}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{12}\}?$ ]]; then
    return 0 # Valid
  else
    return 1 # Invalid
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
    echo "No Bot ID set in .botctrl"
    usage
  }
  if [ "${dryrun}" ]; then
    echo "curl ${verb} GET ${APIURL}/v1/bots/${LB_BOT_ID} \
      -H \"Authorization: Bearer ${access_token}\" \
      -H \"Accept: application/json\" \
      -H \"Content-Type: application/json\""
  else
    curl ${verb} GET ${APIURL}/v1/bots/${LB_BOT_ID} \
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
    printf "\nNo ${astr} aliases defined in ${HOME}/.botctrl"
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

list_supported_actions() {
  printf "\nSupported LifeBots actions:"
  printf "\n  login, logout, status, bot_location, walkto, sit, stand, teleport, listalias, key2name, notecard_create,"
  printf "\n  avatar_picks, name2key, listinventory, im, reply_dialog, send_notice, send_group_im, attachments,"
  printf "\n  rebake, touch_attachment, touch_prim, activate_group, wear, takeoff, say_chat_channel, set_hoverheight,"
  printf "\n  get_outfit, get_outfits, wear_outfit, get_balance, give_inventory, give_money, give_money_object"
  printf "\nSupported Corrade actions:"
  printf "\n  attach, batchavatarkeytoname, batchavatarnametokey, changeappearance, createlandmark,"
  printf "\n  createnotecard, detach, fly, flyto, getattachments, getattachmentspath, getmembersonline,"
  printf "\n  inventory cwd, inventory list current outfit, inventory list outfits, pay avatar,"
  printf "\n  pay object, sit, stand, teleport, touch, unwear, walkto, wear\n"
}

get_coords() {
  local loc="$1"
  # Convert position coordinates from x/y/z to x,y,z
  echo "${loc}" | grep / >/dev/null && {
    loc=$(echo "${loc}" | awk -F '/' -v OFS=',' '{ print $(NF-2), $(NF-1), $NF }')
  }
  loc=$(echo "${loc}" | awk -F ',' -v OFS=',' '{ print $(NF-2), $(NF-1), $NF }')
  echo "${loc}"
}

set_lb_coords() {
  local loc="$1"
  # Convert position coordinates to x/y/z
  echo "${loc}" | grep , >/dev/null && {
    loc=$(echo "${loc}" | awk -F ',' -v OFS='/' '{ print $(NF-2), $(NF-1), $NF }')
  }
  echo "${loc}"
}

wasURLEscape() {
  printf %s "$1" | sed -e "s/ /+/g" \
                  -e "s%/%\%2F%g" \
                  -e "s/&/%26/g" \
                  -e "s/%/%25/g" \
                  -e "s/=/%3D/g" \
                  -e "s/|/%7C/g" \
                  -e "s/\n/%0D%0A/g"
}

fixup_Outfits_JSON() {
  # I know, it's ugly, but the JSON return output was uglier
  local type_outfit="$1"
  if [ "${type_outfit}" == "current" ]; then
    printf '\n{\n  "action": "get_outfit",\n  "outfits": [\n'
  else
    printf '\n{\n  "action": "get_outfits",\n  "outfits": [\n'
  fi

  local name=
  local uuid=
  local line
  while IFS= read -r line; do
    if [ "${line}" == "name" ]; then
      printf '    {\n      "name": '
      name=1
    else
      if [ "${line}" == "item" ]; then
        printf '      "uuid": '
        uuid=1
      else
        [ "${name}" ] && {
          printf "\"${line}\",\n"
          name=
        }
        [ "${uuid}" ] && {
          printf "\"${line}\"\n    },\n"
          uuid=
        }
      fi
    fi
  done

  printf '    {\n'
  printf '      "name": "BotControlCommandDummyPlaceholder",\n'
  printf '      "uuid": "foo-bar-spam"\n'
  printf '    }\n'
  printf '  ]\n'
  printf '}\n'
}

send_corrade_request() {
  local cmd="$1"
  # If the Corrade configuration specifies WAS ScriptLanguage:
  # cgroup=$(wasURLEscape "${CORRADE_GROUP}")
  # cpassw=$(wasURLEscape "${CORRADE_PASSW}")
  # If the Corrade configuration specifies JSON ScriptLanguage:
  local cgroup="${CORRADE_GROUP}"
  local cpassw="${CORRADE_PASSW}"
  local cuuid=
  [ "${cmd}" ] || {
    echo "Empty command. Exiting."
    usage
  }
  COMMON="\"group\": \"${cgroup}\", \"password\": \"${cpassw}\""
  case "${cmd}" in
    attach|detach)
      [ "${UUID}" ] || {
        echo "The ${cmd} action requires an inventory item UUID specified with -u UUID"
        usage brief
      }
      if [ "${cmd}" == "attach" ]; then
        COMMAND="\"command\": \"attach\", \"attachments\": \"Default\", \"${UUID}\""
      else
        COMMAND="\"command\": \"detach\", \"type\": \"UUID\", \"attachments\": \"${UUID}\""
      fi
      ;;
    creat*landmark|creat*lm)
      [ "${SL_NAME}" ] || {
        echo "The ${cmd} action requires a Landmark Name specified with -N name"
        usage brief
      }
      COMMAND="\"command\": \"createlandmark\", \"name\": \"${SL_NAME}\""
      ;;
    creat*notecard|creat*nc|note*creat*|nc*creat*)
      COMMAND="\"command\": \"createnotecard\", \"entity\": \"text\", \"name\": \"${SL_NAME}\", \"text\": \"${TEXT}\""
      ;;
    fly|nofly)
      local action="start"
      [ "${cmd}" == "nofly" ] && action="stop"
      COMMAND="\"command\": \"fly\", \"action\": \"${action}\""
      ;;
    flyto|fly_to)
      local POS=$(get_coords "${LOCATION}")
      local position="<${POS}>"
      COMMAND="\"command\": \"flyto\", \"fly\": \"False\", \"position\": \"${position} + <0,0,5>\""
      ;;
    *attachments*)
      local comm="getattachments"
      echo "${cmd}" | grep attachmentspath >/dev/null && comm="getattachmentspath"
      COMMAND="\"command\": \"${comm}\""
      ;;
    get_balance|getbalance|balance)
      COMMAND="\"command\": \"getbalance\""
      ;;
    getcwd|cwd)
      COMMAND="\"command\": \"inventory\", \"action\": \"cwd\""
      ;;
    get_outfit*)
      local path="/My Inventory/Current Outfit"
      echo "${cmd}" | grep get_outfits >/dev/null && path="/My Inventory/My Outfits"
      COMMAND="\"command\": \"inventory\", \"path\": \"${path}\", \"follow\": \"True\", \"action\": \"ls\""
      ;;
    key2name)
      COMMAND="\"command\": \"batchavatarkeytoname\", \"avatars\": \"${UUID}\""
      ;;
    listinventory)
      COMMAND="\"command\": \"inventory\", \"action\": \"ls\""
      ;;
    name2key)
      COMMAND="\"command\": \"batchavatarnametokey\", \"avatars\": \"${SL_NAME}\""
      ;;
    pay|pay_avatar|give_money)
      COMMAND="\"command\": \"pay\", \"entity\": \"avatar\", \"agent\": \"${AVATAR_UUID}\", \"amount\": \"${AMOUNT}\""
      ;;
    pay_object|give_money_object)
      COMMAND="\"command\": \"pay\", \"entity\": \"object\", \"target\": \"${OBJECT_UUID}\", \"amount\": \"${AMOUNT}\""
      ;;
    sit|touch*)
      if [ "${UUID}" ]; then
        # cuuid=$(wasURLEscape "${UUID}")
        cuuid="${UUID}"
      else
        if [ "${OBJ_NAME}" ]; then
          # cuuid=$(wasURLEscape "${OBJ_NAME}")
          cuuid="${OBJ_NAME}"
        else
          echo "Corrade command ${cmd} requires object uuid or name"
          usage brief
        fi
      fi
      [ "${cmd}" == "sit" ] || cmd="touch"
      COMMAND="\"command\": \"${cmd}\", \"item\": \"${cuuid}\", \"range\": \"${CORRADE_RANGE}\""
      ;;
    stand)
      COMMAND="\"command\": \"stand\", \"deanimate\": \"True\""
      ;;
    getmembersonline|status)
      COMMAND="\"command\": \"getmembersonline\""
      ;;
    teleport)
      local POS=$(get_coords "${LOCATION}")
      local pos="<${POS}>"
      local rgn=$(echo "${LOCATION}" | awk -F '/' '{ print $(NF-3) }' | sed -e "s/%20/ /g")
      COMMAND="\"command\": \"teleport\", \"entity\": \"region\", \"region\": \"${rgn}\", \"position\": \"${pos}\""
      ;;
    unwear|remove|takeoff)
      COMMAND="\"command\": \"unwear\", \"type\": \"UUID\", \"wearables\": \"${UUID}\""
      ;;
    walk*)
      local POS=$(get_coords "${LOCATION}")
      local position="<${POS}>"
      COMMAND="\"command\": \"walkto\", \"position\": \"${position}\""
      ;;
    wear)
      COMMAND="\"command\": \"wear\", \"replace\": \"False\", \"wearables\": \"${WEARABLE}\""
      ;;
    change*|wear*)
      local outfit_folder="/My Inventory/My Outfits/${OUTFIT_NAME}"
      COMMAND="\"command\": \"changeappearance\", \"folder\": \"${outfit_folder}\""
      ;;
    *)
      COMMAND=
      ;;
  esac
  [ "${COMMAND}" ] || {
    echo "Corrade command ${cmd} not yet supported"
    list_supported_actions
    usage brief
  }
  [ "${CORRADE_BOT_URL}" ] || {
    echo "Corrade bot URL not set!"
    usage brief
  }
  if [ "${dryrun}" ]; then
    echo "curl ${verb} -X POST ${CORRADE_BOT_URL} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
            ${COMMON},
            ${COMMAND}
          }\""
  else
    if [ "${have_jq}" ]; then
      case "${cmd}" in
        get_outfit*)
          local outfit_type="current"
          echo "${cmd}" | grep get_outfits >/dev/null && outfit_type="outfits"
          curl ${verb} -X POST ${CORRADE_BOT_URL} \
               -H "Accept: application/json" \
               -H "Content-Type: application/json" \
               -d "{
                 ${COMMON},
                 ${COMMAND}
               }" | jq -r '.data[]' | fixup_Outfits_JSON "${outfit_type}" | \
                    jq 'del(.outfits[] | select(.name == "BotControlCommandDummyPlaceholder"))'
          ;;
        *)
          curl ${verb} -X POST ${CORRADE_BOT_URL} \
               -H "Accept: application/json" \
               -H "Content-Type: application/json" \
               -d "{
                 ${COMMON},
                 ${COMMAND}
               }" | jq -r .
          ;;
      esac
    else
      curl ${verb} -X POST ${CORRADE_BOT_URL} \
           -H "Accept: application/json" \
           -H "Content-Type: application/json" \
           -d "{
             ${COMMON},
             ${COMMAND}
           }"
    fi
  fi
}

send_lifebot_request() {
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
          echo "curl ${verb} -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            ${COMMON},
            \"objectname\": \"${OBJ_NAME}\",
            \"uuid\": \"${UUID}\",
            \"extended\": true
          }\""
        else
          echo "curl ${verb} -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            ${COMMON},
            \"objectname\": \"${OBJ_NAME}\"
          }\""
        fi
      else
        if [ "${UUID}" ]; then
          curl ${verb} -X POST ${ENDPOINT} \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
            ${COMMON},
            \"objectname\": \"${OBJ_NAME}\",
            \"uuid\": \"${UUID}\",
            \"extended\": true
          }"
        else
          curl ${verb} -X POST ${ENDPOINT} \
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
          echo "curl ${verb} -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            ${COMMON},
            \"siton\": \"${LOGIN_SITON}\",
            \"location\": \"${LOCATION}\"
          }\""
        else
          curl ${verb} -X POST ${ENDPOINT} \
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
          echo "curl ${verb} -X POST ${ENDPOINT} \
            -H \"Accept: application/json\" \
            -H \"Content-Type: application/json\" \
            -d \"{
            ${COMMON},
            \"location\": \"${LOCATION}\"
          }\""
        else
          curl ${verb} -X POST ${ENDPOINT} \
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
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"key\": \"${UUID}\",
          \"request_case\": \"1\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"key\": \"${UUID}\",
          \"request_case\": \"1\"
        }"
      fi
      ;;
    name2key)
      if [ "${dryrun}" ]; then
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"name\": \"${SL_NAME}\",
          \"request_case\": \"1\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"name\": \"${SL_NAME}\",
          \"request_case\": \"1\"
        }"
      fi
      ;;
    avatar_picks)
      if [ "${dryrun}" ]; then
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"avatar\": \"${AVATAR_UUID}\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"avatar\": \"${AVATAR_UUID}\"
        }"
      fi
      ;;
    give_inventory)
      if [ "${dryrun}" ]; then
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"avatar\": \"${AVATAR_UUID}\",
          \"object\": \"${UUID}\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"avatar\": \"${AVATAR_UUID}\",
          \"object\": \"${UUID}\"
        }"
      fi
      ;;
    give_money|give_money_object)
      if [ "${dryrun}" ]; then
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"avatar\": \"${AVATAR_UUID}\",
          \"object_uuid\": \"${OBJECT_UUID}\",
          \"amount\": ${AMOUNT}
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
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
    notecard_create)
      if [ "${dryrun}" ]; then
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"name\": \"${SL_NAME}\",
          \"text\": \"${TEXT}\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"name\": \"${SL_NAME}\",
          \"text\": \"${TEXT}\"
        }"
      fi
      ;;
    reply_dialog)
      if [ "${dryrun}" ]; then
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"button\": \"${TEXT}\",
          \"channel\": \"${CHANNEL}\",
          \"object\": \"${UUID}\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"button\": \"${TEXT}\",
          \"channel\": \"${CHANNEL}\",
          \"object\": \"${UUID}\"
        }"
      fi
      ;;
    activate_group|im|say_chat_channel|send_group_im|send_notice)
      msg_label="message"
      [ "${act}" == "send_notice" ] && msg_label="text"
      if [ "${dryrun}" ]; then
        echo "curl ${verb} -X POST ${ENDPOINT} \
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
        curl ${verb} -X POST ${ENDPOINT} \
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
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"height\": \"${HEIGHT}\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
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
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"uuid\": \"${UUID}\",
          \"wear\": \"add\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
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
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"outfitname\": \"${OUTFIT_NAME}\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON},
          \"outfitname\": \"${OUTFIT_NAME}\"
        }"
      fi
      ;;
    walkto)
      # LifeBots walkto API seems to require x/y/z even though x,y,z is documented
      LOCATION=$(set_lb_coords "${LOCATION}")
      if [ "${dryrun}" ]; then
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"coords\": \"${LOCATION}\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
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
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON},
          \"matchnames\": \"${FILTER}\"
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
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
        echo "curl ${verb} -X POST ${ENDPOINT} \
          -H \"Accept: application/json\" \
          -H \"Content-Type: application/json\" \
          -d \"{
          ${COMMON}
        }\""
      else
        curl ${verb} -X POST ${ENDPOINT} \
          -H "Accept: application/json" \
          -H "Content-Type: application/json" \
          -d "{
          ${COMMON}
        }"
      fi
      ;;
  esac
}

send_request() {
  if [ "$1" == "-l" ]; then
    shift
    send_lifebot_request "$@"
  else
    if [ "${corrade}" ]; then
      send_corrade_request "$@"
    else
      send_lifebot_request "$@"
    fi
  fi
}

ACTION_STR= AMOUNT= AVATAR_UUID= BOT_NAME= FILTER= GROUP_ID=
LOGIN_SITON= MESSAGE= OBJ_NAME= OUTFIT_NAME= SL_NAME= SUBJECT= TEXT=
CORRADE_BOT_ID= CORRADE_BOT_NAME= CORRADE_BOT_URL= UUID= WEARABLE=

[ -f ${HOME}/.botctrl ] && source ${HOME}/.botctrl

# Use jq to format JSON return if it is available
have_jq=$(type -p jq)

command_line_secret= details= dryrun= nobold= corrade= verb="-s"
while getopts ":a:A:c:C:dijF:l:M:N:n:O:k:S:s:T:u:vz:Heh" flag; do
  case $flag in
    a)
      ACTION_STR="${OPTARG}"
      ;;
    A)
      AVATAR_UUID="${OPTARG}"
      ;;
    C)
      CHANNEL="${OPTARG}"
      ;;
    c)
      CORRADE_BOT_NAME="${OPTARG}"
      # have_jq=
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
    T)
      TEXT="${OPTARG}"
      ;;
    u)
      UUID="${OPTARG}"
      ;;
    v)
      verb=
      ;;
    z)
      HEIGHT="${OPTARG}"
      AMOUNT="${OPTARG}"
      INVUUID="${OPTARG}"
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

# Check for Name alias in ~/.botctrl
[ "${BOT_NAME}" ] && {
  botname=$(echo "${BOT_NAME}" | sed -e "s/ /_/g")
  envname="BOT_NAME_${botname}"
  [ "${!envname}" ] && LB_BOT_NAME="${!envname}"
}

# Setup Corrade variables if Corrade bot was specified with -c bot
[ "${CORRADE_BOT_NAME}" ] && {
  botname=$(echo "${CORRADE_BOT_NAME}" | sed -e "s/ /_/g")
  envname="BOT_NAME_${botname}"
  [ "${!envname}" ] && botname="${!envname}"
  corrade=$(echo "${botname}" | sed -e "s/ /_/g")
  envid="BOT_ID_${corrade}"
  envurl="API_URL_${corrade}"
  [ "${!envurl}" ] && CORRADE_BOT_URL="${!envurl}"
  [ "${!envid}" ] && CORRADE_BOT_ID="${!envid}"
}

# Check for a bot specific secret
[ "${command_line_secret}" ] || {
  botname=$(echo "${LB_BOT_NAME}" | sed -e "s/ /_/g")
  envsecret="LB_SECRET_${botname}"
  [ "${!envsecret}" ] && LB_SECRET="${!envsecret}"
}

# Check for Bot ID alias in ~/.botctrl
[ "${LB_BOT_ID}" ] && {
  botid=$(echo "${LB_BOT_ID}" | sed -e "s/ /_/g")
  envid="LB_BOT_ID_${botid}"
  [ "${!envid}" ] && LB_BOT_ID="${!envid}"
}

# Check for location alias in ~/.botctrl
[ "${LOCATION}" ] && {
  echo "${LOCATION}" | grep maps.secondlife.com/secondlife >/dev/null || {
    botloc=$(echo "${LOCATION}" | sed -e "s/ /_/g")
    envloc="SLURL_${botloc}"
    [ "${!envloc}" ] && LOCATION="${!envloc}"
  }
}

# Check for avatar UUID alias in ~/.botctrl
[ "${AVATAR_UUID}" ] && {
  # Check if UUID is a valid Second Life avatar UUID, if not then check for alias
  is_valid_uuid "${AVATAR_UUID}" || {
    botuuid=$(echo "${AVATAR_UUID}" | sed -e "s/ /_/g")
    envuuid="UUID_${botuuid}"
    [ "${!envuuid}" ] && AVATAR_UUID="${!envuuid}"
    is_valid_uuid "${AVATAR_UUID}" || {
      [ "${have_jq}" ] && {
        # Avatar name can be provided, convert name to key
        tmp_SLNAME="${SL_NAME}"
        SL_NAME="${AVATAR_UUID}"
        if [ "${corrade}" ]; then
          AVATAR_UUID=$(send_request "name2key" | jq -r '.data[1]')
        else
          AVATAR_UUID=$(send_request "name2key" | jq -r '.key')
        fi
        SL_NAME="${tmp_SLNAME}"
      }
    }
  }
}

# Check for UUID alias in ~/.botctrl
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

# Set the range limit for sit and touch objects in Corrade API if not set in ~/.botctrl
[ "${CORRADE_RANGE}" ] || CORRADE_RANGE="64"

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
    # Strip all but last 3 fields from the location variable to get just the coordinates
    LOCATION=$(get_coords "${LOCATION}")
    if is_valid_coords "${LOCATION}"; then
      send_request "stand" >/dev/null 2>&1
      sleep 2
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
  give_inv*|give_obj*)
    show_usage=
    [ "${AVATAR_UUID}" ] || {
      echo "The ${ACTION} action requires an Avatar UUID specified with -A avatar-uuid"
      show_usage=1
    }
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires an inventory object UUID specified with -u uuid"
      show_usage=1
    }
    [ "${show_usage}" ] && usage brief

    if [ "${have_jq}" ]; then
      send_request "give_inventory" | jq -r .
    else
      send_request "give_inventory"
    fi
    ;;
  note*creat*|creat*note*|nc*creat*|creat*nc*)
    [ "${SL_NAME}" ] || {
      echo "The ${ACTION} action requires a Notecard Name specified with -N name"
      usage brief
    }
    [ "${TEXT}" ] || {
      echo "The ${ACTION} action requires a Notecard text specified with -T text"
      usage brief
    }
    if [ "${have_jq}" ]; then
      send_request "notecard_create" | jq -r .
    else
      send_request "notecard_create"
    fi
    ;;
  pay_avatar|give_money)
    show_usage=
    [ "${AVATAR_UUID}" ] || {
      echo "The ${ACTION} action requires an Avatar UUID specified with -A avatar-uuid"
      show_usage=1
    }
    [ "${AMOUNT}" ] || {
      echo "The ${ACTION} action requires an amount to pay in L\$ specified with -z num"
      show_usage=1
    }
    [ "${show_usage}" ] && usage brief

    if [[ "${AMOUNT}" =~ ^[0-9]+$ ]]; then
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
  rebake*)
    if [ "${have_jq}" ]; then
      send_request "rebake" | jq -r .
    else
      send_request "rebake"
    fi
    ;;
  reply*)
    show_usage=
    [ "${UUID}" ] || {
      echo "The ${ACTION} action requires an Object UUID specified with -u uuid"
      show_usage=1
    }
    [ "${TEXT}" ] || {
      echo "The ${ACTION} action requires a button text specified with -T text"
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
    if [ "${corrade}" ]; then
      [ "${OBJ_NAME}" ] && WEARABLE="${OBJ_NAME}"
      [ "${WEARABLE}" ] || {
        echo "The ${ACTION} action requires a path to an item to wear specified with -O '/path/to/item'"
        usage brief
      }
    else
      [ "${UUID}" ] || {
        echo "The ${ACTION} action requires an item UUID to wear specified with -u uuid"
        usage brief
      }
    fi
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
      send_request "stand" >/dev/null 2>&1
      sleep 2
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
    send_request "stand" >/dev/null 2>&1
    sleep 2
    if [ "${have_jq}" ]; then
      send_request "sit" | jq -r .
    else
      send_request "sit"
    fi
    ;;
  avatar_picks|picks)
    if [ "${have_jq}" ]; then
      UUID="${AVATAR_UUID}"
      AVATAR_NAME=$(send_request "key2name" | jq -r '.name')
      printf "\nAvatar ${AVATAR_NAME} picks:\n\n"
      send_request "avatar_picks" | jq -r '.picks'
    else
      send_request "avatar_picks"
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
  listgroups|groups)
    if [ "${have_jq}" ]; then
      send_request "listgroups" | jq -r .
    else
      send_request "listgroups"
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
    if [ "${corrade}" ]; then
      send_request "${ACTION}"
    else
      echo "Action '${ACTION}' not yet supported"
      list_supported_actions
    fi
    ;;
esac
```

</details>

### Scheduling Bot Actions

**[Note:]** A more modern approach to scheduled LifeBots activities is available
as a `LifeBots Add-On` with the `Routine Planner Add-On` at
[https://lifebots.cloud/store/addon/routine-planner](https://lifebots.cloud/store/addon/routine-planner).
With `Routine Planner` you can build fully automated, interactive bot behaviors using
routines that run on schedules, react to chat/IM triggers, execute actions step-by-step,
and even branch routines based on user responses.

The Truth & Beauty Lab utilizes the `Cron` subsystem on Linux and Macos to
schedule bot actions. Truth & Beauty Lab bots are logged in, teleported
to various locations, seated on various objects, and engaged in a variety of
activities using `crontab` entries that execute `Corrade` and `LifeBots` API
requests at scheduled times. Here is an example `crontab` entry with some brief
descriptions in comments of what activities are scheduled:

```
SHELL=/bin/bash
#
# Schedule BotControl actions
# -------------------------
# Uses the botctrl command line tool at:
#   https://github.com/missyrestless/Bots/blob/main/BotControl/botctrl
# Assumes some configuration in ~/.botctrl has been performed
#
# m h  dom mon dow   command
#
# Weekdays send Anya bot to the club at midnight
0 0 * * 1-5 /bin/bash -lc /usr/local/BotControl/anya2club >> /usr/local/BotControl/log/cron.log 2>&1
# Weekends send Anya bot to the beach at 11am
0 11 * * 0,6 /bin/bash -lc /usr/local/BotControl/anya2beach >> /usr/local/BotControl/log/cron.log 2>&1
# Monday at 4pm send Anya bot to DJ at the Media Sphere
0 16 * * 1 /bin/bash -lc /usr/local/BotControl/anya2msdj >> /usr/local/BotControl/log/cron.log 2>&1
# Monday at 6pm sit Anya in theater seating after her set
0 18 * * 1 /bin/bash -lc /usr/local/BotControl/anya2seat >> /usr/local/BotControl/log/cron.log 2>&1
# Tuesday at 6pm send Angelus bot to DJ at the club
0 18 * * 2 /bin/bash -lc /usr/local/BotControl/angelus2clubdj >> /usr/local/BotControl/log/cron.log 2>&1
# Tuesday at 8pm send Angelus bot back to his dance pole
0 20 * * 2 /bin/bash -lc /usr/local/BotControl/angelus2pole >> /usr/local/BotControl/log/cron.log 2>&1
# Friday at 6pm send Easy bot to DJ at the club
0 18 * * 5 /bin/bash -lc /usr/local/BotControl/easy2clubdj >> /usr/local/BotControl/log/cron.log 2>&1
# Friday at 8pm send Easy bot back to her dance pole
0 20 * * 5 /bin/bash -lc /usr/local/BotControl/easy2pole >> /usr/local/BotControl/log/cron.log 2>&1
# Saturday at 6pm send all bots to dance at the club
0 18 * * 6 /bin/bash -lc /usr/local/BotControl/bots2clubdance >> /usr/local/BotControl/log/cron.log 2>&1
# Saturday at 9pm send all bots back to their default locations
0 21 * * 6 /bin/bash -lc /usr/local/BotControl/bots2home >> /usr/local/BotControl/log/cron.log 2>&1
# Check every hour if Easy bot is at the club greeting visitors
# 0 * * * * /bin/bash -lc /usr/local/BotControl/checkbot >> /usr/local/BotControl/log/cron.log 2>&1
# Send the Easy Islay bot's L$ balance to myself on the 1st of every month
# 0 0 1 * * /bin/bash -lc /usr/local/BotControl/send_easy_balance >> /usr/local/BotControl/log/easy.log 2>&1
```

Here is the code for one of the control scripts, the `checkstatus` script that
reports the online/offline status of configured bots:

```bash
#!/usr/bin/env bash
#
# checkstatus - get status of a Corrade and LifeBots bots
#
# Usage: checkstatus [-n name]

# Default bot
DEF_BOT="Anya"
# All bots
ALL_CO_BOTS="Angel Easy"
ALL_LB_BOTS="Anya"
ALL_BOTS="${ALL_CO_BOTS} ${ALL_LB_BOTS}"

export PATH="/usr/local/bin:${PATH}"
[ -d /opt/homebrew/bin ] && {
  export PATH="/opt/homebrew/bin:${PATH}"
}

have_lb=$(type -p botctrl)
[ "${have_lb}" ] || {
  echo "ERROR: cannot locate botctrl in PATH"
  exit 1
}

have_jq=$(type -p jq)

usage() {
  printf "\nUsage: checkstatus [-A] [-c|l] [-n name]\n\n"
  printf "\nWhere:"
  printf "\n\t-A indicates check status of all bots [All Bots: ${ALL_BOTS}]"
  printf "\n\t-c indicates use Corrade API to perform check"
  printf "\n\t-l indicates use LifeBots API to perform check"
  printf "\n\t-n name specifies the BOT name [default: ${DEF_BOT}]\n\n"
  exit 1
}

check_co_bot() {
  local slbot="$1"
  # Check for Name alias in ~/.botctrl
  local SL_NAME="${slbot}"
  local botname=$(echo "${slbot}" | sed -e "s/ /_/g")
  local envname="BOT_NAME_${botname}"
  [ "${!envname}" ] && SL_NAME="${!envname}"
  if botctrl -a status -c "${SL_NAME}" 2>&1 | grep 'parse error' >/dev/null; then
    STATUS="OFFLINE"
  else
    STATUS="ONLINE"
  fi
  if [ "${have_jq}" ]; then
    printf "\n{\n  \"action\": \"status\",\n  \"status\": \"${STATUS}\",\n  \"slname\": \"${SL_NAME}\"\n}\n" | jq -r .
  else
    printf '\n{'
    printf '\n  "action": "status",'
    printf "\n  \"status\": \"${STATUS}\","
    printf "\n  \"slname\": \"${SL_NAME}\""
    printf '\n}\n'
  fi
  sleep 2
}

BOT= allbots=1 corrade= lifebot=
while getopts ":Acln:h" flag; do
  case $flag in
    A)
      allbots=1
      ;;
    c)
      corrade=1
      ;;
    l)
      lifebot=1
      ;;
    n)
      BOT="$OPTARG"
      allbots=
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

[ "${corrade}" ] && [ "${lifebot}" ] && {
  echo "Only one of -c and -l can be specified. Exiting."
  exit 1
}
[ "${BOT}" ] && {
  [ "${corrade}" ] || [ "${lifebot}" ] || {
    echo "One of -c or -l must be given when specifying bot name with -n name. Exiting."
    exit 1
  }
}

[ "${BOT}" ] || BOT="${DEF_BOT}"

[ -f ${HOME}/.botctrl ] && source ${HOME}/.botctrl

if [ "${allbots}" ]; then
  [ "${ALL_LB_BOTS}" ] && {
    for bot in ${ALL_LB_BOTS}
    do
      if [ "${have_jq}" ]; then
        botctrl -a status -n ${bot} | jq -r '{action: .action, status: .status, slname: .slname}'
      else
        botctrl -a status -n ${bot}
      fi
      sleep 2
    done
  }
  [ "${ALL_CO_BOTS}" ] && {
    for bot in ${ALL_CO_BOTS}
    do
      check_co_bot "${bot}"
    done
  }
else
  if [ "${corrade}" ]; then
    check_co_bot "${BOT}"
  else
    if [ "${have_jq}" ]; then
      botctrl -a status -n ${BOT} | jq -r '{action: .action, status: .status, slname: .slname}'
    else
      botctrl -a status -n ${BOT}
    fi
  fi
fi
```

This script uses a couple of aliases defined in `$HOME/.botctrl`, the `club`
location alias and the `Easy` bot name alias:

```bash
export BOT_NAME_Easy="Easy Islay"
export SLURL_club="http://maps.secondlife.com/secondlife/Scylla/226/32/78"
```

Aliases provide some convenience. For example, the command

```bash
botctrl -a teleport -n Easy -l club
```

is just an easier way of issuing the command

```bash
botctrl -a teleport -n "Easy Islay" -l "http://maps.secondlife.com/secondlife/Scylla/226/32/78"
```

### Using the JSON return as Input

The `botctrl` command returns a JSON object containing the results of the API request. This
object can be parsed with `jq` and the return values used as input to another `botctrl` command.

For example, if you want to send all of the L$ balance of your bot to yourself:

```bash
#!/usr/bin/env bash
#
# send_bot_balance - get the bot's balance and send it to myself
#
# Usage: send_bot_balance [-A] [-n bot_name] [-N recipient_name] [-u uuid]

# Set this to your Second Life avatar name
DEF_SL_NAME="Missy Restless"
# Set this to your bot's name
DEF_BOT_NAME="Easy"
# Set this to all your bots names or their aliases, for use with -A
ALL_LB_BOTS="Anya"
ALL_CO_BOTS="Angel Easy"
ALL_BOTS="${ALL_LB_BOTS} ${ALL_CO_BOTS}"
CORRADE=

export PATH="/usr/local/bin:${PATH}"
[ -d /opt/homebrew/bin ] && {
  export PATH="/opt/homebrew/bin:${PATH}"
}

have_lb=$(type -p botctrl)
[ "${have_lb}" ] || {
  echo "ERROR: cannot locate botctrl in PATH"
  exit 1
}

have_jq=$(type -p jq)
[ "${have_jq}" ] || {
  echo "ERROR: cannot locate jq in PATH"
  exit 1
}

usage() {
  printf "\nUsage: send_bot_balance [-A] [-d] [-n bot_name] [-N recipient_name]\n\n"
  printf "\nWhere:"
  printf "\n\t-A indicates all bots [All Bots: ${ALL_BOTS}]"
  printf "\n\t-d indicates debug mode, no payment [default: false]"
  printf "\n\t-n name specifies the BOT name [default: ${DEF_BOT_NAME}]"
  printf "\n\t-N recipient_name specifies the payment recipient [default: ${DEF_SL_NAME}]\n\n"
  exit 1
}

send_balance() {
  local bot_type="$1"
  local bot_arg="-n"
  local BALANCE=0

  CORRADE=
  if [ "${bot_type}" == "-c" ]; then
    bot_arg="-c"
    CORRADE=1
  else
    if [ "${bot_type}" == "-l" ]; then
      bot_arg="-n"
      CORRADE=
    else
      echo "${ALL_LB_BOTS}" | grep "${BOT_NAME}" >/dev/null || {
        bot_arg="-c"
        CORRADE=1
        echo "${ALL_CO_BOTS}" | grep "${BOT_NAME}" >/dev/null || {
          echo "Unable to determine bot type. Unknown bot."
          exit 1
        }
      }
    fi
  fi
  # Get the bot's balance
  [ "${debug}" ] && {
    echo "Getting bot balance with:"
    if [ "${CORRADE}" ]; then
      echo "botctrl -a balance ${bot_arg} \"${BOT_NAME}\" | jq -r '.data[0]'"
    else
      echo "botctrl -a balance ${bot_arg} \"${BOT_NAME}\" | jq -r '.balance'"
    fi
  }
  if [ "${CORRADE}" ]; then
    BALANCE=$(botctrl -a balance ${bot_arg} "${BOT_NAME}" | jq -r '.data[0]')
  else
    BALANCE=$(botctrl -a balance ${bot_arg} "${BOT_NAME}" | jq -r '.balance')
  fi
  [ "${BALANCE}" ] || {
    echo "ERROR: cannot get bot ${BOT_NAME} balance"
    exit 1
  }

  # Send balance if it is greater than 0
  [ "${debug}" ] && echo "Balance = ${BALANCE}"
  [ ${BALANCE} -gt 0 ] && {
    [ "${debug}" ] && {
      echo "Sending bot balance to ${SL_NAME} with:"
      echo "botctrl -a give_money ${bot_arg} \"${BOT_NAME}\" -A \"${SL_UUID}\" -z ${BALANCE} ${debug}"
    }
    botctrl -a give_money ${bot_arg} "${BOT_NAME}" -A "${SL_UUID}" -z ${BALANCE} ${debug}
  }
}

BOT_NAME= SL_NAME=
allbots=
debug=
while getopts ":Adn:N:h" flag; do
  case $flag in
    A)
      allbots=1
      ;;
    d)
      debug="-d"
      ;;
    n)
      BOT_NAME="$OPTARG"
      ;;
    N)
      SL_NAME="$OPTARG"
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

[ "${BOT_NAME}" ] || BOT_NAME="${DEF_BOT_NAME}"
[ "${SL_NAME}" ] || SL_NAME="${DEF_SL_NAME}"

CORRADE=
echo "${ALL_LB_BOTS}" | grep "${BOT_NAME}" >/dev/null || {
  CORRADE=1
  echo "${ALL_CO_BOTS}" | grep "${BOT_NAME}" >/dev/null || {
    echo "Unable to determine bot type. Unknown bot."
    exit 1
  }
}

if [ "${CORRADE}" ]; then
  SL_UUID=$(botctrl -a name2key -c "${BOT_NAME}" -N "${SL_NAME}" | jq -r '.data[1]')
else
  SL_UUID=$(botctrl -a name2key -n "${BOT_NAME}" -N "${SL_NAME}" | jq -r '.key') 
fi
[ "${SL_UUID}" ] || {
  echo "ERROR: cannot get UUID for Second Life avatar name ${SL_NAME}"
  exit 1
}

if [ "${allbots}" ]; then
  [ "${ALL_LB_BOTS}" ] && {
    for bot in ${ALL_LB_BOTS}
    do
      BOT_NAME="${bot}"
      [ "${BOT_NAME}" ] || {
        echo "ERROR: empty bot name"
        exit 1
      }
      send_balance -l
    done
  }
  [ "${ALL_CO_BOTS}" ] && {
    for bot in ${ALL_CO_BOTS}
    do
      BOT_NAME="${bot}"
      [ "${BOT_NAME}" ] || {
        echo "ERROR: empty bot name"
        exit 1
      }
      send_balance -c
    done
  }
else
  [ "${BOT_NAME}" ] || {
    echo "ERROR: empty bot name"
    exit 1
  }
  send_balance
fi
```

A script like this could be used to automate transfer of L$ from your bots to your
primary avatar. For example, automated transfer of a bot's L$ balance on the 1st of
every month could be setup to run as a `cron` job with the following `crontab` entry:

```
# Send the Easy Islay bot's L$ balance to myself on the 1st of every month
0 0 1 * * /bin/bash -lc /usr/local/BotControl/send_easy_balance >> /usr/local/BotControl/log/easy.log 2>&1
```
### Botctrl Help

In addition to this README, help is available for the `botctrl` command via the commands:

```bash
botctrl -h
```

or

```bash
man botctrl
```

Issues can be reported at https://github.com/missyrestless/Bots/issues

## LifeBots Control Panel

**[Note:]** `LifeBots Control Panel` has moved to its own repository at
[https://github.com/missyrestless/LifeBotsControlPanel](https://github.com/missyrestless/LifeBotsControlPanel)

`LifeBots Control Panel` is an LSL script library to control `LifeBots` bots from an LSL script.

The `LifeBots Control Panel` is a scripted in-world object that acts as a bridge between your
LifeBots management scripts and your LifeBots bots. The control panel communicates with your bots
using the `LifeBots API` and an HTTP server listening to events.
