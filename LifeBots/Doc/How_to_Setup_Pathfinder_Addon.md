# How to Setup the Pathfinder Addon

You can extend your **LifeBots** bot's capabilities with our growing library of specialized add-ons.
**LifeBots** add-ons can be purchased in the **LifeBots Add-On Store** at
[https://lifebots.cloud/store](https://lifebots.cloud/store).

This article describes how to setup the **LifeBots Pathfinder** add-on. The Pathfinder add-on is an
advanced navigation system for your bot with waypoint management, patrol routes, and obstacle avoidance.

## Getting Started

The **LifeBots Pathfinder** add-on works with both Lite and Full LifeBots Bot plans.
Features of the Pathfinder add-on include:

- ✅ Multiple waypoint management
- ✅ Scheduled patrol routes
- ✅ Basic obstacle avoidance
- ✅ Create guide/quest bots

To get started:

- Purchase the **LifeBots Pathfinder Addon** at [https://lifebots.cloud/store/addon/pathfinder](https://lifebots.cloud/store/addon/pathfinder)
- Attach the **LifeBots Pathfinder Addon** to one of your LifeBots bots.
  - **Note:** Purchase additional **LifeBots Pathfinder Addons** for each bot you wish to configure

## Waypoint Navigator

Use the **Waypoint Navigator** to create a sequence of movements and actions for your bot to follow automatically.

The **Pathfinder Addon** allows you to:

- ✅ Create sequences of locations for your bot to visit
- ✅ Add actions like chatting, sitting, animations, and touch interactions
- ✅ Set up patrol routes with timing options
- ✅ Create complex automated behaviors

### Create Your First Waypoint

After purchasing and attaching it to a bot, the **Pathfinder Addon** will now appear listed on your LifeBots Dashboard:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Click the **Pathfinder** entry in the **ADDONS** section of the Dashboard left panel
  - This will open the **Waypoint Navigator** to configure Automated Bot Movement
- Click the **Configure Waypoints** button of the attached bot
  - This will bring up the Waypoints configuration panel for your **Pathfinder** attached bot
- Click the **Create Your First Waypoint** button at the bottom of the **Waypoints** window
  - This will open the **Add Waypoint** window with Waypoint Types to select from

#### Waypoint Types

Currently supported **Waypoint Types** include:

|     | **Waypoint Types** |     |
|:---:|:---:|:---:|
| Repeat/Loop | Wait/Pause | Wait for Message |
| Say Text | Touch Object | Press Key |
| Play Animation | Play Sound | Stand Up |
| Sit on Object | Turn/Rotate | Run to Position |
| Walk to Position | | Teleport |

In the **Add Waypoint** window:

- Select the **Waypoint Type** you wish to add by clicking on its tile
  - This will open the **Add Waypoint** window for this Waypoint Type
  - Some Waypoint Types require additional settings, some do not
- Configure any additional settings required by the selected Waypoint Type
- Click **Add Waypoint**  at the bottom right of the Add Waypoint window

You have now configured your first Waypoint and should be returned to the **Waypoints** window for your attached bot.

### Add More Waypoints

In the **Waypoints** window for your attached bot you can now add more waypoints for your attached bot.

Perform the following sequence for each new Waypoint you wish to add to this Pathfinder path:

- Click the **Add Waypoint** button
  - This will open the **Add Waypoint** window with Waypoint Types to select from
- Select the **Waypoint Type** you wish to add by clicking on its tile
  - This will open the **Add Waypoint** window for this Waypoint Type
- Configure any additional settings required by the selected Waypoint Type
- Click **Add Waypoint**  at the bottom right of the Add Waypoint window
- Repeat these steps for each new Waypoint you wish to add for this path

### Save Waypoints

**[IMPORTANT:]** After adding all Waypoints for a **Pathfinder Addon** path, save your configured Waypoints!!

- Click the **Save Waypoints** button to save your configured Waypoints

## Enable Waypoint Navigator

You configured Waypoints are now saved but not yet enabled. To enable the configured Waypoints path:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Click the **Pathfinder** entry in the **ADDONS** section of the Dashboard left panel
  - This will open the **Waypoint Navigator** to configure Automated Bot Movement
- Click the **Enable Navigator** button for the configured Waypoints of your attached bot
  - This will enable Waypoint Navigator and change the button to **Disable Navigator** for this attached bot's Waypoints

## Start Waypoint Navigator

Once Waypoints are configured, saved, and enabled you can start the Waypoint Navigator sequence:

- Click the **Pathfinder** entry in the **ADDONS** section of the Dashboard left panel
  - This will open the **Waypoint Navigator** to configure Automated Bot Movement
- Click the **Configure Waypoints** button of the attached bot
  - This will bring up the Waypoints configuration panel for your **Pathfinder** attached bot
- Click the **Start Navigator** button in the upper right corner of the Waypoints window for the attached bot

Your bot is now performing the actions configured in the Waypoints added for this path.

To stop the sequence at any time, return to the Waypoints window for your bot and click the
**Pause Navigator** button in the upper right corner of the Waypoints window for the attached bot.

## Additional Waypoints Management

The Waypoints configuration window for your attached bot includes some additional Waypoints management features.

### Export Waypoints

You can export a configured Waypoints path for an attached bot to a JSON file or copy them to the clipboard:

- Click the **Pathfinder** entry in the **ADDONS** section of the Dashboard left panel
- Click the **Configure Waypoints** button of the attached bot
- Click the **Export** button of the Waypoints for the attached bot
  - This will open the **Export Waypoints** window
- Select the export format, **LifeBots Format** or **Standard Format**
- Click **Copy To Clipboard** or **Download File**
- Click **Cancel** to exit the Export Waypoints window

An exported JSON Waypoints file can be modified and imported to configure new Waypoints for attached bots.

### Modify Configured Waypoints

Configured Waypoints for an attached bot can be modified, reordered, paused, or deleted using the **Switch Look**
button in the Waypoints configuration window:

- Click the **Pathfinder** entry in the **ADDONS** section of the Dashboard left panel
- Click the **Configure Waypoints** button of the attached bot
- Click the **Switch Look** button of the Waypoints for the attached bot
  - This will change the list of configured Waypoints into a list that can be edited
- Drag steps to reorder the configured Waypoints
- Click the pencil icon to edit the configuration of a step
- Click the pause icon to pause a step
- Click the trashcan icon to delete a step
- Click the **Save Waypoints** button to save your changes!
