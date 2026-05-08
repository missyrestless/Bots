# BOT_TELEPORT

Commands bot to teleport to a specified location

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | location to teleport to - Region/x/y/z |
| id       | yes      | --                        |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_TELEPORT, "Region/128/128/20", "");
```
