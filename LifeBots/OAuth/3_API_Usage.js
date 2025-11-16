// Step 3: Use access token to make API calls
const response = await fetch('https://api.lifebots.cloud/api/v1/user', {
  headers: {
    'Authorization': 'Bearer ' + accessToken,
    'Content-Type': 'application/json'
  }
})

const userData = await response.json()