# BOT_STATUS_QUERY

Queries the selected bot status (useful to determine the subscription length).
Result is being returned using `BOT_EVENT_STATUS_REPLY` event.

```lsl
llMessageLinked(LINK_SET,BOT_STATUS_QUERY,"","");
```

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | --                        |

## Return value

The result of this command will be returned to your script using `BOT_EVENT_STATUS_REPLY` event:

```lsl
link_message( integer sender, integer num, string str, key id )
```
| Argument     | Description             |
|:------------ |:----------------------- |
| sender       | link number of a sender prim |
| num          | BOT_EVENT_STATUS_REPLY       |
| str          | String representing the bot's status:<br>&bull;first line - bot status code<br>&bull;second line - bot expiration date<br>&bull;third line - bot online status<br><br>Online statuses:<br>&bull;ONLINE - Bot is online<br>&bull;LOGGED OUT - Bot was logged out by gracefully<br>&bull;CONNECTING - The bot is logging in<br>&bull;OFFLINE - Bot is expired or has an error<br><br>Example:<br><br>OK<br>2019-03-10 00:00<br>LOGGED OUT |
| id        | Bot UUID    |

## Example

```lsl
integer BOT_SETUP_SETBOT = 280101;
integer BOT_STATUS_QUERY = 280106;

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
			llMessageLinked(LINK_SET,BOT_STATUS_QUERY,"","");
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
		} else if(cmd == BOT_EVENT_STATUS_REPLY ) {
			llOwnerSay("Status: data = " + data + "\nkey= " + id);
		}
	}
}
```
