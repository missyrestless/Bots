# BOT_LIST_GROUPS_REPLY

Raised when Bot receives list of groups

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | List of groups in the format "uuid;name \n uuid;name...." |
| id       | ---         |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot list group reply event
    if(num==BOT_LIST_GROUPS_REPLY) {
        // Parse each group separated by a new line "\n"
        list groups = llParseString2List(str, ["\n"], []);
        integer count;

        // Parse each uuid name combo separated by a ";"
        for(count =0; count < llGetListLength(groups); count++) {
            list groupDetails= llParseString2List(llList2String(groups, count), [";"], []);
            llOwnerSay("UUID: " + llList2String(groupDetails, 0));
            llOwnerSay("Name: " + llList2String(groupDetails, 1));
        }
    }
}
```
