# SIM_RETURN_OTHERS_OBJECTS

Returns objects not owned by specified avatar.

Optionally, can be applied to all estates.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | optional | "all_estates" indicates apply to all estates |
| id       | yes      | Avatar UUID               |

## Comment

The bot must have estate privileges to perform this task.

## Example

Return all objects in the Sim not owned by the specified Avatar UUID

```lsl
llMessageLinked(LINK_SET, SIM_RETURN_OTHERS_OBJECTS, "", "a2e76fcd-9360-4f6d-a924-000000000000");
```
