# BOT_NOTECARD_READ_REPLY

Raised when when balance is successfully requested

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | the contents of the notecard |
| id       | ---         |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    if(num==BOT_NOTECARD_READ_REPLY) {
    	llOwnerSay("The contents of the notecard is: " + str);
    }
}
```
