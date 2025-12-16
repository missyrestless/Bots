# BOT_RESET_CONTROLPANEL

Invokes `llResetScript()` for `LifeBotsControlPanel` script.

```lsl
llMessageLinked(LINK_SET, BOT_RESET_CONTROLPANEL, "", NULL_KEY);
```

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | --                        |

## Comments

The command completely resets the `LifeBotsControlPanel` script (for example, on
object owner change). Invokes `llResetScript()` for `LifeBotsControlPanel` script.
Don't forget to issue `BOT_SETUP_SETBOT` afterwards.

## Example

```lsl
integer BOT_RESET_CONTROLPANEL = 9997770;

default
{
	on_rez(integer param)
	{
		llMessageLinked(LINK_SET, BOT_RESET_CONTROLPANEL, "", NULL_KEY);
	}
}
```
