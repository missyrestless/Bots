# BOT_SIT

Commands bot to sit on a prim

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | optional | set this parameter to 1 to save the UUID as a permanent sitting location |
| id       | yes      | UUID of a prim where the bot will sit |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SIT, "1", "f8d31841-d60c-82ff-5e07-bda1edc9e603");
```
