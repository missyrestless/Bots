---
title: BOTCTRL
section: 1
header: User Manual
footer: botctrl 2.0.x
date: November 23, 2025
---

# BOTCTRL

## NAME

botctrl - Manage LifeBots and Corrade Second Life bots from the command line

## SYNOPSIS

botctrl [-deih] [-a action] [-A avatar] [-l location] [-n name] [-k apikey] [-T text] [-C channel]
  [-c corrade] [-F filter] [-M message] [-N name] [-O name] [-S subject] [-s secret] [-u uuid] [-z num]

See the [Bots Github repository README](https://github.com/missyrestless/Bots)
article for additional information on the `botctrl` command and associated tools.

## DESCRIPTION

A command line management system for `LifeBots` and `Corrade` Second Life scripted agents (bots).
The `botctrl` command can be used to manage either `Lite` or `Full` bots from `LifeBots` as well
as `Corrade` bots configured with the built-in Corrade HTTP service enabled.

The `botctrl` command is installed as `/usr/local/bin/botctrl` and symbolic links are created
for the commands `/usr/local/bin/corrade` and `/usr/local/bin/lifebot`. When invoked as `corrade`
the command defaults to using the Corrade API to control your bots. When invoked as `lifebot`
the command defaults to using the LifeBots API to control your bots.

All three commands, `botctrl`, `corrade`, and `lifebot`, can be used to control either Corrade or
LifeBots bobs simply by specifying the bot name with either `-c <Bot_Name>` to use the Corrade API
or `-n <Bot_Name>` to use the LifeBots API.

See [https://lifebots.cloud](https://lifebots.cloud) for more information on `LifeBots`.

See [https://grimore.org/secondlife/scripted_agents/corrade](https://grimore.org/secondlife/scripted_agents/corrade)
for more information on `Corrade`.

### CORRADE CONFIGURATION

**NEW** The `botctrl` command now supports management of both `LifeBots` and `Corrade` bots.
To manage a `Corrade` bot simply replace the `-n <bot name or alias>` command line argument
with `-c <bot name or alias>`.

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

Note that each Corrade API request requires some permissions enabled in the Corrade
Configuration. For example, balance inquiries and payments require the `economy`
permission, inventory operations require the `inventory` permission, movement requires
the `movement` permission. An example set of Corrade permissions that enable capabilities
required by the `botctrl` command might look like:

```xml
    <Permissions>
        <Permission>movement</Permission>
        <Permission>grooming</Permission>
        <Permission>interact</Permission>
        <Permission>notifications</Permission>
        <Permission>talk</Permission>
        <Permission>group</Permission>
        <Permission>land</Permission>
        <Permission>inventory</Permission>
        <Permission>directory</Permission>
        <Permission>system</Permission>
        <Permission>bridge</Permission>
        <Permission>economy</Permission>
        <Permission>execute</Permission>
    </Permissions>
```

## CONFIGURATION

The `botctrl` command is installed in `/usr/local/bin` along with some
utility scripts for use with `cron` or other management systems. These
utility scripts will need to be modified to suit your specific needs,
configuration and bot names. You can modify the scripts in
`LifeBots/bin/` and re-run `./install-botctrl`.

Add `/usr/local/bin` to your execution `PATH` if it is not already included.

Configure `botctrl` by adding and editing the file `${HOME}/.botctrl`.

At a minimum, you must configure your `LifeBots` developer API key and bot
secrets for the `LifeBots` bots you wish to control using the `botctrl` command.

The following example entries in `$HOME/.botctrl` will allow you to control your
`LifeBots` bot named "Your Botname" using the `botctrl` command:

```bash
## Minimum contents of $HOME/.botctrl
#
# LifeBots Developer API Key
export LB_API_KEY='<your-lifebots-api-key>'
# LifeBots bot secret
export LB_SECRET_Your_Botname='<your-bot-secret>'
```

Add an entry of the form `export LB_SECRET_Firstname_Lastname='<bot-secret>'`
to `$HOME/.botctrl` for each of your `LifeBots` bots.

### Example $HOME/.botctrl

```sh
# LifeBots configuration file for use with the lifebot command line script
#
# Configure API credentials for each bot and copy the file to ${HOME}/.botctrl
# For security make the file accessible by owner only:
#   chmod 600 ${HOME}/.botctrl
#
# LifeBots Developer API Key
export LB_API_KEY='your-api-key'
export LB_SECRET='your-bot-secret'  # Also referred to in the doc as an access code

# If you have more than one bot you can set each bot's secret like this
export LB_SECRET_BOT1_NAME='your-first-bot-secret'
export LB_SECRET_BOT2_NAME='your-second-bot-secret'
export LB_SECRET_BOT3_NAME='your-third-bot-secret'
# Replace spaces in the Bot's name with "_"
# For example, if the Bot's name is "John Doe" then the entry would be:
export LB_SECRET_John_Doe='john-doe-bot-secret'

# Default Bot Name and ID
export LB_BOT_NAME='your-default-bot-name'
# LifeBots Bot ID
export LB_BOT_ID_Bot_Name='lifebots-bot-id'
# Second Life Bot ID
export SL_BOT_ID_Bot_Name='secondlife-bot-id'
# Login siton UUID
export LOGIN_SITON_Bot_Name="uuid-of-siton-object"

# OAuth Applications
# If you have configured OAuth applications then the client id and secret can be set here
export LB_CLIENT_ID_app_name='your-oauth-app-client-id'
export LB_CLIENT_SECRET_app_name='your-oauth-app-client-secret'

# The following optional convenience entries are supported to allow
# specifying an alias on the command line rather than a SLURL or UUID
# All configured aliases can be listed with the command "lifebot -a alias"
#
## Bot name aliases for use with the "-n name" command line option
export BOT_NAME_bot1="Bot1 Name"
export BOT_NAME_bot2="Bot2 Name"
export BOT_NAME_bot3="Bot3 Name"

## Slurl aliases for use with the "-l location" command line option
# SLURL aliases can be set for use with the location option, -l location
# For example, the following 2 SLURL aliases could be used with -l beach or -l club
# to teleport the bot to the beach or the club specified in these SLURLs
export SLURL_beach="http://maps.secondlife.com/secondlife/BEACH_REGION_NAME/X/Y/Z"
# Urlencode spaces in the region name by using %20 instead of space
export SLURL_club="http://maps.secondlife.com/secondlife/CLUB_REGION%20NAME/X/Y/Z"

## UUID aliases for use with the "-u uuid" command line option
# UUID aliases can be set for use with the UUID option, -u uuid
# For example, the following UUID aliases could be used with -u dancepole
# or -u couch to seat the bot on the specified object
export UUID_dancepole="dance-pole-object-uuid"
export UUID_couch="couch-object-uuid"

# Corrade command control via LifeBots
export CORRADE_GROUP="<your-corrade-bot-group-name>"
export CORRADE_PASSW="<your-corrade-bot-group-password>"
export CORRADE_URL="https://your.corrade.server"
export API_URL_bot1_name="${CORRADE_URL}/bot1/"
export API_URL_bot2_name="${CORRADE_URL}/bot2/"
```

## OPTIONS

The following command line options are available with `botctrl`:

`-a action` : specifies the API action (sit, teleport, login, ...)

`-l location` : specifies a location for login and teleport actions

`-n name` : specifies a LifeBots Bot name, Default: Anya Ordinary

`-c name` : specifies a Corrade Bot name, Default: Easy Islay

`-k apikey` : specifies an API Key, use environment instead

`-T text` : specifies the dialog button text for replies to dialog menus

`-C channel` : specifies the channel for a message [default: 0]

`-F filter` : specifies a filter to match when listing attachments

`-M message` : specifies the message body for a group notice/im

`-N name` : specifies the SL name of the recipient of an IM

`-O name` : specifies an attachment object name or outfit name

`-S subject` : specifies the subject for a group notice

`-s secret` : specifies a Bot secret, use environment instead

`-u uuid` : specifies a UUID for use with actions that require one (e.g. sit)

`-z num` : specifies a hover height adjustment size [default: -0.05], can also be used to specify a payment amount

`-d` : indicates dryrun mode - tell me what you would do without doing anything

`-e` : displays a list of supported commands and examples then exits

`-i` : retrieves Bot details

`-h` : displays this usage message and exits

### Supported Actions

- Supported LifeBots actions:
  - login, logout, status, bot_location, walkto, sit, stand, teleport, listalias, key2name, notecard_create,
  - avatar_picks, name2key, listinventory, im, reply_dialog, send_notice, send_group_im, attachments,
  - rebake, touch_attachment, touch_prim, activate_group, wear, takeoff, say_chat_channel, set_hoverheight,
  - get_outfit, get_outfits, wear_outfit, get_balance, give_inventory, give_money, give_money_object
- Supported Corrade actions:
  - attach, batchavatarkeytoname, batchavatarnametokey, changeappearance, createlandmark,
  - createnotecard, detach, fly, flyto, getattachments, getattachmentspath, getmembersonline,
  - inventory cwd, inventory list current outfit, inventory list outfits, pay avatar,
  - pay object, sit, stand, teleport, touch, unwear, walkto, wear

### ENVIRONMENT

Entries in `~/.botctrl` can be `LB_API_KEY`, `LB_SECRET`, or entries of the form `LB_SECRET_BOT_NAME` in order to support multiple bots.

Entries can specify a Slurl alias. For example:

```sh
export SLURL_club='http://maps.secondlife.com/secondlife/Scylla/226/32/78'
```

A Slurl alias can be used with the `-l` command line argument, e.g. `-l club`

Entries can also specify a UUID alias. For example:

```sh
export UUID_Mover='xxxxxxxx-yyyy-zzzz-aaaa-bbbbbbbbbbbb'
```

A UUID alias can be used with the `-u` command line argument, e.g. `-u Mover`

### COMMANDS

The `botctrl` command supports a significant subset of the full `LifeBots` API.

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

- `listalias` : list configured `lifebot` aliases in `$HOME/.botctrl`

### EXAMPLES

**[NOTE:]** the examples below all assume you have configured `$HOME/.botctrl`
with your `LifeBots` API key and the bot secret:

```bash
# LifeBots Developer API Key
export LB_API_KEY='<redacted>'
## John Doebot LifeBots secret
export LB_SECRET_John_Doebot='<redacted>'
```

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
- `listalias` : list configured `lifebot` aliases in `$HOME/.botctrl`
  - `Example` : list all configured `lifebot` aliases
  - `botctrl -a listalias`
  - `Example` : list configured `lifebot` bot aliases only
  - `botctrl -a botalias`
  - `Example` : list configured `lifebot` location aliases only
  - `botctrl -a slurlalias`
  - `Example` : list configured `lifebot` UUID aliases only
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
  - `botctrl -a reply -n "John Doebot" -C 99999 -T Male -u "a811d6fe-de59-2f4e-ee19-0cc48da48981"`
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

## AUTHORS

Written by Missy Restless `missyrestless@gmail.com`

## LICENSE

MIT License

Copyright (c) 2025-2026 Truth & Beauty Lab

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## BUGS

Submit bug reports online at:

<https://github.com/missyrestless/Bots/issues>

## SEE ALSO

Full documentation and sources at:

<https://github.com/missyrestless/Bots>
