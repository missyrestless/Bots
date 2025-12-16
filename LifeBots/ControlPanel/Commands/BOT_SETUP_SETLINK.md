# BOT_SETUP_SETLINK

Commands LifeBots Control Panel to use the specified link number for `llMessageLinked` calls instead of `LINK_SET`.

```lsl
llMessageLinked(LINK_SET, BOT_SETUP_SETLINK, "15", NULL_KEY);
```

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | new link number           |
| id       | yes      | --                        |

## Comments

This command is being used to optimize your device performance for high-prim objects.

LifeBots Control Panel sends events to `LINK_SET` by default. You can specify the exact
link number of the prim to optimize performance.

## Example

```lsl
integer BOT_SETUP_SETLINK = 280102;

default
{
	state_entry()
	{
		llMessageLinked(LINK_SET, BOT_SETUP_SETLINK, "15", NULL_KEY);
	}
}
```
