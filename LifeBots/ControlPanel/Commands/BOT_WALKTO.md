# BOT_WALKTO

Commands bot to walk to the specified coordinates

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | coordinates - x/y/z       |
| id       | yes      | --                        |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_WALKTO, "230/100/20", "");
```
