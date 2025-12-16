# GROUP_OFFER_DECLINE

Responds to a group invitation by declining it.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | UUID of avatar that sent the invitation |
| id       | yes      | Session ID of invitation                |

## Example

```lsl
llMessageLinked(LINK_SET, GROUP_OFFER_DECLINE, "avatar-uuid", "session-id");
```
