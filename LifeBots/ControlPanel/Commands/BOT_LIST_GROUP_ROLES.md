# BOT_LIST_GROUP_ROLES

Retrieves a list of all the role names and uuid's for a group which the bot is a member of.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | uuid of group to retrieve a list of roles |

## Result

The following event will be raised with the list of the bots group roles

- [BOT_LIST_GROUP_ROLES_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_LIST_GROUP_ROLES_REPLY.md)

## Example

```lsl
llMessageLinked(LINK_SET, BOT_LIST_GROUP_ROLES, "", "0b65a122-8f77-64fe-5b2a-225d4c490d9c");
```
