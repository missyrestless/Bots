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

- Linux, Macos, or Windows Subsystem for Linux (WSL)
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

The `lifebot` command is installed in `/usr/local/bin` along with some
utility scripts for use with `cron` or other management systems. These
utility scripts will need to be modified to suit your specific needs,
configuration and bot names. You can modify the scripts in
`LifeBots/bin/` and re-run `./install-lifebot`.

Add `/usr/local/bin` to your execution `PATH` if it is not already included.

Configure `lifebot` by adding and editing the file `${HOME}/.lifebots`.
See `LifeBots/example_dot_lifebots` for a template to use for this file.

See `LifeBots/crontab.in` for example crontab entries to schedule bot activities.

See the section [Scheduling Bot Actions](#scheduling-bot-actions) below for more
details on scheduling bot actions.

### Supported Bot Actions and Examples

The `lifebot` command supports a significant subset of the full `LifeBots` API.

The following actions and commands, along with example command line invocations,
are supported by the `lifebot` command:

- `attachments` : list bot attachments, optionally specify a filter to match
  - Example : list bot named `John Doebot` attachments with name containing the string `HUD`
  - `lifebot -a attachments -F "HUD" -n "John Doebot"`
- `bot_location` : get precise bot location
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `get_outfit` : list currently worn bot outfit
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `get_outfits` : list available bot outfits
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `im` : send an instant message to an avatar
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `listalias` : list configured `lifebot` aliases in `$HOME/.lifebots`
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `listinventory` : list bot inventory, optionally specify an inventory folder UUID
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `login` : login bot
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `logout` : logout bot
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `reply_dialog` : reply to a dialog menu (requires channel and button text)
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `send_group_im` : send an instant message to a group
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `send_notice` : send an official group notice to all group members
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `set_hoverheight` : adjust bot hover height
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `sit` : sit on a specified object UUID
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `status` : get bot status
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `teleport` : teleport bot to specified location
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `touch_attachment` : touch a specified bot attachment
  - Example : bot named `John Doebot`
  - `lifebot -a foobar -n "John Doebot"`
- `touch_prim` : touch a specified object by UUID
  - Example : bot named `John Doebot` touch an object
  - `lifebot -a touch_prim -n "John Doebot" -u "f11781d0-763f-52f9-4e23-3a2b97759fa2"`
    - If `$HOME/.lifebots` contains an entry : `export UUID_spoton="f11781d0-763f-52f9-4e23-3a2b97759fa2"`
    - `lifebot -a touch_prim -n "John Doebot" -u spoton`
- `walkto` : walk bot to a location
  - Example : bot named `John Doebot` walk to X/Y/Z coordinates 100/50/28
  - `lifebot -a walkto -n "John Doebot" -l "100/50/28"`
- `wear_outfit` : wear a specified outfit
  - Example : bot named `John Doebot` wear the outfit named "Business Casual"
  - `lifebot -a wear_outfit -n "John Doebot" -O "Business Casual"`

Development is in progress for additional actions. Let us know which
`LifeBots` API requests you would like supported.

### Usage and Source of lifebot command

<details><summary>Click here to view the

**lifebot command usage message**

</summary>

```
```

</details>

<details><summary>Click here to view the

**lifebot source code**

</summary>

```bash
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
