// Step 2: Exchange authorization code for access token
const tokenResponse = await fetch('https://lifebots.cloud/oauth/token', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/x-www-form-urlencoded'
  },
  body: new URLSearchParams({
    grant_type: 'authorization_code',
    client_id: 'your_client_id',
    client_secret: 'your_client_secret',
    code: 'authorization_code_from_callback',
    redirect_uri: 'https://yourapp.com/oauth/callback'
  })
})

const tokens = await tokenResponse.json()
// Returns: { access_token, refresh_token, token_type, expires_in, scope }