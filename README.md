# Second Life Bots

This repository contains commands, configuration, and management scripts for
Second Life bots. Included are management systems for `Corrade` bots and `LifeBots`.

**[NOTE:]** The Truth & Beauty Lab and Missy Restless are not associated in any way
with either `Corrade` or `LifeBots`.

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

### Install lifebot

The `lifebot` command line management system requires:

- Linux, Macos, or Windows Subsystem for Linux (WSL)
- Bash
- Cron
- git
- [jq](https://jqlang.org)

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

## Corrade HUD

Current Truth & Beauty Lab Corrade development centers around the
[Corrade HUD](https://github.com/missyrestless/Bots/blob/main/HUD/README.md),
an in-world heads-up display that can be used to control a Corrade scripted agent.
