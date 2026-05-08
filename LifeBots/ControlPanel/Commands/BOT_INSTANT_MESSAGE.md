# BOT_INSTANT_MESSAGE

Commands bot to send an instant message to an avatar

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | message to send           |
| id       | yes      | name or uuid of avatar to send message to |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_INSTANT_MESSAGE, "Message text to send", "Recipient Avatar Name or UUID");
```
