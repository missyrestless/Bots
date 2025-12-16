# BOT_NOTECARD_CREATE

Commands bot to create a notecard in the inventory.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | name and notecard contents separated by a line break (name\ncontents here) |
| id       | yes      | uuid of a folder where the notecard will be stored, leave blank for Notecards folder |

## Comments

The name and contents of the notecard are being separated by a "\n" (see example below).

## Result

Raises the following event:

- [BOT_NOTECARD_CREATE_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_NOTECARD_CREATE_REPLY.md)

## Example

```lsl
llMessageLinked(LINK_SET, BOT_NOTECARD_CREATE, "Name\nBody of notecard", "fe7143cc-5cdf-f865-63cd-de98bafa0f70");
```
