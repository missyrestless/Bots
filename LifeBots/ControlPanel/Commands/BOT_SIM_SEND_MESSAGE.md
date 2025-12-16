# BOT_SIM_SEND_MESSAGE

Send a message to all avatars in a region. The bot must be an estate manager.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | message to send           |
| id       | yes      | --                        |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SIM_SEND_MESSAGE, "Sending this to all avatars in the region", "");
```
