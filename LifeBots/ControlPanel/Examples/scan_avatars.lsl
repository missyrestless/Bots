// Simple script that returns the Avatars in the region when touched
//
//////// LIFEBOTS COMMAND & CONTROL CODES ////////
// Setup and startup                            //
integer BOT_SETUP_SETBOT            = 280101;   //
integer BOT_STATUS_QUERY            = 280106;   //
integer BOT_RESET_CONTROLPANEL      = 9997770;  //
integer BOT_RESET_TOTALCONTROL      = 9997770;  //
                                                //
// Bot Status                                   //
integer BOT_LOGIN                   = 280111;   //
integer BOT_LOGOUT                  = 280112;   //
integer BOT_LOCATION                = 290232;   //
                                                //
// Device Settings                              //
integer BOT_SETUP_SETOPTIONS        = 280104;   //
integer BOT_SETUP_DEVICENAME        = 280103;   //
integer BOT_SETUP_DEBUG             = 280105;   //
integer BOT_SETUP_SETLINK           = 280102;   //
                                                //
// Communication commands                       //
integer BOT_SAY_CHAT                = 280121;   //
integer BOT_INSTANT_MESSAGE         = 280122;   //
integer BOT_SAY_GROUP_CHAT          = 280123;   //
integer BOT_SEND_NOTICE             = 280124;   //
integer BOT_OFFER_TELEPORT          = 290226;   //
integer BOT_LISTEN_LOCAL_CHAT       = 280125;   //
integer BOT_LISTEN_IM               = 280126;   //
                                                //
// Movement                                     //
integer BOT_WALK                    = 280131;   //
integer BOT_WALKTO                  = 280132;   //
integer BOT_TELEPORT                = 280133;   //
integer BOT_FLY                     = 280134;   //
integer BOT_SIT                     = 290214;   //
integer BOT_STAND                   = 290217;   //
                                                //
// Group Management                             //
integer BOT_LIST_GROUPS             = 280144;   //
integer BOT_LIST_GROUP_ROLES        = 290227;   //
integer BOT_GROUP_JOIN              = 280145;   //
integer BOT_GROUP_LEAVE             = 280146;   //
integer BOT_ACTIVATE_GROUP          = 290215;   //
integer BOT_GROUP_SET_ROLE          = 290228;   //
integer BOT_GROUP_INVITE            = 280156;   //
integer BOT_GROUP_EJECT             = 280157;   //
integer BOT_SELECT_GROUP_TAG        = 290216;   //
                                                //
// Friendship                                   //
integer BOT_OFFER_FRIENDSHIP        = 280147;   //
integer BOT_UNFRIEND                = 280160;   //
integer BOT_FRIENDSHIP_CAN_EDIT     = 290229;   //
integer BOT_FRIENDSHIP_SEE_ONLINE   = 290230;   //
integer BOT_FRIENDSHIP_SEE_ON_MAP   = 290231;   //
                                                //
// Money and Inventory                          //
integer BOT_LISTEN_INVENTORY_OFFER  = 280141;   //
integer BOT_LISTEN_MONEY_PAYMENTS   = 280142;   //
integer BOT_GIVE_INVENTORY          = 280150;   //
integer BOT_GIVE_MONEY              = 280151;   //
integer BOT_GIVE_MONEY_OBJECT       = 290225;   //
integer BOT_GET_BALANCE             = 280152;   //
integer BOT_INVENTORY_DELETE        = 290234;   //
integer BOT_NOTECARD_CREATE         = 290235;   //
integer BOT_NOTECARD_EDIT           = 290236;   //
integer BOT_NOTECARD_READ           = 290237;   //
                                                //
// Bot Appearance                               //
integer BOT_WEAR                    = 280155;   //
integer BOT_TAKEOFF                 = 290223;   //
integer BOT_REBAKE                  = 290222;   //
integer BOT_ATTACHMENTS             = 280153;   //
                                                //
// Sim Management                               //
integer BOT_SIM_RESTART_START       = 280158;   //
integer BOT_SIM_RESTART_STOP        = 280159;   //
integer BOT_SIM_SEND_MESSAGE        = 290218;   //
integer BOT_SIM_KICK                = 290219;   //
integer BOT_SIM_ACCESS              = 290220;   //
integer BOT_SIM_ACCESS_ALL_ESTATES  = 290221;   //
                                                //
// Misc. commands                               //
integer BOT_LISTEN_DIALOG           = 280143;   //
integer BOT_TOUCH_OBJECT            = 280148;   //
integer BOT_ATTACHMENT_OBJECT       = 280149;   //
integer BOT_DIALOG_REPLY            = 280154;   //
                                                //
// Events                                       //
integer BOT_SETUP_SUCCESS           = 280201;   //
integer BOT_SETUP_FAILED            = 280202;   //
integer BOT_COMMAND_FAILED          = 280203;   //
integer BOT_EVENT_LISTEN_LOCAL_CHAT = 280204;   //
integer BOT_EVENT_LISTEN_IM         = 280205;   //
integer BOT_EVENT_LISTEN_INVENTORY  = 280206;   //
integer BOT_EVENT_LISTEN_MONEY      = 280207;   //
integer BOT_EVENT_LISTEN_SUCCESS    = 280208;   //
integer BOT_EVENT_STATUS_REPLY      = 280209;   //
integer BOT_LIST_GROUPS_REPLY       = 280210;   //
integer BOT_LIST_GROUP_ROLES_REPLY  = 290224;   //
integer BOT_GET_BALANCE_REPLY       = 280211;   //
integer BOT_EVENT_LISTEN_DIALOG     = 280212;   //
integer BOT_ATTACHMENTS_REPLY       = 280213;   //
integer BOT_LOCATION_REPLY          = 290233;   //
integer BOT_NOTECARD_READ_REPLY     = 290238;   //
integer BOT_NOTECARD_CREATE_REPLY   = 290239;   //
                                                //
// LifeBots API Extensions                      //
//
// Avatar Operations
integer ADJUST_HOVER_HEIGHT         = 299005;   //
integer AVATAR_INFO                 = 299022;   //
integer AVATAR_DISPLAY_NAME         = 299023;   //
integer AVATAR_PICKS                = 299024;   //
integer AVATAR_GROUPS               = 299025;   //
integer AVATAR_GROUPS_MATCH         = 299026;   //
integer AVATAR_GROUPS_SKIP          = 299027;   //
integer AVATAR_GROUPS_MATCH_SKIP    = 299028;   //
integer SCAN_AVATARS                = 299021;   //
integer UUID_TO_NAME                = 299021;   //
integer NAME_TO_UUID                = 299021;   //
// Communication
integer TELEPORT_OFFER_ACCEPT       = 299033;   //
integer TELEPORT_OFFER_DECLINE      = 299034;   //
// Group Management
integer ACTIVATE_ROLE               = 299002;   //
integer GROUP_INFO                  = 299013;   //
integer GROUP_VISIBILITY            = 299016;   //
integer GROUP_OFFER_ACCEPT          = 299017;   //
integer GROUP_OFFER_DECLINE         = 299018;   //
integer LIST_GROUPS_UUID            = 299014;   //
integer LIST_GROUPS_NAME            = 299015;   //
integer LIST_GROUP_MEMBERS          = 299000;   //
// Inventory Management
integer LIST_INVENTORY              = 299001;   //
integer LIST_OUTFITS                = 299006;   //
integer WEAR_OUTFIT                 = 299007;   //
integer GET_WORN_OUTFIT             = 299008;   //
integer INVENTORY_TO_OBJECT         = 299004;   //
// Object Interaction
integer TAKE_DELETE_OBJECT          = 299003;   //
integer FIND_OBJECTS                = 299009;   //
integer FIND_OBJECTS_WITH_PROP      = 299010;   //
integer FIND_OBJECTS_PARCEL         = 299011;   //
integer FIND_OBJECT_UUID            = 299012;   //
// Movement Commands
integer ALWAYS_RUN                  = 299019;   //
integer ALWAYS_WALK                 = 299020;   //
// Simulator/Parcel Management
integer SIM_RETURN_OBJECTS          = 299029;   //
integer SIM_RETURN_SCRIPTED_OBJECTS = 299030;   //
integer SIM_RETURN_OTHERS_OBJECTS   = 299031;   //
integer REGION_INFO                 = 299032;   //
// JSON body of response to parse
integer BOT_JSON_RESPONSE           = 300000;   //
//////////////////////////////////////////////////

////////////////////////////////////////////////////
// Get Avatars in the Region
////////////////////////////////////////////////////
string deviceName = "Scan Avatars";
string botName = "Bot Name";
string botCode = "Bot Access Code";
    
default {
    state_entry() {
        // Setup Device
        llMessageLinked(LINK_SET, BOT_SETUP_DEVICENAME, deviceName, llGetOwner());
        
        // Setup Bot
        llMessageLinked(LINK_SET, BOT_SETUP_SETBOT, botName, botCode);
    }
    
    // Scan for Avatars in the region on touch
    touch_start(integer num) {
        llMessageLinked(LINK_SET, SCAN_AVATARS, "", "");
    }
    
    // Notify owner if device was successfully initialized
    // Parse returned JSON object string avatar by avatar to avoid exceeding llSay limit
    link_message( integer sender_num, integer num, string str, key id ) {
        /////////////////// Bot setup success event
        if (num == BOT_SETUP_SUCCESS) {
            // Inform user
            llOwnerSay(deviceName + " ready!");
        } else if (num == BOT_JSON_RESPONSE) {
            llSay(0, "Avatars in region:");
            string avis = llJsonGetValue(str, ["avatars"]);  
            string avuuid;
            string avinfo;
            string avout;
            list avis_list;
            list json_list;
            integer i;
            integer j;

            // Convert the JSON object string to an LSL strided list
            json_list = llJson2List(avis);

            // Loop through the list, incrementing by 2 in each step
            // Each pair consists of a key and a value, the Avatar UUID and Avatar Info
            for (i = 0; i < llGetListLength(json_list); i += 2)
            {
                avuuid = llList2String(json_list, i);     // This should be the Avatar UUID
                avinfo = llList2String(json_list, i + 1); // This should be the Avatar details
                avout = "\n";
                avis_list = llJson2List(avinfo);
                for (j = 0; j < llGetListLength(avis_list); j += 2)
                {
                    avuuid = llList2String(avis_list, j);
                    avinfo = llList2String(avis_list, j + 1);
                    avout = avout + avuuid + ": " + avinfo + "\n";
                }
                llSay(0, avout);
            }
        }
    }
}
