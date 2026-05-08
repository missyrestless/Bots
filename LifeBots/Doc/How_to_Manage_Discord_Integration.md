# How to Manage Discord Integration

**LifeBots Discord Integration** enables communication and synchronization
of your **LifeBots** managed Second Life groups via [Discord](https://discord.com).

## Setup a Discord Server

A Discord Server is a collection of persistent chat rooms and voice channels.

In order to connect the **LifeBots Discord Integration** service with Discord
you must have a Discord account and you must create a Discord Server if you
do not already have one. There is no charge for setting up a Discord Server.

To create a server in Discord:

- Visit [https://discord.com](https://discord.com) and click the **Open Discord in your browser** button
  - Alternatively, download and install the [Discord App](https://discord.com/download) for your platform
- Login to Discord and click the **Add a Server** plus icon near the bottom of the left side panel
- Follow the instructions for setting up a Discord Server
  - A detailed [Discord Server Setup Guide](https://support.discord.com/hc/en-us/articles/33023827550359-Discord-Server-Setup-Guide) is provided by Discord

## Setup Discord Integration

Connect your Second Life groups to Discord servers for seamless communication
between in-world and out-of-world.

To setup Discord integration for your LifeBots groups:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Near the bottom of the left panel click **Discord integration**
- Connect **LifeBots Discord Integration** with Discord by clicking the **Setup** button

Select a Discord account to connect or click the **Connect Discord Account**
button if no Discord accounts are connected yet.

Clicking the **Connect Discord Account** button will bring up the **LB-Sync**
Discord App in your browser. Make sure you are signed into Discord as the
user you wish to use for this service by checking the "Signed in as" in the
**LB-Sync** window.

Select a Discord Server from the dropdown and Click **Continue**

Click **Authorize** to grant administrative privileges to LB-Sync.

Your Discord account is now connected. You can optionally add more Discord accounts.

Click **Set Up Discord** again.

Select which Discord account to use for this integration and click **Continue**.

Select which Discord Server you want to connect to this group and click **Continue**.

Select a Chat Channel and click **Save Configuration**.

Repeat this Discord Integration Setup process for each group you wish to
integrate with Discord.

## Manage Discord Integration

Once Discord Integration Setup is completed, to manage this service:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Click **Discord integration** near the bottom of the left side panel
- Alternatively:
  - Click on **Manage Groups** in the left side panel of your LifeBots dashboard
  - Click on the group you wish to manage
  - Click the **Discord Integration** tile for that group

Here you can manage connected Discord channels, change the Discord connected accout,
change the connected Discord server, and reconfigure the LB-Sync integration.

## Discord integration Settings

Connected Groups with Discord integration in the **Discord integration** window will
have a green checkmarked **Manage** button. Discord integration settings for these
connections can be configured.

To configure Discord integration for a connected group:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Click **Discord integration** near the bottom of the left side panel
- Click the **down arrowhead symbol** (&#x2304;) to the right of the green checkmarked **Manage** button for a connected group
- In the **Discord integration Settings** pane, currently supported options are:
  - **Enable Sent Tickmark**
    - Show a green checkmark (✅) reaction on Discord messages after they're successfully sent to Second Life
  - **Force User Verification**
    - Require Discord users to verify their Second Life avatar before sending messages to the group

### Enable Sent Tickmark

When **Enable Sent Tickmark** is enabled messages sent by your bots will have a
tickmark reaction indicating the message has been delivered.

### Force User Verification

When **Force User Verification** is enabled:

- Messages in the Discord channel from an unverified user will be removed and not sent to the group
- A Discord direct message will be sent to the unverified user informing them to **/verify** in the channel
- When they use **/verify** a popup window will be displayed informing them to enter their Second Life name
- Once they enter their Second Life username and submit it, a link will be sent to verify in Second Life
- When the user verifies in Second Life their message will be sent from Discord to Second Life
- Verified user messages display the Second Life username in the Second Life group rather than their Discord server nickname
