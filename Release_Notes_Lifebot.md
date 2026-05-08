# Lifebot Release

This release of the `lifebot` command line management system for `LifeBots` adds support for additional LifeBots API commands including:

- `activate_group` : activate a group tag
- `attachments` : list bot attachments, optionally specify a filter to match
- `bot_location` : get precise bot location
- `get_balance` : get your bot's L$ balance
- `get_outfit` : list currently worn bot outfit
- `get_outfits` : list available bot outfits
- `give_money` : pay another avatar L$ from your bot
- `give_money_object` : pay an object L$ from your bot
- `im` : send an instant message to an avatar
- `listalias` : list configured `lifebot` aliases in `$HOME/.lifebots`
- `listinventory` : list bot inventory, optionally specify an inventory folder UUID
- `login` : login bot
- `logout` : logout bot
- `reply_dialog` : reply to a dialog menu (requires channel, UUID, and button text)
- `send_group_im` : send an instant message to a group
- `send_notice` : send an official group notice to all group members
- `set_hoverheight` : adjust bot hover height
- `sit` : sit on a specified object UUID
- `status` : get bot status
- `takeoff` : remove a worn item
- `teleport` : teleport bot to specified location
- `touch_attachment` : touch a specified bot attachment
- `touch_prim` : touch a specified object by UUID
- `walkto` : walk bot to a location
- `wear` : wear an inventory item (uses "add" rather than "wear")
- `wear_outfit` : wear a specified outfit

The release includes the release artifact `install-lifebot` which can be used to install the `lifebot` management system. See the [repository README](https://github.com/missyrestless/Bots) for additional info and example `lifebot` command invocations.

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

The following example entries in `$HOME/.lifebots` will allow you to control your `LifeBots` bot named "Your Botname" using the `lifebot` command:

```bash
## Minimum contents of $HOME/.lifebots
#
# LifeBots Developer API Key
export LB_API_KEY='<your-lifebots-api-key>'
# LifeBots bot secret
export LB_SECRET_Your_Botname='<your-bot-secret>'
```

Add an entry of the form `export LB_SECRET_Firstname_Lastname='<bot-secret>'` to `$HOME/.lifebots` for each of your `LifeBots` bots.

See `LifeBots/example_dot_lifebots` for a template to use for this file.

See `LifeBots/crontab.in` for example crontab entries to schedule bot activities.

## Usage

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
