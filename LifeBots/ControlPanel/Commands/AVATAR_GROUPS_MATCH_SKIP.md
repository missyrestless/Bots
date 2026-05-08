# AVATAR_GROUPS_MATCH_SKIP

Returns a list of groups an avatar belongs to, matching and skipping those group names
that match the specified name pattern. The filter pattern is specified in the format:

"match filter\nskip filter"

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | Match and skip group names that match this filter. Filter string format is "match filter\nskip filter" |
| id       | yes      | Avatar UUID               |

## Example

```lsl
llMessageLinked(LINK_SET, AVATAR_GROUPS_MATCH_SKIP, "Truth\nNude", "3506213c-29c8-4aa1-a38f-e12f6d41b804");
```
