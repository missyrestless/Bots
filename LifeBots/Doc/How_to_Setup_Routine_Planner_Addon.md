# How to Setup the Routine Planner Advanced Routing System Add-On

You can extend your **LifeBots** bot's capabilities with our growing library of specialized add-ons.
**LifeBots** add-ons can be purchased in the **LifeBots Add-On Store** at
[https://lifebots.cloud/store](https://lifebots.cloud/store).

This article describes how to setup the **LifeBots Routine Planner** add-on. See the related article
on **What is the Routine Planner Add-On** below for a description of this add-on, features, and use cases.

**[NOTE:]** The Routine Planner add-on is only available for LifeBots Full Bots. See the related
articles on the **Pathfinder Add-On** below for LifeBots Lite Bot route management.

## Getting Started

To get started:

- Purchase the **LifeBots Routine Planner Add-On** at [https://lifebots.cloud/store/addon/routine-planner](https://lifebots.cloud/store/addon/routine-planner)
- Attach the **LifeBots Routine Planner Add-On** to one of your LifeBots Full bots.
  - **Note:** Purchase additional **LifeBots Routine Planner Add-Ons** for each bot you wish to configure

### Create Your First Routine

After purchasing and attaching it to a bot, the **Routine Planner** Add-On will now appear listed on your LifeBots Dashboard:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Click the **Routine Planner** entry in the **ADDONS** section of the Dashboard left panel
  - This will open the **Routine Planner** configuration and management pane
- Click the **Configure** button of the attached bot
  - This will bring up the configuration panel for your **Routine Planner** attached bot

#### Global Settings

Routines can operate either as time-based scheduled execution or keyword based activation.
The **Operation Mode** of a routine can be configured in the **Global Settings** tab of the
Routine Planner configuration panel:

- Click the **Global Settings** tab of the **Overview    Global Settings    Routines    Statistics** tabs
- Select the **Operation Mode**, either **Scheduled Mode** or **Trigger Mode**
- Configure the **Home Position** (optional)
- If Trigger Mode is selected configure **Trigger Mode Settings**
- If changes were made click the **Save Settings** button

**[NOTE:]** If **Trigger Mode** is configured in Global Settings then you cannot switch back
to **Schedule Mode** in Global Settings until all Trigger Mode routines are deleted.

#### First Routine

You are now ready to create your first routine:

- Click the **Routines** tab of the **Overview    Global Settings    Routines    Statistics** tabs
- Click the **Create Routine** button of the attached bot
  - This will open the **Create New Routine** window
- **Basic Information**
  - Enter the **Basic Information** for the routine - a routine name, description, and optionally a start position
  - Click the **Next** button
    - Depending on the **Operation Mode** selected in Global Settings, this will open Trigger or Schedule configuration
- **Triggers**
  - If Trigger Mode was selected in Global Settings then you will see the Trigger Configuration
    - Enter keywords or phrases that will trigger this routine
    - Click the Plus Sign (+) button to add the keyword/phrase trigger. Add up to 20 triggers.
  - Optionally configure **Cooldown Settings**
  - Click the **Next** button
- **Completion**
  - Click the **Completion Behavior** dropdown and select which behavior should happen when this routine finishes
  - Select between **Goto Idle**, **Stop**, **Loop**, **Switch**, or **Random**
  - Click the **Next** button
    - This will bring up the **Waypoints** configuration
- **Waypoints Configuration**
  - Click the **Add Waypoint** button
  - Choose the **Waypoint Type** for this waypoint by clicking on its tile
    - This will open the **Add Waypoint** window for this Waypoint Type
    - Some Waypoint Types require additional settings, some do not
  - Configure any additional settings required by the selected Waypoint Type
  - Click **Add Waypoint** at the bottom right of the Add Waypoint window
  - Add More Waypoints
    - Click the **Add Waypoint** button
    - Repeat these steps for each new Waypoint you wish to add for this routine
- **Create Routine**
  - Click the **Create Routine** button when all Waypoints for this routine have been added

You have now created your first Routine and should be returned to the **Routine Planner** window
for your attached bot. Here you will see your configured routines, their name/description,
and icons to the right of the routine for disabling the routine, running it, editing the routine,
editing the waypoints, and more.
