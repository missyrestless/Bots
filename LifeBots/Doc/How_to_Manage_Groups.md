# How to Manage a Group

LifeBots Full Bot plans include access to Personal Bot Groups which provide
group notice scheduling, IM services, web chat, and Discord synchronization.

You are able to manage your Groups using the LifeBots Web UI. This article
provides details on LifeBots Group Management.

If you have not yet added a Group then see the **Related Articles** below
for an article on **How to Add a Group**.

**Note:** Your bot's membership in some groups may need to be elevated to
grant some group permissions in order to be able to manage selected services.
Typically the group privilege that needs to be added is the power to send notices
to the group. This can usually be resolved by elevating the bot's membership
in the group to Officer, Save the change, and Refresh Powers in Manage Groups.

## Select a Group to Manage

Your Bot Groups are displayed on your LifeBots Dashboard and a
**Manage Groups** entry is displayed under **Groups** in the left side pane.

To select a Group to Manage:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Click the **Manage Groups** entry in the left pane under **Groups**
- Click on one of the Groups displayed to manage it

Alternatively, you can click on the group's tile on your Dashboard.
The dashboard only displays the first few groups. To see all of your
groups click **View All Personal Groups** at the bottom of your dashboard
or click on the **Manage Groups** button.

## Group Management

Depending on which services you have enabled you will see one or more of the following:

|   | Group Services |   |
|:---:|:---:|:---:|
| [Manage Services](#manage-services) | [API Details](#api-details) | [Group Notices](#group-notices) |
| [Group IMs](#group-ims) | [Group Chat](#group-chat) | [Group Inviter](#group-inviter) |
|   | [Discord Integration](#discord-integration) |   |

### Manage Services

Select or Deselect which group services are enabled (**Group Greeter/Inviter** can be enabled here).

### API Details

Click **API Details** and set your Group API Access Code

- This access code allows external applications to interact with your group through the LifeBots API.
  - Use this code to authenticate API requests for this group
  - Keep this code secure and don't share it publicly
  - You can change this code at any time
  - Code must be between 6-32 characters
- You can enter the code you wish to use or click the **Generate Random Code** button (recommended)
- Click **Copy Code** to copy the code to your clipboard.
- Store the code securely and do not share it with anyone
- Click the **Save Access Code** button
- To view the Groups API documentation visit [https://lifebots.cloud/developer](https://lifebots.cloud/developer) and click on Groups

### Group Notices

In the **Group Notices** service management window you can send, edit,
remove, view, search, and schedule One-Time or Periodic group notices.

Notices can be sent to multiple groups, scheduled for delivery at a specific time,
scheduled for periodic delivery, or sent immediately.

Note that in order to send group notices your bot must have that power,
a privilege typically afforded to Group Officers and Owners.

### Group IMs

In the **Group IMs** service management window you can send, edit,
remove, view, search, and schedule One-Time or Periodic group instant messages (IMs).

IMs can be sent to multiple groups, scheduled for delivery at a specific time,
scheduled for periodic delivery, or sent immediately.

Note that in order to send group IMs your bot must have that power,
a privilege typically afforded to Group Officers and Owners.

### Group Chat

In the **Group Chat** service management window you can send and view messages
to the selected group's Chat.

Type your message in the message bar at the bottom of the window and press Enter
or click the send icon to the right of the message bar.

### Group Inviter

**Group Inviter** is in development.

### Discord Integration

**Note:** In order to connect this service with Discord you must have
a Discord account and you must create a Discord Server if you do not
already have one. To create a server in Discord click the **Add a Server**
plus icon in the left side panel and follow the instructions.

#### Setup Discord Integration

Click **Manage Groups** then click on the group you wish to manage.

Connect the **Discord Integration** with Discord by clicking the **Setup**
button at the bottom of the Discord Integration tile and clicking the
**Set Up Discord** button.

Select a Discord account to connect or click the **Connect Discord Account**
button if no Discord accounts are connected yet.

Clicking the **Connect Discord Account** button will bring up the LB-Sync
Discord App in your browser. Make sure you are signed into Discord as the
user you wish to use for this service by checking the "Signed in as" in the
LB-Sync window.

Select a Discord Server from the dropdown and Click **Continue**

Click **Authorize** to grant administrative privileges to LB-Sync.

Your Discord account is now connected. You can optionally add more Discord accounts.

Click **Set Up Discord** again.

Select which Discord account to use for this integration and click **Continue**.

Select which Discord Server you want to connect to this group and click **Continue**.

Select a Chat Channel and click **Save Configuration**.

Repeat this Discord Integration Setup process for each group you wish to
integrate with Discord.

#### Manage Discord Integration

Once Discord Integration Setup is completed you can manage this service by
clicking on **Manage Groups** then click on the group you wish to manage
then click the **Discord Integration** tile for that group.

Here you can manage connected Discord channels, change the Discord connected accout,
change the connected Discord server, and reconfigure the LB-Sync integration.
