# BOT_EVENT_LISTEN_LOCAL_CHAT

Raised when Bot sees a message in local chat

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | speaker name: message |
| id       | UUID of  speaker      |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot listen local chat event
    if(num==BOT_EVENT_LISTEN_LOCAL_CHAT) {
    	llOwnerSay("Local chat from bot: " + str);
    }
}
```
