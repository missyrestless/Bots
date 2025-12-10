# How to Setup Login Location and Sit Object

**LifeBots** bots (Lite & Full types) can be configured to login to a specified
location and, after successful login, sit on a specified object. This article
describes the steps to configure a **LifeBots** bot to login to Second Life at
a specific location and sit on an object.

## Login Location

To configure the bot's login location:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Click on the bot you wish to configure
  - This will open a **Manage Bot** panel for the bot
- Click on the **Location Config** pane
  - This will open a **Login Location Settings** window
- Click the **Login To** dropdown to **Select Location**
  - A dropdown menu will appear with locations to select from
- Click on **Last Location**, **Home Location**, or **Base Location** to select a login location
  - Selecting **Last Location** will use the last location of the bot as the login location
  - Selecting **Home Location** will use the configured **Home** of the bot as the login location
  - Selecting **Base Location** will add a **Base Location** field in which you can enter a Slurl
- Click the **Save** button in the bottom right corner of the window to save your bot's login location

### Last Location Setup

Selecting **Last Location** from the **Login To** dropdown menu will cause your bot
to login to its last known location in Second Life. If the bot moves or teleports while
logged in then the next login will use the new location.

### Home Location Setup

Selecting **Home Location** from the **Login To** dropdown menu will cause your bot
to login to its configured **Home** location in Second Life. Subsequent logins will
always use the same login location regardless of bot movement. To change the bot's
login location with this setting you must reconfigure the bot's **Home** location.

### Base Location Setup

If you select **Base Location** from the **Login To** dropdown menu, a **Base Location**
field is added to the **Login Location Settings** window. Enter a valid Second Life
Slurl of the form **http://maps.secondlife.com/secondlife/Region_Name/X/Y/Z** in the
**Base Location** field. Replace **Region_Name** with the name of the region where you
want your bot to login and replace the **X/Y/Z** with the coordinates in that region.
For example, a valid Second Life Slurl is **http://maps.secondlife.com/secondlife/Goa/18/45/3599**

**[Note:]** Your bot must have access to the location configured in the **Base Location**
field. If your bot does not have access to this location then it will be teleported to
another location.

## Sit On Object

Your bot can be configured to sit on a specified object after logging into Second Life.
The steps are similar to those described above for the bot's login location and can be
performed at the same time as the login location is configured.

To configure the object to sit on:

- Visit your **LifeBots Dashboard** at [https://lifebots.cloud/dashboard](https://lifebots.cloud/dashboard)
- Click on the bot you wish to configure
  - This will open a **Manage Bot** panel for the bot
- Click on the **Location Config** pane
  - This will open a **Login Location Settings** window
- Enter an **Object UUID** in the **Sit On Object** field
  - In your Second Life viewer, right click the object you want your bot to sit on
  - Select **Edit**
  - In the **General** tab click the **Copy Keys** button
  - Paste the copied UUID into the **Sit On Object** field
- Click the **Save** button in the bottom right corner of the window to save your bot's login location

**[Note:]** The object to sit on must be within range of the bot's login location.
You cannot specify a sit on object that is in another region or one that cannot be
accessed from the bot's login location.

## Return to Login Location

Near the bottom of the **Login Location Settings** window is an
**Always return to Login Location?** field. This can be used to force the bot to
return to its configured login location after completing all activities.

To configure this option click the **Select Option** dropdown and select either
**Yes** or **No**. Click the **Save** button in the bottom right corner of the
window to save your bot's return to login location configuration.
