# GROUP_VISIBILITY

Controls whether the specified group is visible in the bot's profile.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | "0" indicates hide<br>"1" indicates show |
| id       | yes      | UUID of group             |

## Example

```lsl
llMessageLinked(LINK_SET, GROUP_VISIBILITY, "0", "group-uuid");
```
