# BOT_WALK

Commands bot to move/turn in the specified direction

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | direction bot should move - FORWARD, BACKWARD, LEFT, RIGHT, TURNLEFT, TURNRIGHT, FLY, or STOP |
| id       | yes      | START/STOP to start or stop the movement (not needed for STOP instruction) |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_WALK, "FORWARD", "START");
```
