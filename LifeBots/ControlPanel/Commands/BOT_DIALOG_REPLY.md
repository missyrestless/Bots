# BOT_DIALOG_REPLY

Commands bot to reply to a dialog menu

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description                                                |
|:-------- |:-------- |:-------------------------                                  |
| str      | yes      | channel to reply on and button to select seperated by "\n" |
| id       | yes      | uuid of the object that gave the dialog menu               |

## Example

Select button 5 and reply on channel -123

```lsl
llMessageLinked(LINK_SET, BOT_DIALOG_REPLY, "-123\n5", "uuid-of-object");
```
