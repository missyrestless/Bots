# BOT_ATTACHMENT_OBJECT

Commands bot to touch an object currently being worn

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | name of attachment        |
| id       | yes      | link number to touch      |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_ATTACHMENT_OBJECT, "HUD", "0");
```
