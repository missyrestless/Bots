# BOT_SELECT_GROUP_TAG

Changes the active group tag/title to the corresponding role UUID.

## Variables

The following table shows input values (you send them with the API call) and returned output values.

| Variable | Required | Description               |
|:-------- |:-------- |:------------------------- |
| str      | yes      | UUID of the role          |
| id       | yes      | UUID of the group         |

## Example

```lsl
llMessageLinked(LINK_SET, BOT_SELECT_GROUP_TAG, "00000000-0000-0000-0000-000000000000", "0b65a122-8f77-64fe-5b2a-225d4c490d9c");
```
