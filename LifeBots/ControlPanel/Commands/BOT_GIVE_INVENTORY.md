# BOT_GIVE_INVENTORY

Commands bot to give an inventory object to someone

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | UUID of object to give    |
| id       | yes      | UUID of avatar to receive the object |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_GIVE_INVENTORY, "object uuid", "receiver uuid");
```
