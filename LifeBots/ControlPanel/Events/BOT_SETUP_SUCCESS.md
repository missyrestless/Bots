# BOT_SETUP_SUCCESS

Raised when Bot has been set successfully

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | The name of the Bot |
| id       | ---         |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot setup success event
    if(num==BOT_SETUP_SUCCESS) {
        // Inform user
    	llOwnerSay("Bot setup success:\n"+
        	"Bot name: "+str);
    }
}
```
