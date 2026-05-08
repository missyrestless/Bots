# BOT_SETUP_SETOPTIONS

Sets various options for LifeBots Control Panel.

```lsl
llMessageLinked(LINK_SET, BOT_SETUP_SETOPTIONS, "NO_OWNERCHANGE_RESET", NULL_KEY);
```

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | options list, separated by commas. See the available options below. |
| id       | yes      | --                        |

## Available Options

The following options are currently available:

- NO_OWNERCHANGE_RESET - LifeBots Control Panel does not reset itself on object owner change

## Example

```lsl
integer BOT_SETUP_SETOPTIONS = 280104;

default
{
	state_entry()
	{
		llMessageLinked(LINK_SET, BOT_SETUP_SETOPTIONS, "NO_OWNERCHANGE_RESET", NULL_KEY);
	}
}
```
