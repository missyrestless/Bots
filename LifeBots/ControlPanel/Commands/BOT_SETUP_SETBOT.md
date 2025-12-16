# BOT_SETUP_SETBOT

Sets the working personal Bot. Other commands require this command to be invoked first.

```lsl
llMessageLinked(LINK_SET,BOT_SETUP_SETBOT,"My bot name","ACCESS CODE");
```

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | Name of the Bot           |
| id       | yes      | Access Code               |

## Result

One of the following events will be generated:

- [BOT_SETUP_SUCCESS](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_SETUP_SUCCESS.md)
- [BOT_SETUP_FAILED](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_SETUP_FAILED.md)

## Example

```lsl
integer BOT_SETUP_SETBOT = 280101;

string name = "LifeBots Resident";
string accesscode = "f7dheb7fba9";

default
{
	state_entry()
	{
		llMessageLinked(LINK_SET,BOT_SETUP_SETBOT,name,accesscode);
	}
	link_message(integer sender, integer cmd, string data, key idk) {
		string id = (string)idk;
		if(cmd == BOT_SETUP_SUCCESS) {
			llOwnerSay("Setup Success: data=" + data + "\nkey= " + id);
		} else if(cmd == BOT_SETUP_FAILED ) {
			llOwnerSay("Setup Failed: data=" + data + "\nkey= " + id);
		}
	}
}
```
