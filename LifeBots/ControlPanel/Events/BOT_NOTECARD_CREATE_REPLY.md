# BOT_NOTECARD_CREATE_REPLY

Raised when balance is successfully requested

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | ---         |
| id       | UUID of newly created notecard |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    if(num==BOT_NOTECARD_CREATE_REPLY) {
    	llOwnerSay("UUID of new notecard is " + (string)id);
    }
}
```
