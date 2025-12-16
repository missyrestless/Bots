# BOT_TOUCH_OBJECT

Commands bot to touch an object

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | UUID of object to touch   |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_TOUCH_OBJECT, "", "uuid-of-object");
```
