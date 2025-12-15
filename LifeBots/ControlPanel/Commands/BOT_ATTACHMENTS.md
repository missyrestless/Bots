# BOT_ATTACHMENTS

Requests the attachments being worn by the bot.

Returns a list of all objects currently attached to the bot.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | --                        |

## Result

Raises the following event:

- `BOT_ATTACHMENTS_REPLY`

## Example

```lsl
llMessageLinked(LINK_SET, BOT_ATTACHMENTS, "", "");
```
