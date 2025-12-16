# FIND_OBJECTS

Searches for objects near the bot within the specified range (default range: 96 meters).

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | optional | Range: "number" or ""     |
| id       | yes      | ---                       |

## Example

```lsl
llMessageLinked(LINK_SET, FIND_OBJECTS, "", "");
```
