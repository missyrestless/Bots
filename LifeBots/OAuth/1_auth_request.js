// Step 1: Redirect user to authorization endpoint
const authUrl = new URL('https://lifebots.cloud/login/consent')
authUrl.searchParams.set('client_id', 'your_client_id')
authUrl.searchParams.set('redirect_uri', 'https://yourapp.com/oauth/callback')
authUrl.searchParams.set('scope', 'read:profile read:bots write:bots')
authUrl.searchParams.set('state', 'random_state_string')

window.location.href = authUrl.toString()