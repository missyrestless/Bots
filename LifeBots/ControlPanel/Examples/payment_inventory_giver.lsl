// Payment Inventory Giver Script
//
// Sets up the device and the bot in state_entry
// If the bot was setup successfully listen to payments
// If we got confirmation that we can listen to IMs now the script is ready
// Whenever we get a payment check if its the correct amount and send an inventory item if it is
//
//
///////// LIFEBOTS COMMAND & CONTROL ////////////////
//                                                 //
// Uncomment those that this script requires       //
//                                                 //
// Setup and startup                               //
integer BOT_SETUP_SETBOT            = 280101;      //
// integer BOT_STATUS_QUERY            = 280106;   //
// integer BOT_RESET_TOTALCONTROL      = 9997770;  //
                                                   //
   // Bot Status                                   //
// integer BOT_LOGIN                   = 280111;   //
// integer BOT_LOGOUT                  = 280112;   //
// integer BOT_LOCATION                = 290232;   //
                                                   //
// Device Settings                                 //
// integer BOT_SETUP_SETOPTIONS        = 280104;   //
integer BOT_SETUP_DEVICENAME        = 280103;      //
// integer BOT_SETUP_DEBUG             = 280105;   //
// integer BOT_SETUP_SETLINK           = 280102;   //
                                                   //
// Communication commands                          //
// integer BOT_SAY_CHAT                = 280121;   //
integer BOT_INSTANT_MESSAGE         = 280122;      //
// integer BOT_SAY_GROUP_CHAT          = 280123;   //
// integer BOT_SEND_NOTICE             = 280124;   //
// integer BOT_OFFER_TELEPORT          = 290226;   //
// integer BOT_LISTEN_LOCAL_CHAT       = 280125;   //
// integer BOT_LISTEN_IM               = 280126;   //
                                                   //
// Movement                                        //
// integer BOT_WALK                    = 280131;   //
// integer BOT_WALKTO                  = 280132;   //
// integer BOT_TELEPORT                = 280133;   //
// integer BOT_FLY                     = 280134;   //
// integer BOT_SIT                     = 290214;   //
// integer BOT_STAND                   = 290217;   //
                                                   //
// Group Management                                //
// integer BOT_LIST_GROUPS             = 280144;   //
// integer BOT_LIST_GROUP_ROLES        = 290227;   //
// integer BOT_GROUP_JOIN              = 280145;   //
// integer BOT_GROUP_LEAVE             = 280146;   //
// integer BOT_ACTIVATE_GROUP          = 290215;   //
// integer BOT_GROUP_SET_ROLE          = 290228;   //
// integer BOT_GROUP_INVITE            = 280156;   //
// integer BOT_GROUP_EJECT             = 280157;   //
// integer BOT_SELECT_GROUP_TAG        = 290216;   //
                                                   //
// Friendship                                      //
// integer BOT_OFFER_FRIENDSHIP        = 280147;   //
// integer BOT_UNFRIEND                = 280160;   //
// integer BOT_FRIENDSHIP_CAN_EDIT     = 290229;   //
// integer BOT_FRIENDSHIP_SEE_ONLINE   = 290230;   //
// integer BOT_FRIENDSHIP_SEE_ON_MAP   = 290231;   //
                                                   //
// Money and Inventory                             //
// integer BOT_LISTEN_INVENTORY_OFFER  = 280141;   //
integer BOT_LISTEN_MONEY_PAYMENTS   = 280142;      //
integer BOT_GIVE_INVENTORY          = 280150;      //
// integer BOT_GIVE_MONEY              = 280151;   //
// integer BOT_GIVE_MONEY_OBJECT       = 290225;   //
// integer BOT_GET_BALANCE             = 280152;   //
// integer BOT_INVENTORY_DELETE        = 290234;   //
// integer BOT_NOTECARD_CREATE         = 290235;   //
// integer BOT_NOTECARD_EDIT           = 290236;   //
// integer BOT_NOTECARD_READ           = 290237;   //
                                                   //
// Bot Appearance                                  //
// integer BOT_WEAR                    = 280155;   //
// integer BOT_TAKEOFF                 = 290223;   //
// integer BOT_REBAKE                  = 290222;   //
// integer BOT_ATTACHMENTS             = 280153;   //
                                                   //
// Sim Management                                  //
// integer BOT_SIM_RESTART_START       = 280158;   //
// integer BOT_SIM_RESTART_STOP        = 280159;   //
// integer BOT_SIM_SEND_MESSAGE        = 290218;   //
// integer BOT_SIM_KICK                = 290219;   //
// integer BOT_SIM_ACCESS              = 290220;   //
// integer BOT_SIM_ACCESS_ALL_ESTATES  = 290221;   //
                                                   //
// Misc. commands                                  //
// integer BOT_LISTEN_DIALOG           = 280143;   //
// integer BOT_TOUCH_OBJECT            = 280148;   //
// integer BOT_ATTACHMENT_OBJECT       = 280149;   //
// integer BOT_DIALOG_REPLY            = 280154;   //
                                                   //
// EVENTS                                          //
integer BOT_SETUP_SUCCESS           = 280201;      //
integer BOT_SETUP_FAILED            = 280202;      //
// integer BOT_COMMAND_FAILED          = 280203;   //
// integer BOT_EVENT_LISTEN_LOCAL_CHAT = 280204;   //
// integer BOT_EVENT_LISTEN_IM         = 280205;   //
// integer BOT_EVENT_LISTEN_INVENTORY  = 280206;   //
integer BOT_EVENT_LISTEN_MONEY      = 280207;      //
integer BOT_EVENT_LISTEN_SUCCESS    = 280208;      //
// integer BOT_EVENT_STATUS_REPLY      = 280209;   //
// integer BOT_LIST_GROUPS_REPLY       = 280210;   //
// integer BOT_LIST_GROUP_ROLES_REPLY  = 290224;   //
// integer BOT_GET_BALANCE_REPLY       = 280211;   //
// integer BOT_EVENT_LISTEN_DIALOG     = 280212;   //
// integer BOT_ATTACHMENTS_REPLY       = 280213;   //
// integer BOT_LOCATION_REPLY          = 290233;   //
// integer BOT_NOTECARD_READ_REPLY     = 290238;   //
// integer BOT_NOTECARD_CREATE_REPLY   = 290238;   //
                                                   //
/////////////////////////////////////////////////////
////////////////////////////////////////////////////
// Payment Inventory giver example
////////////////////////////////////////////////////
string deviceName = "Inventory Giver";
string botName = "Bot Name";
string botCode = "Bot Access Code";
string inventoryID = "UUID goes here";
string paymentAmount = "5";
string errorMessage = "You paid me the wrong amount!";

default {
    state_entry() {
        // Setup Device
        llMessageLinked(LINK_SET, BOT_SETUP_DEVICENAME, deviceName, llGetOwner());
        
        // Setup Bot
        llMessageLinked(LINK_SET, BOT_SETUP_SETBOT, botName, botCode);
    }
    
    link_message( integer sender_num, integer num, string str, key id ) {
        /////////////////// Bot setup success event
        if(num==BOT_SETUP_SUCCESS) {
            // We added our bot fine
            llOwnerSay("Successfully setup bot: " + str);
            
            // Request listen to payments
            llMessageLinked(LINK_SET, BOT_LISTEN_MONEY_PAYMENTS, "", "");
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
        else if(num==BOT_EVENT_LISTEN_SUCCESS) {
            // We are ready!
            llOwnerSay("Advanced Inventory Giver Ready!");
        }
        else if(num==BOT_EVENT_LISTEN_MONEY) {
            // Woo we got paid! Check if they paid the right amount
            if(str != paymentAmount) {
                llMessageLinked(LINK_SET, BOT_INSTANT_MESSAGE, errorMessage, id);
            }
            else { // Otherwise send the item
                llMessageLinked(LINK_SET, BOT_GIVE_INVENTORY,inventoryID, llDetectedKey(0));
            }
        }
     }
}
