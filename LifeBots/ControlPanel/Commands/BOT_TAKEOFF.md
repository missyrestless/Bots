# BOT_TAKEOFF

Removes a clothing item, body part or attachment (the opposite of the wear command).

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | UUID of item to take off  |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_TAKEOFF, "", "23e07a61-0502-966c-d8a0-19fd433fbcda");
```
