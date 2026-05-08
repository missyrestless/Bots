# BOT_SETUP_DEVICENAME

Sets the device name and device creator for your statistics purposes (you will be able to see who is using your device).

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | device name (given by the creator) |
| id       | yes      | creator avatar's UUID     |

## Comments

This command is to set the device name for your statistics purposes (you will be able to see who is using your device).

The list of devices is being displayed in "Developer" menu at LifeBots account.

- We advise putting the version number along with the device name. This will allow you to see all residents using old and outdated devices, and contact them.
- The author's UUID is required to show all active devices to the author.

## Example

```lsl
integer BOT_SETUP_DEVICENAME = 280103;

default
{
	state_entry()
	{
		string deviceName="My Device v1.0";
		key creator=llGetCreator();
		llMessageLinked(LINK_SET, BOT_SETUP_DEVICENAME, deviceName, creator);
	}
}
```
