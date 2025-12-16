# LifeBots Control Panel Events

`LifeBots Control Panel` library raises events to inform your script about errors,
chat IMs and other events that have occurred. To catch these events, use the LSL
`link_message` event.

## Parsing Events

LSL `link_message` event has the following syntax:

```lsl
link_message(integer sender_num, integer num, string str, key id) { ... }
```

For `LifeBots Control Panel`, **num** will contain the event code (see below).

**str** and **id** values depend on the event.

## Events List

The following events can be raised by the Control Panel:

| Command | Description |
|:------- |:----------- |
| **Status**  |             |
| [BOT_SETUP_SUCCESS](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_SETUP_SUCCESS.md) | Raised when Bot has been set successfully |
| [BOT_SETUP_FAILED](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_SETUP_FAILED.md) | Raised when there was an error setting the bot |
| [BOT_COMMAND_FAILED](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_COMMAND_FAILED.md) | Raised when command error occurs |
| [BOT_EVENT_STATUS_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_EVENT_STATUS_REPLY.md) | Raised when bot status is received |
| **Listeners**  |             |
| [BOT_EVENT_LISTEN_SUCCESS](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_EVENT_LISTEN_SUCCESS.md) | Raised when a listener has successfully been established |
| [BOT_EVENT_LISTEN_LOCAL_CHAT](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_EVENT_LISTEN_LOCAL_CHAT.md) | Raised when Bot sees a message in local chat |
| [BOT_EVENT_LISTEN_IM](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_EVENT_LISTEN_IM.md) | Raised when Bot receives an instant message |
| [BOT_EVENT_LISTEN_INVENTORY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_EVENT_LISTEN_INVENTORY.md) | Raised when Bot receives an inventory item |
| [BOT_EVENT_LISTEN_MONEY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_EVENT_LISTEN_MONEY.md) | Raised when Bot receives a payment |
| [BOT_EVENT_LISTEN_DIALOG](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_EVENT_LISTEN_DIALOG.md) | Raised when Bot receives a dialog menu |
| **Request Responses**  |             |
| [BOT_LIST_GROUPS_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_LIST_GROUPS_REPLY.md) | Raised when Bot receives list of groups |
| [BOT_LIST_GROUP_ROLES_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_LIST_GROUP_ROLES_REPLY.md) | Raised when Bot receives list of roles for a group |
| [BOT_GET_BALANCE_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_GET_BALANCE_REPLY.md) | Raised when balance is successfully requested |
| [BOT_ATTACHMENTS_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_ATTACHMENTS_REPLY.md) | Raised when Bot receives list of attachments |
| [BOT_LOCATION_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_LOCATION_REPLY.md) | Raised when bot returns its location |
| [BOT_NOTECARD_CREATE_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_NOTECARD_CREATE_REPLY.md) | Raised when balance is successfully requested |
| [BOT_NOTECARD_READ_REPLY](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Events/BOT_NOTECARD_READ_REPLY.md) | Raised when when balance is successfully requested |
