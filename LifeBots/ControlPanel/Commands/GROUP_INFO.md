# GROUP_INFO

Commands bot to retrieve the specified group's info

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | ---                       |
| id       | yes      | UUID of group             |

## Example

```lsl
llMessageLinked(LINK_SET, GROUP_INFO, "", "group-uuid");
```
