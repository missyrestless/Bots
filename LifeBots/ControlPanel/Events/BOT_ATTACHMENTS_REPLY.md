# BOT_ATTACHMENTS_REPLY

Raised when Bot receives list of attachments

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      |   List of attachments in the format "uuid name \n uuid name...." |
| id       |   ---       |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot attachments reply event
    if(num==BOT_ATTACHMENTS_REPLY) {
        // Parse each attachment separated by a new line "\n"
        list attachments = llParseString2List(str, ["\n"], []);

        // Parse each uuid name combo separated by a space
        for(integer count =0; count < llGetListLength(attachments); count++) {
            list subAttachment = llParseString2List(llList2String(attachments, count), [" "], []);
            llOwnerSay("UUID: " + llList2String(subAttachment, 0));
            llOwnerSay("Name: " + llList2String(subAttachment, 1));
        }
    }
}
```
