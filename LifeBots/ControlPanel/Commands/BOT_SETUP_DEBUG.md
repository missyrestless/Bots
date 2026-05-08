# BOT_SETUP_DEBUG

Enables or disables debug mode.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | 0 - to disable debug<br>1 - enable debug |
| id       | yes      | --                        |

## Comments

With debug on, LifeBots Control Panel starts sending debugging messages to local chat `DEBUG_CHANNEL`.
This can be used to trace the commands and LifeBots Control Panel status during the development process.

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SETUP_DEBUG, "1", NULL_KEY);
```
