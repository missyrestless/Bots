# BOT_LIST_GROUPS

Retrieves a list of all the groups the bot is in

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | --                        |

## Result

The following event will be raised with the list of the bots groups:

- [BOT_LIST_GROUPS_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_LIST_GROUPS_REPLY.md)

## Example

```lsl
llMessageLinked(LINK_SET, BOT_LIST_GROUPS, "", "");
```
