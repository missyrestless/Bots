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
| BOT_SETUP_SUCCESS | Raised when Bot has been set successfully |
| BOT_SETUP_FAILED | Raised when there was an error setting the bot |
| BOT_COMMAND_FAILED | Raised when command error occurs |
| BOT_EVENT_STATUS_REPLY | Raised when bot status is received |
| **Listeners**  |             |
| BOT_EVENT_LISTEN_SUCCESS | Raised when a listener has successfully been established |
| BOT_EVENT_LISTEN_LOCAL_CHAT | Raised when Bot sees a message in local chat |
| BOT_EVENT_LISTEN_IM | Raised when Bot receives an instant message |
| BOT_EVENT_LISTEN_INVENTORY | Raised when Bot receives an inventory item |
| BOT_EVENT_LISTEN_MONEY | Raised when Bot receives a payment |
| BOT_EVENT_LISTEN_DIALOG | Raised when Bot receives a dialog menu |
| **Request Responses**  |             |
| BOT_LIST_GROUPS_REPLY | Raised when Bot receives list of groups |
| BOT_LIST_GROUP_ROLES_REPLY | Raised when Bot receives list of roles for a group |
| BOT_GET_BALANCE_REPLY | Raised when balance is successfully requested |
| BOT_ATTACHMENTS_REPLY | Raised when Bot receives list of attachments |
| BOT_LOCATION_REPLY | Raised when bot returns its location |
| BOT_NOTECARD_CREATE_REPLY | Raised when balance is successfully requested |
| BOT_NOTECARD_READ_REPLY | Raised when when balance is successfully requested |
