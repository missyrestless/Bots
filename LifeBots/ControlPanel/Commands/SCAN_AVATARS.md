# SCAN_AVATARS

Returns information about all avatars in the current region, including their positions,
distances from the bot, and sitting status. Default radius of scan is 96 meters.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | optional | Radius from bot to scan   |
| id       | yes      | ---                       |

## Example

```lsl
llMessageLinked(LINK_SET, SCAN_AVATARS, "50", "");
```
