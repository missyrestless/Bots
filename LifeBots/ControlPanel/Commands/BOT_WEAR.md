# BOT_WEAR

Commands bot to wear or add a specified item

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | can be left blank to wear an item or set to 'add' to add an item |
| id       | yes      | uuid of the item to wear  |

## Example

Wear an item of clothing

```lsl
llMessageLinked(LINK_SET, BOT_WEAR, "", "c8dea937-74a6-393b-1b7f-ea801fd1ccbc");
```

Add an item of clothing

```lsl
llMessageLinked(LINK_SET, BOT_WEAR, "add", "c8dea937-74a6-393b-1b7f-ea801fd1ccbc");
```
