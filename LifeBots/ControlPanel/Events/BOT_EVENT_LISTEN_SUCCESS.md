# BOT_EVENT_LISTEN_SUCCESS

Raised when a listener has successfully been established

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | ---         |
| id       | ---         |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot listen event success
    if(num==BOT_EVENT_LISTEN_SUCCESS) {
        // Inform user
    	llOwnerSay("Listen succesful");
    }
}
```
