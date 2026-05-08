# BOT_SAY_CHAT

Commands bot to say a message on the specified channel

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | message to send           |
| id       | yes      | channel to say message on |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SAY_CHAT, "Sending this to local chat", "0");
```
