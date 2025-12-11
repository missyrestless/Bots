// LifeBots API - Give inventory item to avatar
// LSL Script for give_inventory command

// ============================================
// CONFIGURATION - Modify these values
// ============================================
string API_URL = "https://api.lifebots.cloud/api/bot.html";
string API_KEY = "lbk_oZ17pnmYlHBaHRzyjUy93IXpy9gqabjC";
string BOT_NAME = "Joe Resident";
string BOT_SECRET = "your-bot-secret";

// Command-specific parameters
string AVATAR = "a2e76fcd-9360-4f6d-a924-000000000000";
string OBJECT = "a2e76fcd-9360-4f6d-a924-000000000000";

// Command action
string ACTION = "give_inventory";

// ============================================
// FUNCTIONS
// ============================================

sendGiveinventory()
{
    // Build JSON payload
    string json = "{"
        + "\"action\":\"" + ACTION + "\""
        + ",\"apikey\":\"" + API_KEY + "\""
        + ",\"botname\":\"" + BOT_NAME + "\""
        + ",\"secret\":\"" + BOT_SECRET + "\""
        + ",\"avatar\":\"" + AVATAR + "\""
        + ",\"object\":\"" + OBJECT + "\""
        + ",\"nosafehub\":\"" + NOSAFEHUB + "\""
        + "}";
    
    // Send HTTP POST request
    llHTTPRequest(API_URL, [
        HTTP_METHOD, "POST",
        HTTP_MIMETYPE, "application/json"
    ], json);
    
    llOwnerSay("Sending give_inventory request...");
}

// ============================================
// STATES
// ============================================

default
{
    state_entry()
    {
        llOwnerSay("LifeBots API Script Ready");
        llOwnerSay("Touch to execute give_inventory");
    }
    
    touch_start(integer num)
    {
        sendGiveinventory();
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
