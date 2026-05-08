# BOT_SEND_NOTICE

Commands bot to send a notice to the specified group

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | notice to send            |
| id       | yes      | UUID of group to send notice to |

## Comments

The subject and contents of the notice are being separated by a "\n" (see example below).

For this command to work the bot must:

- Be a member of the group
- Have permission to send group notices

Please also note that the standard notice length limits apply

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SEND_NOTICE, "Subject\nBody of notice", "uuid-of-group");
```
