# LIST_INVENTORY

Returns a list of items in the bot's inventory. Can return basic or extended information.

If a UUID is provided, returns a list of the specified folder items.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | "True" - extended information<br>"False" - basic information |
| id       | optional | Folder UUID or NULL_KEY   |

## Example

```lsl
llMessageLinked(LINK_SET, LIST_INVENTORY "True", NULL_KEY);
```
