# SIM_RETURN_SCRIPTED_OBJECTS

Returns scripted objects owned by specified avatar or all scripted objects in the simulator.

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

Return all scripted objects in the Sim

```lsl
llMessageLinked(LINK_SET, SIM_RETURN_SCRIPTED_OBJECTS, "", "");
```

Return all scripted objects in the Sim owned by the specified Avatar UUID

```lsl
llMessageLinked(LINK_SET, SIM_RETURN_SCRIPTED_OBJECTS, "", "a2e76fcd-9360-4f6d-a924-000000000000");
```
