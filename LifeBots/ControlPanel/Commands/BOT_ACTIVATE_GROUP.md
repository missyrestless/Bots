# BOT_ACTIVATE_GROUP

Commands bot to activate a group with specified group UUID

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | UUID of group to activate |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_ACTIVATE_GROUP, "", "f8e95201-20af-b85f-a682-7ac25ab9fcaf");
```
