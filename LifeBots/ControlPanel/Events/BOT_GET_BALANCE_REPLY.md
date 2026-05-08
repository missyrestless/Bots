# BOT_GET_BALANCE_REPLY

Raised when balance is successfully requested

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | amount      |
| id       | ---         |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    if(num==BOT_GET_BALANCE_REPLY) {
    	llOwnerSay("Bot balance is: L$" + str);
    }
}
```
