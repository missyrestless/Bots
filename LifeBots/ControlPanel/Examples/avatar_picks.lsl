// Simple script that returns the Profile Picks of whoever touches the object
//
///////// LIFEBOTS COMMAND & CONTROL ////////////////
integer BOT_SETUP_SETBOT            = 280101;      //
integer BOT_SETUP_DEVICENAME        = 280103;      //
integer AVATAR_PICKS                = 299003;      //
integer BOT_SETUP_SUCCESS           = 280201;      //
/////////////////////////////////////////////////////

////////////////////////////////////////////////////
// Land Inviter
////////////////////////////////////////////////////
string deviceName = "Avatar Picks";
string botName = "Bot Name";
string botCode = "Bot Access Code";
    
default {
    state_entry() {
        // Setup Device
        llMessageLinked(LINK_SET, BOT_SETUP_DEVICENAME, deviceName, llGetOwner());
        
        // Setup Bot
        llMessageLinked(LINK_SET, BOT_SETUP_SETBOT, botName, botCode);
    }
    
    // Send out group invite on touch
    touch_start(integer num) {
        llMessageLinked(LINK_SET, AVATAR_PICKS, "", llDetectedKey(0));
    }
    
    // Notify owner if device was successfully initialized
    link_message( integer sender_num, integer num, string str, key id ) {
        /////////////////// Bot setup success event
        if(num==BOT_SETUP_SUCCESS) {
            // Inform user
            llOwnerSay(deviceName + " ready!");
        }
    }
}
