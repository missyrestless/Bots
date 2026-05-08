# BOT_LISTEN_DIALOG

Commands bot to send dialog requests to the script

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | --                        |

## Result

One of the following events will be generated:

- [BOT_EVENT_LISTEN_SUCCESS](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_EVENT_LISTEN_SUCCESS.md)
- [BOT_COMMAND_FAILED](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_COMMAND_FAILED.md)

Additionally the following events get generated every time the bot receives a dialog menu:

- [BOT_EVENT_LISTEN_DIALOG](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_EVENT_LISTEN_DIALOG.md)

## Example

```lsl
llMessageLinked(LINK_SET, BOT_LISTEN_DIALOG, "", "");
```
