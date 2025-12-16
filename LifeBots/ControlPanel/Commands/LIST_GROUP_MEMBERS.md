# LIST_GROUP_MEMBERS

Retrieves a list of all members of the specified group with their roles and information.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | ---                       |
| id       | yes      | UUID of group             |

## Example

```lsl
llMessageLinked(LINK_SET, LIST_GROUP_MEMBERS "", "group-uuid");
```
