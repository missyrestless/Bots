# BOT_EVENT_LISTEN_DIALOG

Raised when Bot receives a dialog menu

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | Dialog details in the format "channel\nObjectName\nOwnerName\nDialogMsg\nButtons" |
| id       | UUID of object that sent dialog |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot listen dialog event
    if(num==BOT_EVENT_LISTEN_DIALOG) {
        // Split details with a newline "\n"
        list details = llParseString2List(str, ["\n"], []);
    	llOwnerSay("Channel: " + llList2String(details,0));
    	llOwnerSay("Object Name: " + llList2String(details,1));
    	llOwnerSay("Owner Name: " + llList2String(details,2));
    	llOwnerSay("Dialog Message: " + llList2String(details,3));
    	llOwnerSay("Buttons: " + llList2String(details,4));
    	llOwnerSay("Object UUID: " + (string)id);
    }
}
```
