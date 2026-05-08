# BOT_LOGIN

Initiates bot login process.

```lsl
llMessageLinked(LINK_SET, BOT_LOGIN, "", "");
```

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | --                        |

## Example

```lsl
integer BOT_SETUP_SETBOT = 280101;
integer BOT_LOGIN = 280111;

integer READY = FALSE;

string name = "LifeBots Resident";
string accesscode = "e6abcd5fab9";

default
{
	state_entry()
	{
		llMessageLinked(LINK_SET,BOT_SETUP_SETBOT,name,accesscode);
	}

	touch_start(integer total_number)
	{
		if (READY) {
			llMessageLinked(LINK_SET,BOT_LOGIN,"","");
			llOwnerSay("The bot will now initiate the login process.");
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
		}
	}
}
```
