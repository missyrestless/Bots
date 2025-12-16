# BOT_EVENT_LISTEN_INVENTORY

Raised when Bot receives an inventory item

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | Object details in the format "name of sender;object uuid; object name" |
| id       | UUID of avatar that sent object       |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot listen inventory event
    if(num==BOT_EVENT_LISTEN_INVENTORY) {
        // Split details with a semi colon ";"
        list details = llParseString2List(str, [";"], []);
    	llOwnerSay("Sender name: " + llList2String(details,0));
    	llOwnerSay("Object UUID: " + llList2String(details,1));
    	llOwnerSay("Object Name: " + llList2String(details,2));
    	llOwnerSay("Sender UUID: " + (string)id);
    }
}
```
