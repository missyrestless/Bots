# BOT_EVENT_STATUS_REPLY

Raised when bot status is received.

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | first line - command status code<br>second line - bot expiration date |
| id       | ---         |

## Example

```lsl
link_message(integer sender,integer cmd, string data, key id) {
  /////////////////// Bot status event
  if(cmd==BOT_EVENT_STATUS_REPLY) {
    // We split the string parameter to the lines
    list parts=llParseString2List(data,["\n"],[]);

    // The first line is a status code, and second line is the bot expiration date
    string code=llList2String(parts,0);
    string date=llList2String(parts,1);

    // Inform user
    llOwnerSay("Bot status received:\n"+
      "status code: "+code+"\n"+
      "expiration date: "+date);
  }
}
```
