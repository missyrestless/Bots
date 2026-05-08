# BOT_GROUP_JOIN

Commands bot to join the specified group

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | UUID of group to join     |

## Comments

The group must have open enrollment enabled for the bot to join the group successfully

## Example

```lsl
llMessageLinked(LINK_SET, BOT_GROUP_JOIN, "", "group-uuid");
```
