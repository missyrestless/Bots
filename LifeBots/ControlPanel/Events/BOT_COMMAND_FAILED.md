# BOT_COMMAND_FAILED

Raised when command error occurs.

## Reference

This event comes with the following event object properties:

| Variable | Description |
|:-------- |:----------- |
| str      | first line - command status code<br>second line - text explanation |
| id       | ---         |

## Example

```lsl
link_message(integer sender,integer num, string str, key id) {
  /////////////////// Bot command failed event
  if(num==BOT_COMMAND_FAILED) {
    // We split the string parameter to the lines
    list parts=llParseString2List(str,["\n"],[]);

    // The first line is a status code, and second line is the reason
    string code=llList2String(parts,0);
    string explain=llList2String(parts,1);

    // Inform user
    llOwnerSay("TotalControl bot command failed:\n"+
      "error code: "+code+"\n"+
      "explanation: "+explain);
  }
}
```
