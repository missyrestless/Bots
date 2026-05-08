# BOT_EVENT_LISTEN_IM

Raised when Bot receives an instant message

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | speakername: message |
| id       | UUID of sender       |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot IM event
    if(num==BOT_EVENT_LISTEN_IM) {
    	llOwnerSay("IM from bot: " + str);
    }
}
```
