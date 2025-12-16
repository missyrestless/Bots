# BOT_SIM_ACCESS

Control access to a sim

The bot must be an estate manager for this command to work.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | One of the following options:<br>&bull;ban - add to ban list<br>&bull;unban - remove from ban list<br>&bull;allow - add to allow list<br>&bull;disallow - remove from allow list |
| id       | yes      | UUID of the avatar to manage access for |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SIM_ACCESS, "ban", "d11fa786-c342-4785-8e1b-ac70a17a9aac");
```
