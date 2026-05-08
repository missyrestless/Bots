# LIST_GROUPS_NAME

Returns a list of all groups the bot is a member of filtered by group name.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | group name filter string  |
| id       | yes      | ---                       |

## Example

```lsl
llMessageLinked(LINK_SET, LIST_GROUPS_NAME "VIP", "");
```
