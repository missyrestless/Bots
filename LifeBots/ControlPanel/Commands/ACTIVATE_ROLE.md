# ACTIVATE_ROLE

Commands bot to activate the specified role

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | UUID of role to activate  |
| id       | yes      | UUID of group             |

## Example

```lsl
llMessageLinked(LINK_SET, ACTIVATE_ROLE, "role-uuid", "group-uuid");
```
