# BOT_EVENT_LISTEN_MONEY

Raised when Bot receives a payment

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | amount of L$ received |
| id       | UUID of person that sent money |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot listen money event
    if(num==BOT_EVENT_LISTEN_MONEY) {
    	llOwnerSay("Got L$" + str + " from " + (string)id);
    }
}
```
