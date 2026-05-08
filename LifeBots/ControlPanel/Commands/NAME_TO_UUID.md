# NAME_TO_UUID

Looks up an avatar's UUID from their display name or username. Automatically handles "Resident" last names.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | Avatar display name or username |
| id       | yes      | ---                       |

## Example

```lsl
llMessageLinked(LINK_SET, NAME_TO_UUID, "Missy Restless", "");
```
