# UUID_TO_NAME

Looks up an avatar's name from their UUID. Returns the display name.

Optionally, the case of the returned name can be specified.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | Return exact case "1" or lowercase "0" (default: lowercase) |
| id       | yes      | Avatar UUID               |

## Example

```lsl
llMessageLinked(LINK_SET, UUID_TO_NAME, "", "3506213c-29c8-4aa1-a38f-e12f6d41b804");
```
