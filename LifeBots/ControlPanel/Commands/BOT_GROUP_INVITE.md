# BOT_GROUP_INVITE

Commands bot to invite a resident to a group

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | UUID of group and role in the format: "groupUUID\nroleUUID" |
| id       | yes      | UUID of resident to invite  |

## Example

```lsl
// Invites specified resident to Everyone role
llMessageLinked(LINK_SET, BOT_GROUP_INVITE, "uuid-of-group" + "\n" + NULL_KEY, "uuid-of-person-you-are-inviting");
```
