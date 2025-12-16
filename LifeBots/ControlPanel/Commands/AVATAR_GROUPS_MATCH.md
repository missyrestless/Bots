# AVATAR_GROUPS_MATCH

Returns a list of groups an avatar belongs to filtered by a matching name pattern.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | Only return group names that match this filter |
| id       | yes      | Avatar UUID               |

## Example

```lsl
llMessageLinked(LINK_SET, AVATAR_GROUPS_MATCH, "Truth", "3506213c-29c8-4aa1-a38f-e12f6d41b804");
```
