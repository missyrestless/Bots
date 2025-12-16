# BOT_LOCATION_REPLY

Raised when bot returns its location

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | coordinates in the format "region\nX\nY\nZ" |
| id       | ---         |

## Example

```lsl
integer BOT_SETUP_SETBOT = 280101;
integer BOT_LOCATION = 290232;
integer BOT_LOCATION_REPLY = 290233;

integer READY = FALSE;

string name = "LifeBots Resident";
string accesscode = "f7dheb7fba9";

default
{
	state_entry()
	{
		llMessageLinked(LINK_SET,BOT_SETUP_SETBOT,name,accesscode);
	}

	touch_start(integer total_number)
	{
		if (READY) {
			llMessageLinked(LINK_SET,BOT_LOCATION,"","");
			llOwnerSay("Requesting the bot's location.");
		} else {
			llOwnerSay("The bot is not ready. If you received a Setup Failed message then please check your access code is correct, otherwise please try again in a moment.");
		}
	}

	link_message(integer sender, integer cmd, string data, key idk) {
		string id = (string)idk;
		if(cmd == BOT_SETUP_SUCCESS) {
			READY = TRUE;
			llOwnerSay("Setup Success: data=" + data + "\nkey= " + id);
		} else if(cmd == BOT_SETUP_FAILED ) {
			READY = FALSE;
			llOwnerSay("Setup Failed: data=" + data + "\nkey= " + id);
		} else if(num==BOT_LOCATION_REPLY) {
			list location = llParseString2List(data, ["\n"], []);
			llOwnerSay("Bot ("+name+") is at: secondlife://" + llList2String(location, 0) + "/" + llList2String(location, 1) + "/" + llList2String(location, 2) + "/" + llList2String(location, 3));
		}
	}
}
```
