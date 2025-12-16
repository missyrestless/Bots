# LIST_GROUPS_UUID

Returns a list of all groups the bot is a member of filtered by group UUID.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | ---                       |
| id       | yes      | Limit group UUID          |

## Example

```lsl
llMessageLinked(LINK_SET, LIST_GROUPS_UUID, "", "limit-group-uuid");
```
