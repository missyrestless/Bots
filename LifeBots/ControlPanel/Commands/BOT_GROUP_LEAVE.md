# BOT_GROUP_LEAVE

Commands bot to leave the specified group

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | UUID of group to leave    |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_GROUP_LEAVE, "", "uuid-of-group");
```
