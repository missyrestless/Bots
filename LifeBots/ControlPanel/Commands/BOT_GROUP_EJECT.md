# BOT_GROUP_EJECT

Commands bot to eject a resident from a group

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | UUID of avatar to eject   |
| id       | yes      | UUID of group to eject from |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_GROUP_EJECT, "uuid of avatar", "uuid of group");
```
