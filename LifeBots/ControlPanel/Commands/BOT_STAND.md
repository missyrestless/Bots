# BOT_STAND

Commands bot to stand up. If a permanent sit UUID is set then this command will clear it.

This is effective if the bot is sitting down or flying.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | --                        |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_STAND, "", "");
```
