# BOT_GIVE_MONEY_OBJECT

Commands bot to give money to specified object UUID

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | L$ amount                 |
| id       | yes      | UUID of recipient object  |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_GIVE_MONEY_OBJECT, "1", "4c5f9ede-4126-b3ba-2809-d61b00d8b500");
```
