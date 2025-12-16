# BOT_OFFER_TELEPORT

Commands bot send a teleport offer to the specified avatar UUID

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | a message to send with the teleport offer |
| id       | yes      | UUID of avatar to send teleport offer to |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_OFFER_TELEPORT, "Do you want to join me?", "d11fa786-c342-4785-8e1b-ac70a17a9aac");
```
