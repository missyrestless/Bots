    link_message( integer sender_num, integer num, string str, key id ) {
        /////////////////// Bot setup success event
        if(num==BOT_SETUP_SUCCESS) {
            // We added our bot fine
            llOwnerSay("Successfully setup bot: " + str);
            
            // Send Request
            llMessageLinked(LINK_SET, BOT_REPLACE_WITH_YOURS, "your-message", "your-key");
        }
        else if(num==BOT_SETUP_FAILED) {
            // We split the string parameter to the lines
            list parts=llParseString2List(str,["\n"],[]);

            // The first line is a status code, and second line is the bot expiration date
            string code=llList2String(parts,0);
            string expires=llList2String(parts,1);
            
            // Setup failed somehow
            llOwnerSay("Bot setup failed:\n"+
              "error code: "+code+"\n"+
              "expired: "+expires);
        }
     }
