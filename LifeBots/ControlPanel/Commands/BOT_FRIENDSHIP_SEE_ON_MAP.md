# BOT_FRIENDSHIP_SEE_ON_MAP

Commands bot to control a friend's ability to see the bot's location on the map

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | 1 = Allow\n0 = Revoke     |
| id       | yes      | UUID of friend            |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_FRIENDSHIP_SEE_ON_MAP, "1", "d648fb86-d59b-4d69-8d3c-d00862aec699");
```

## Related Commands

- [BOT_FRIENDSHIP_CAN_EDIT](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_FRIENDSHIP_CAN_EDIT.md)
- [BOT_FRIENDSHIP_SEE_ONLINE](https://github.com/missyrestless/Bots/blob/main/LifeBots/ControlPanel/Commands/BOT_FRIENDSHIP_SEE_ONLINE.md)
