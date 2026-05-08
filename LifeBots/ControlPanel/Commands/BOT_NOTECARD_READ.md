# BOT_NOTECARD_READ

Returns the contents of a notecard for the given UUID

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | UUID of the notecard to read |

## Result

Raises the following event:

- [BOT_NOTECARD_READ_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_NOTECARD_READ_REPLY.md)

## Example

```lsl
llMessageLinked(LINK_SET, BOT_NOTECARD_READ, "", "f7f22046-d5d5-54f6-03a3-8a1836efedad");
```
