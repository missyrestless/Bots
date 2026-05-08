# TAKE_DELETE_OBJECT

Takes an object into inventory or deletes it. Bot must have permissions.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | Operation: "take" or "delete" |
| id       | yes      | In-world object UUID      |

## Example

```lsl
llMessageLinked(LINK_SET, TAKE_DELETE_OBJECT, "delete", "in-world-object-uuid");
```
