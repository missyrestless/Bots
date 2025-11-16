// Refresh expired access token
const refreshResponse = await fetch('https://lifebots.cloud/oauth/token', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/x-www-form-urlencoded'
  },
  body: new URLSearchParams({
    grant_type: 'refresh_token',
    client_id: 'your_client_id',
    client_secret: 'your_client_secret',
    refresh_token: 'your_refresh_token'
  })
})

const newTokens = await refreshResponse.json()