# BOT_LIST_GROUP_ROLES_REPLY

Raised when Bot receives list of roles for a group

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | List of roles in the format "uuid;name \n uuid;name...." |
| id       | ---         |

## Example

```lsl
link_message( integer sender_num, integer num, string str, key id ) {
    /////////////////// Bot list group reply event
    if(num==BOT_LIST_GROUP_ROLES_REPLY) {
        // Parse each group separated by a new line "\n"
        list roles = llParseString2List(str, ["\n"], []);
        integer count;

        // Parse each uuid name combo separated by a ";"
        for(count =0; count < llGetListLength(roles); count++) {
            list roleDetails= llParseString2List(llList2String(roles, count), [";"], []);
            llOwnerSay("UUID: " + llList2String(roleDetails, 0));
            llOwnerSay("Name: " + llList2String(roleDetails, 1));
        }
    }
}
```
