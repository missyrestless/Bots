# AVATAR_DISPLAY_NAME

Retrieves the display name for an avatar UUID.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | ---                       |
| id       | yes      | Avatar UUID               |

## Example

```lsl
llMessageLinked(LINK_SET, AVATAR_DISPLAY_NAME, "", "3506213c-29c8-4aa1-a38f-e12f6d41b804");
```
