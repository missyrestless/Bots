# Lifebot Release

This release of the `lifebot` command line management system for `LifeBots`
adds support for additional LifeBots API commands including:

```
login, logout, status, location, walkto, sit, teleport, listalias,
listinventory, im, reply_dialog, send_notice, send_group_im, touch
```

The release includes the release artifact `install-lifebot` which can be used
to install the `lifebot` management system. See the
[repository README](https://github.com/missyrestless/Bots) for additional info.

## Install lifebot

To install `lifebot`:

```bash
git clone https://github.com/missyrestless/Bots.git
cd Bots
./install-lifebot
```

Alternatively, download the `install-lifebot` release artifact and
execute it. The `install-lifebot` script will clone the repository
and install the system.

The `lifebot` command is installed in `/usr/local/bin` along with some
utility scripts for use with `cron` or other management systems. These
utility scripts will need to be modified to suit your specific needs,
configuration and bot names. You can modify the scripts in
`LifeBots/bin/` and re-run `./install-lifebot`.

Add `/usr/local/bin` to your execution `PATH` if it is not already included.

Configure `lifebot` by adding and editing the file `${HOME}/.lifebots`.
See `LifeBots/example_dot_lifebots` for a template to use for this file.

See `LifeBots/crontab.in` for example crontab entries to schedule bot activities.
