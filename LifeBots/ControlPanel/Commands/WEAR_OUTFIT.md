# WEAR_OUTFIT

Replaces the current outfit with specified items.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | Outfit name               |
| id       | yes      | ---                       |

## Example

```lsl
llMessageLinked(LINK_SET, WEAR_OUTFIT, "Blue Evening Dress Outfit", "");
```
