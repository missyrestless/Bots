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
- [LifeBots Control Panel](#lifebots-control-panel)
- [LifeBots Command Line](#lifebots-command-line)
- [Corrade](#corrade)
- [Corrade Setup for use with the LifeBots Command Line tools](#corrade-setup-for-use-with-the-lifebots-command-line-tools)
  - [Nginx Reverse Proxy](#nginx-reverse-proxy)
  - [LifeBots Configuration for use with Corrade](#lifebots-configuration-for-use-with-corrade)
  - [Security Notes](#security-notes)
- [Corrade HUD](#corrade-hud)

## Repository Contents

- `Avatars`: Specifications for free male and female avatars
- `bin`: Convenience scripts to manage Corrade services on the server-side
- `etc`: Corrade, Nginx, and Shoutcast configuration and systemd units
- `Evade_Region_Restart`: Script and configuration notecard to evade region restarts
- `Examples`: Some simple examples of how to use the Corrade system
- `HUD`: The Corrade HUD, control bots in-world with this heads-up display
- `LifeBots`: The lifebot command line management system for LifeBots and Corrade bots
- `Masters`: Script and configuration notecard to extend some privileges to the Corrade bot owner
- `Pay2Play`: WDC Tipjar settings examples
- `Select_Dialog_Option`: A dialog menu selector for the Corrade bot
- `Sit_Animate`: Example sit on object and animate a Corrade bot
- `Toggle_Vista_AO`: Example script turning on/off the Vista AO of a bot

## LifeBots Control Panel

`LifeBots Control Panel` is an LSL script library to control `LifeBots` bots from an LSL script.

See the
[LifeBots Control Panel repository](https://github.com/missyrestless/LifeBotsControlPanel)
for details on the in-world LSL bridge for `LifeBots`.

## LifeBots Command Line

**NEW** The `lifebot` command now supports management of both `LifeBots` and `Corrade` bots.
To manage a `Corrade` bot simply replace the `-n <bot name or alias>` command line argument
with `-c <bot name or alias>`.

The `LifeBots Command Line` is a suite of tools that enable control and management of
[LifeBots](https://lifebots.cloud) and [Corrade](https://grimore.org/secondlife/scripted_agents/corrade)
bots via the Unix/Linux command line. These tools are executed in a terminal using the Bash shell
and standard Linux utilities.

The primary command line tool is the `lifebot` Bash script which acts as a front-end
for `LifeBots` and `Corrade` API requests.

For those power users who wish to automate their `LifeBots` or `Corrade` bots using
the command line and tools such as `cron` and `jq` the `lifebot` command and associated
utilities found here may provide additional power and flexibility. The `LifeBots` command
line management system is open source and free to download, deploy, modify, and distribute.

See the [LifeBots README](https://github.com/missyrestless/Bots/tree/main/LifeBots#readme)
for details on the LifeBots Command Line.

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

## Corrade Setup for use with the LifeBots Command Line tools

In order to use the `lifebot` command to manage your `Corrade` bot(s),
the HTTP server must be enabled in the `Corrade` configuration:

```
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

### Nginx Reverse Proxy

In order to use SSL/TLS for API requests you can run a reverse proxy on the system
where `Corrade` is running and forward HTTPS protocol requests to HTTP protocol on localhost.

Here is an example `Nginx` configuration snippet acting as a reverse proxy for 2 `Corrade` bots:

```
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_buffering off; # Important for bots to prevent buffering delays

    location = /angel/ {
        # Angelus Portal HTTP server
        proxy_pass http://127.0.0.1:8081;
    }

    location = /easy/ {
        # Easy Islay HTTP server
        proxy_pass http://127.0.0.1:8082;
    }
```

### LifeBots Configuration for use with Corrade

```bash
# Corrade command control via LifeBots
export CORRADE_GROUP="<your-corrade-bot-group-name>"
export CORRADE_PASSW="<your-corrade-bot-group-password"
export CORRADE_URL="<your-corrade-http-url>"
# Add at least one API URL, each Corrade bot needs a unique API URL
export API_URL_Your_Bot_Name="${CORRADE_URL}"
# Add any reverse proxies you have configured, for example:
export API_URL_Angelus_Portal="${CORRADE_URL}/angel/"
export API_URL_Easy_Islay="${CORRADE_URL}/easy/"
```

### Security Notes

It is strongly recommended to enable SSL/TLS in a web server that is configured as a
reverse proxy for your API requests. Without encryption you are sending the group password
over the network in plain text. Anyone with your bot's group name and group password can
control your bot via the API.

The bot's group name and password is also configured in the LifeBots Command configuration
file `~/.lifebots`. Protect this file by making it readable by owner only:

```bash
chmod 600 ~/.lifebots
```

## Corrade HUD

Truth & Beauty Lab Corrade development also includes enhancements to the
[Corrade HUD](https://github.com/missyrestless/Bots/blob/main/HUD/README.md),
an in-world heads-up display that can be used to control a Corrade scripted agent.
