# BOT_GET_BALANCE

Requests the current L$ balance of the bot

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | --                        |

## Result

Raises the following event:

- [BOT_GET_BALANCE_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_GET_BALANCE_REPLY.md)

## Example

```lsl
llMessageLinked(LINK_SET, BOT_GET_BALANCE, "", "");
```
