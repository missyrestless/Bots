# BOT_NOTECARD_EDIT

Commands bot to edit the contents of a notecard for the given UUID

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | The new text to be saved to the notecard |
| id       | yes      | UUID of inventory item to edit |

## Comments

The name and contents of the notecard are being separated by a "\n" (see example below).

## Example

```lsl
llMessageLinked(LINK_SET, BOT_NOTECARD_EDIT, "This text will overwrite the contents of the notecard.", "f7f22046-d5d5-54f6-03a3-8a1836efedad");
```
