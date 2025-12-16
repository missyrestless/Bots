# BOT_UNFRIEND

Commands bot to unfriend to someone

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | UUID of person to unfriend |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_UNFRIEND, "", "uuid-of-avatar");
```
