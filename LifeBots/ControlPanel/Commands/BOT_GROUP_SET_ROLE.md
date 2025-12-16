# BOT_GROUP_SET_ROLE

Commands bot to add a group member to the specified role.

**[Note:]** The avatar must already be in the group for this command to work.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | UUID of group and the new role in the followeing format: "groupUUID,roleUUID" |
| id       | yes      | UUID of resident to add to role |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_GROUP_SET_ROLE, "uuid-of-group" + "," + "uuid-of-role", "uuid-of-person-you-are-adding-to-the-role");
```
