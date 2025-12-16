# BOT_INVENTORY_DELETE

Commands bot to delete an inventory item for the given UUID

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | --                        |
| id       | yes      | uuid of inventory item to delete |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_INVENTORY_DELETE, "", "f7f22046-d5d5-54f6-03a3-8a1836efedad");
```
