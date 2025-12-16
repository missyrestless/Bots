# SIM_RETURN_OBJECTS

Returns objects owned by specified avatar or all objects in the simulator.

Optionally, can be applied to all estates.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | optional | "all_estates" indicates apply to all estates |
| id       | optional | Avatar UUID               |

## Comment

The bot must have estate privileges to perform this task.

## Example

Return all objects in the Sim

```lsl
llMessageLinked(LINK_SET, SIM_RETURN_OBJECTS, "", "");
```

Return all objects in the Sim owned by the specified Avatar UUID

```lsl
llMessageLinked(LINK_SET, SIM_RETURN_OBJECTS, "", "a2e76fcd-9360-4f6d-a924-000000000000");
```
