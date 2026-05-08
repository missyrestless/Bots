# BOT_GIVE_MONEY

Commands bot to give money to specified UUID

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | L$ amount                 |
| id       | yes      | UUID of recipient avatar  |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_GIVE_MONEY, "1", "recipient-uuid");
```
