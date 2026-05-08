# BOT_OFFER_FRIENDSHIP

Commands bot to offer friendship to someone

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | message to send along with the friendship offer |
| id       | yes      | UUID of avatar to send friend request to |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_OFFER_FRIENDSHIP , "Please add me as a friend", "uuid-of-avatar");
```
