# Lifebot

This major new release of the `lifebot` command line management system adds support for controlling `Corrade` bots from the command line.

The previous release of the `lifebot` command line management system for `LifeBots` added support for additional LifeBots API commands, provides examples for each command, adds a `lifebot` man page, fixes several bugs, and simplifies installation and updates.

The release includes the release artifact `install-lifebot` which can be used to install the `lifebot` management system. See the [Install lifebot](#install-lifebot) section below for installation instructions. See the [repository README](https://github.com/missyrestless/Bots) for additional info and example `lifebot` command invocations.

## Install lifebot

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

Alternatively, download the `install-lifebot` release artifact and execute it. The `install-lifebot` script will clone the repository and install the system:

```bash
wget -q https://github.com/missyrestless/Bots/releases/latest/download/install-lifebot
chmod 755 install-lifebot
./install-lifebot
```

## Configure lifebot

The `lifebot` command is installed in `/usr/local/bin` along with some utility scripts for use with `cron` or other management systems. These utility scripts will need to be modified to suit your specific needs, configuration and bot names. You can modify the scripts in `LifeBots/bin/` and re-run `./install-lifebot`.

Add `/usr/local/bin` to your execution `PATH` if it is not already included.

Configure `lifebot` by adding and editing the file `${HOME}/.lifebots`.

At a minimum, you must configure your `LifeBots` developer API key and bot secrets for the `LifeBots` bots you wish to control using the `lifebot` command.

The following example entries in `$HOME/.lifebots` will allow you to control your `LifeBots` bot named "LifeBots Botname" and a `Corrade` bot named "Corrade Botname" using the `lifebot` command:

```bash
## Minimum contents of $HOME/.lifebots
#
# LifeBots Developer API Key
export LB_API_KEY='<your-lifebots-api-key>'
# LifeBots bot secret
export LB_SECRET_LifeBots_Botname='<your-bot-secret>'
# Corrade command control via LifeBots
export CORRADE_GROUP="<your-corrade-bot-group-name>"
export CORRADE_PASSW="<your-corrade-bot-group-password>"
export CORRADE_URL="https://your.corrade.server"
# Assuming a reverse proxy is configured for the /corrade/ location
export API_URL_Corrade_Botname="${CORRADE_URL}/corrade/"
```

Add an entry of the form `export LB_SECRET_Firstname_Lastname='<bot-secret>'` to `$HOME/.lifebots` for each of your `LifeBots` bots.

See `LifeBots/example_dot_lifebots` for a template to use for this file.

See `LifeBots/crontab.in` for example crontab entries to schedule bot activities.

## Usage

<details><summary>Click here to view the

**lifebot command usage message**

</summary>

```
Usage: lifebot [-deih] [-a action] [-A avatar] [-l location] [-n name] [-k apikey] [-B text] [-C channel]
  [-c corrade] [-F filter] [-M message] [-N name] [-O name] [-S subject] [-s secret] [-u uuid] [-z num]
Where:
	-a action specifies the API action (sit, teleport, login, ...)
	Supported actions:
	  login, logout, status, bot_location, walkto, sit, stand, teleport, listalias, key2name, rebake,
	  avatar_picks, name2key, listinventory, im, reply_dialog, send_notice, send_group_im, attachments,
	  touch_attachment, touch_prim, activate_group, wear, takeoff, say_chat_channel, set_hoverheight,
	  get_outfit, get_outfits, wear_outfit, get_balance, give_inventory, give_money, give_money_object
	-l location specifies a location for login and teleport actions
		Default: Last location, teleport action requires a Slurl location
	-n name specifies a Bot name, Default: Easy Islay
	-k apikey specifies an API Key, use environment instead
	-A avatar specifies an avatar UUID for use with giving money or objects
	-B text specifies the dialog button text for replies to dialog menus
	-C channel specifies the channel for a message [default: 0]
	-c corrade specifies a Corrade bot name to act upon
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
  lifebot -a stand -n Jane -c John # Jane bot sends the stand command to Corrade bot John
  lifebot -a teleport -l club  # Uses a 'club' location alias defined in .lifebots
```

</details>
