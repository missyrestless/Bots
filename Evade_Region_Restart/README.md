# Evade Region Restart

This is an example of how one could automate Corrade such that it evades region restarts in order to not be disconnected once the region goes down. The script monitors the region's alert messages and detects when a region restart is scheduled. Once a region restart is scheduled, the script attempts to teleport Corrade out of the way and then waits (in a suspended state) till the region comes back up. When the region is back up, the script teleports Corrade back to a configurable home position.

This is available for L$0 on the SL Marketplace at https://marketplace.secondlife.com/p/WaS-Corrade-Region-Restart-Evader/8323879

## Requirements

The script requires that for the configured group, the following permissions to be enabled:

- movement (for teleporting)
- notifications (for the alert notification)

and the following notifications enabled:

- alert (for sensing region restarts)

## Configuration

The script needs a notecard named configuration to be placed in the same primitive as the script itself. A sample configuration notecard could consist of the following:

```
############################# START CONFIGURATION ############################
 
# This is a configuration notecard based on the key-value data Wizardry and Steamworks reader. 
# Everything following the "#" character is ignored along with blank lines. Values can be set for various 
# parameters in a simple and understandable format with the following syntax: 
# KEY = "VALUE" 
# Every time you change this configuration notecard, the script will reset itself and the new configuration 
# will be read from this notecard.
 
# The "corrade", "group" and "password" settings must correspond to your settings in Corrade.ini
 
# This is the UUID of the Corrade bot.
corrade = "a87202c7-1b95-4d56-b099-53b6cb1517f2"
 
# The name of the group - it can also be the UUID of the group.
group = "My Group"
 
# The password for the group.
password = "mypassword"
 
# A CSV list of region names to escape to in case of a region restart.
# For example's sake, this example lists several infohubs that may be safe during a region restart.
regions = "Tahoe Springs,Castle Valeria,Barbarossa,Calleta"
 
# The name of the home region where Corrade will be teleported back after a region restart.
home = "Puguet Sound"
# The position on the home region to teleport back to as a local 3-vector.
position = "<130.588501, 169.906158, 3402.433838>"
 
############################# END CONFIGURATION #############################
```

The configuration notecard must be changed accordingly to reflect the settings made for Corrade and then it must be placed alongside the script in a primitive.

## Limitations

In case Corrade evades and teleports to a region that also has a pending restart, in case the script is placed on the first restarted region, then the script will be suspended and unable to make Corrade evade again. In such cases, it is preferrable to create a different script - perhaps attached to the bot's attachments that will be sure to run even after Corrade has teleported.
