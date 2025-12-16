# BOT_SAY_GROUP_CHAT

Commands bot to send a message to the specified group

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | message to send           |
| id       | yes      | UUID of group to send message to |

## Comments

For this command to work the bot must:

- Be a member of the group
- Have permission to join group chat

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SAY_GROUP_CHAT, "Sending this to a group", "group-uuid");
```
