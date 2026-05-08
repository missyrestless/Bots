// LifeBots API - Log out a bot from Second Life
// LSL Script for logout command

// ============================================
// CONFIGURATION - Modify these values
// ============================================
string API_URL = "https://api.lifebots.cloud/api/bot.html";
string API_KEY = "lbk_0cRHs5cmDUiOOfDhxGfQuED4M6bUmNjy";
string BOT_NAME = "Joe Resident";
string BOT_SECRET = "your-bot-secret";


// Command action
string ACTION = "logout";

// ============================================
// FUNCTIONS
// ============================================

sendLogout()
{
    // Build JSON payload
    string json = "{"
        + "\"action\":\"" + ACTION + "\""
        + ",\"apikey\":\"" + API_KEY + "\""
        + ",\"botname\":\"" + BOT_NAME + "\""
        + ",\"secret\":\"" + BOT_SECRET + "\""
        + "}";
    
    // Send HTTP POST request
    llHTTPRequest(API_URL, [
        HTTP_METHOD, "POST",
        HTTP_MIMETYPE, "application/json"
    ], json);
    
    llOwnerSay("Sending logout request...");
}

// ============================================
// STATES
// ============================================

default
{
    state_entry()
    {
        llOwnerSay("LifeBots API Script Ready");
        llOwnerSay("Touch to execute logout");
    }
    
    touch_start(integer num)
    {
        sendLogout();
    }
    
    http_response(key request_id, integer status, list metadata, string body)
    {
        if (status == 200)
        {
            llOwnerSay("✓ Success!");
            llOwnerSay("Response: " + body);
            
            // Parse JSON response (basic example)
            // For complex parsing, consider using a JSON library
            if (llSubStringIndex(body, "result=OK") != -1)
            {
                llOwnerSay("✓ Command executed successfully");
            }
            else if (llSubStringIndex(body, "result=FAIL") != -1)
            {
                llOwnerSay("✗ Command failed - check response");
            }
        }
        else
        {
            llOwnerSay("✗ HTTP Error: " + (string)status);
            llOwnerSay("Response: " + body);
        }
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }
}

// ============================================
// NOTES
// ============================================
// * LSL has a 2048 byte limit for HTTP responses
// * Modify configuration values at the top before use
// * This script is for Second Life/OpenSim
// * For production use, consider error handling and retries
