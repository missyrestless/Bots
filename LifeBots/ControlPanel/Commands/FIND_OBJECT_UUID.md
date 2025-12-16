# FIND_OBJECT_UUID

Searches for object with specified UUID.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | ---                       |
| id       | yes      | Object UUID               |

## Example

```lsl
llMessageLinked(LINK_SET, FIND_OBJECT_UUID, "", "object-uuid");
```
