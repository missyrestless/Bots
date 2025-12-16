# BOT_SETUP_FAILED

Raised when there was an error setting the bot (Bot does not exist, expired etc)

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | first line - Bot status code<br>second life - group expiration date |
| id       | ---         |

## Example

```lsl
link_message(integer sender,integer num, string str, key id) {
  /////////////////// Bot setup failed event
  if(num==BOT_SETUP_FAILED) {
    // We split the string parameter to the lines
    list parts=llParseString2List(str,["\n"],[]);

    // The first line is a status code, and second line is the bot expiration date
    string code=llList2String(parts,0);
    string expires=llList2String(parts,1);

    // Inform user
    llOwnerSay("Bot setup failed:\n"+
      "error code: "+code+"\n"+
      "expired: "+expires);
  }
}
```
