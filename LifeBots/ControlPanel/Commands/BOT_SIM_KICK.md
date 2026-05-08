# BOT_SIM_KICK

Kick an avatar from the region.

The bot must be an estate manager for this command to work.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | UUID of avatar to kick    |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SIM_KICK, "", "d11fa786-c342-4785-8e1b-ac70a17a9aac");
```
