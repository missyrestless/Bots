# How to Setup a Bot Access Secret

A Bot Access Secret is required for LifeBots API (Application Programming Interface)
authentication. API requests can be used to control your bots from another program.
Requests must be authenticated using an access secret unique to each bot.

**Note:** The access secret is sometimes referred to as an access code or secure code.

To create an access secret for a bot:

- Visit your LifeBots Dashboard at https://lifebots.cloud/dashboard
- Click on the bot you wish to control via the API
  - This will open a Manage Bot panel for the bot
- Click on the API Details pane
  - This will open an API Access Configuration window
- In the API Access Configuration window click on the Generate Secure Code button
  - This will generate a Bot Access Secret unique to this bot

After generating the Bot Access Secret, in the API Access Configuration window you
will see a Current Access Code with the date it was created. Below that is your
Bot Access Secret. Click on the eye icon to the right of the access secret to reveal
the secret. This will enable the Copy icon to the right of the eye icon.

Click on the Copy icon to copy the bot access secret to your clipboard. Paste the copied
secret into a file and store it securely. Never share this secret with anyone.

🔒 Enhanced Security Features:

✅ Access secrets are encrypted in database using your unique user key
✅ Each user has a different encryption key
✅ You can safely view and update your access secrets
✅ Sub-accounts use master account encryption for consistency


- Anyone with your access secret can control your bot using the API
- Store this secret securely and change it regularly
- If compromised, create a new access secret immediately
