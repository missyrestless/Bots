# INVENTORY_TO_OBJECT

Copies an inventory item into an in-world object.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | Inventory item UUID       |
| id       | yes      | In-world object UUID      |

## Example

```lsl
llMessageLinked(LINK_SET, INVENTORY_TO_OBJECT, "inventory-item-uuid", "in-world-object-uuid");
```
