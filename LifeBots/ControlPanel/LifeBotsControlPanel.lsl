///////////// LifeBots Control Panel ///////////////
//                                                //
// This script acts as a bridge between LifeBots  //
// command and control scripts and LifeBots bots  //
//                                                //
// On touch the LifeBots Control Panel presents a //
// dialog menu with command and control choices   //
// depending on what user scripts are present     //
//                                                //
////////////////////////////////////////////////////

////////////////////////////////////////////////////
// Copyright (c) 2025-2026 Truth & Beauty Lab     //
// All rights reserved.                           //
//                                                //
// Author: Missy Restless missyrestless@gmail.com //
////////////////////////////////////////////////////

string PRODUCT = "LifeBots Control Panel™";
string VERSION = "1.0.0";

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
//////////////////////////////////////////////////
// LifeBots Control Panel Command & Control Bridge
//////////////////////////////////////////////////

string API_URL = "https://api.lifebots.cloud/api/bot.html";
string API_KEY = "";
string BOT_NAME = "";
string BOT_SECRET = "";

string DEVICE_NAME = "";
string LOGIN_SITON = "";

string WEBHOOK_URL = "";
key urlRequestId = NULL_KEY;
key selfCheckRequestId = NULL_KEY;

// Configuration Notecard
string CONFIG_CARD = "Configuration";
integer NotecardLine;
key QueryID;

key Owner = NULL_KEY;

// LifeBots Control Panel sends events to LINK_SET by default
// You can specify the exact link number of the prim to optimize performance
integer LINK = LINK_SET;

// 0 = debug off, 1 = debug on
integer LB_DEBUG = 0;

// Send LifeBots HTTP API commands
LifeBotsAPI(string command, list params) {

    if (LB_DEBUG == 1) {
        llSay(DEBUG_CHANNEL, "API_KEY = " + API_KEY);
        llSay(DEBUG_CHANNEL, "BOT_NAME = " + BOT_NAME);
        llSay(DEBUG_CHANNEL, "BOT_SECRET = " + BOT_SECRET);
    }
    // Populate the query data
    list query = [
        "action="  + command,
        "apikey="  + llEscapeURL(API_KEY),
        "botname=" + llEscapeURL(BOT_NAME),
        "secret="  + llEscapeURL(BOT_SECRET),
        "dataType=json"
    ];
    if (LB_DEBUG == 1) {
        llSay(DEBUG_CHANNEL, "API_KEY = " + API_KEY);
        llSay(DEBUG_CHANNEL, "BOT_NAME = " + BOT_NAME);
        llSay(DEBUG_CHANNEL, "BOT_SECRET = " + BOT_SECRET);
    }

    integer i;
    for(i = 0; i<llGetListLength(params); i += 2) {
        query += [ llList2String(params, i) + "=" + llEscapeURL(llList2String(params, i+1)) ];
    }

    string queryString = llDumpList2String(query, "&");

    if (LB_DEBUG == 1) {
        llSay(DEBUG_CHANNEL, "API_URL = " + API_URL);
        llSay(DEBUG_CHANNEL, "queryString = " + queryString);
    }
 
    llHTTPRequest(API_URL, [HTTP_METHOD,"POST"], queryString);
}

// Function to convert a string to a boolean (case-insensitive, basic values)
// Usage examples:
//   string input1 = "TRUE";
//   string input2 = "fAlSe";
//   boolean bool1 = stringToBoolean(input1); // bool1 becomes TRUE
//   boolean bool2 = stringToBoolean(input2); // bool2 becomes FALSE
integer stringToBoolean(string str) {
    string lowerStr = llToLower(str); // Convert to lowercase for case-insensitivity
    if (lowerStr == "true" || lowerStr == "yes" || lowerStr == "on" || lowerStr == "1") {
        return TRUE;
    } else {
        return FALSE; // Handles "false", "no", "off", "0", "" and any other string
    }
}
 
request_secure_url()
{
    if (WEBHOOK_URL != "") {
        llReleaseURL(WEBHOOK_URL);
    }
    WEBHOOK_URL = "";
 
    urlRequestId = llRequestSecureURL();
}
 
throw_exception(string inputString)
{
    key owner = llGetOwner();
    llInstantMessage(owner, inputString);
 
    // yeah, bad way to handle exceptions by restarting.
    // However this is just a demo script...
 
    llResetScript();
}

default {
 
    state_entry()
    {
        Owner = llGetOwner();
        if (llGetInventoryType(CONFIG_CARD) == INVENTORY_NOTECARD) {
            NotecardLine = 0;
            QueryID = llGetNotecardLine(CONFIG_CARD, NotecardLine);
        }
        else {
            llOwnerSay("Configuration notecard missing, using defaults.");
        }
        request_secure_url();
    }

    on_rez(integer param)
    {
        llResetScript();
    }

    changed(integer change)
    {
        if (change & (CHANGED_OWNER | CHANGED_INVENTORY))
        {
            llReleaseURL(WEBHOOK_URL);
            WEBHOOK_URL = "";
 
            llResetScript();
        }
 
        if (change & (CHANGED_REGION | CHANGED_REGION_START | CHANGED_TELEPORT))
            request_secure_url();
    }
 

    dataserver( key queryid, string data )
    {
        integer lang_pos;
        list temp;
        string name;
        string value;
        if ( queryid == QueryID ) {
            if ( data != EOF ) {
                if (data == "END_SETTINGS") {
                    if ((API_KEY == "") || (API_KEY == "your-api-key")) {
                        llOwnerSay("ERROR: LB_API_KEY not set.");
                        llOwnerSay("Edit the Configuration notecard to set your LifeBots API Key.");
                        llSetScriptState(llGetScriptName(), FALSE);
                    }
                }
                if ( llGetSubString(data, 0, 0) != "#" && llStringTrim(data, STRING_TRIM) != "" ) {
                    temp = llParseString2List(data, ["="], []);
                    name = llStringTrim(llList2String(temp, 0), STRING_TRIM);
                    value = llStringTrim(llList2String(temp, 1), STRING_TRIM);
                    if ( value == "TRUE" ) value = "1";
                    if ( value == "FALSE" ) value = "0";
                    if ( name == "LB_API_KEY" ) {
                        if (LB_DEBUG == 1) {
                          llSay(DEBUG_CHANNEL, "Setting API Key to " + value);
                        }
                        API_KEY = value;
                    } else if ( name == "LB_SECRET" ) {
                        if (LB_DEBUG == 1) {
                          llSay(DEBUG_CHANNEL, "Setting Bot Secret to " + value);
                        }
                        BOT_SECRET = value;
                    } else if ( name == "LB_BOT_NAME" ) {
                        if (LB_DEBUG == 1) {
                          llSay(DEBUG_CHANNEL, "Setting Bot Name to " + value);
                        }
                        BOT_NAME = value;
                    } else if ( name == "LOGIN_SITON" ) {
                        LOGIN_SITON = value;
                    } else if ( name == "DEBUG" ) {
                        LB_DEBUG = (integer)value;
                    }
                }
                NotecardLine++;
                QueryID = llGetNotecardLine( CONFIG_CARD, NotecardLine );
            }
        }
    }

    http_request(key id, string method, string body)
    {
        if (method == URL_REQUEST_DENIED)
            throw_exception("Error while attempting to get a free URL for this device:\n \n" + body);
 
        else if (method == URL_REQUEST_GRANTED)
        {
            WEBHOOK_URL = body;
            // check every 5 mins for dropped URL
            llSetTimerEvent(300.0);
        }
    }
 
    timer()
    {
        selfCheckRequestId = llHTTPRequest(WEBHOOK_URL,
                                [HTTP_METHOD, "GET", HTTP_VERBOSE_THROTTLE, FALSE,
                                 HTTP_BODY_MAXLENGTH, 16384], "");
    }

    http_response(key request_id, integer status, list metadata, string body)
    {
        if (request_id == selfCheckRequestId)
        {
            selfCheckRequestId = NULL_KEY;
 
            if (status != 200)
                request_secure_url();
        } else if (request_id == NULL_KEY) {
            throw_exception("Too many HTTP requests too fast!");
        } else if (status == 200) {
            if (LB_DEBUG == 1) {
                llSay(DEBUG_CHANNEL, "In http_response request_id = " + (string)request_id);
            }
            llOwnerSay("✓ Success!");
            llOwnerSay("Response: " + body);
            // In case the user wishes to parse the JSON body
            llMessageLinked(LINK, BOT_JSON_RESPONSE, body, NULL_KEY);
            
            // Parse JSON response for success or failure
            if (llJsonGetValue( body, ["result"]) == "OK")
            {
                llOwnerSay("✓ Command executed successfully");
            }
            else if (llJsonGetValue( body, ["result"]) == "FAIL")
            {
                llOwnerSay("✗ Command failed - check response");
            }
        } else {
            llOwnerSay("✗ HTTP Error: " + (string)status);
            llOwnerSay("Response: " + body);
        }
    }

    link_message(integer sender, integer num, string message, key trigger)
    {
        if (LB_DEBUG == 1) {
          llSay(DEBUG_CHANNEL, llList2CSV([sender, num, message, trigger]));
          llSay(DEBUG_CHANNEL, "API Num = " + (string)num);
          llSay(DEBUG_CHANNEL, "Message = " + message);
          llSay(DEBUG_CHANNEL, "Trigger = " + (string)trigger);
        }
        // Setup and startup
        if (num == BOT_SETUP_SETBOT) {
            if (LB_DEBUG == 1) {
              llSay(DEBUG_CHANNEL, "Setting Bot Name to " + message);
            }
            BOT_NAME = message;
            if (LB_DEBUG == 1) {
              llSay(DEBUG_CHANNEL, "Setting Bot Secret to " + (string)trigger);
            }
            BOT_SECRET = (string)trigger;
            // TODO: Check Bot status and send bot setup success/failure link message
            // Check_Bot_Status();
            llMessageLinked(LINK, BOT_SETUP_SUCCESS, BOT_NAME, trigger);
            // llMessageLinked(LINK, BOT_SETUP_FAILED, BOT_NAME, trigger);
        } else if (num == BOT_SETUP_SETLINK) {
            // TODO: validate this is a proper link number for the prim
            llOwnerSay("Setting link number for llMessageLinked calls to: " + message);
            LINK = (integer)message;
        } else if (num == BOT_RESET_TOTALCONTROL) {
            llOwnerSay("Resetting " + PRODUCT);
            llResetScript();
        // Bot Status
        } else if (num == BOT_STATUS_QUERY) {
            llOwnerSay("Sending bot status request...");
            LifeBotsAPI("status", [ ]);
        } else if (num == BOT_LOGIN) {
            llOwnerSay("Sending bot login request...");
            LifeBotsAPI("login", [ ]);
        } else if (num == BOT_LOGOUT) {
            llOwnerSay("Sending bot logout request...");
            LifeBotsAPI("logout", [ ]);
        } else if (num == BOT_LOCATION) {
            llOwnerSay("Sending bot location request...");
            LifeBotsAPI("bot_location", [ ]);
        // Device Settings
        // TODO: BOT_SETUP_SETOPTIONS
        } else if (num == BOT_SETUP_DEBUG) {
            if (message == "1") {
                LB_DEBUG = 1;
            } else {
                LB_DEBUG = 0;
            }
        } else if (num == BOT_SETUP_DEVICENAME) {
            DEVICE_NAME = message;
        // Communication commands
        // TODO:
        //   BOT_LISTEN_LOCAL_CHAT
        //   "url": "https://your-server.com/webhook",
        //   "events": "im,teleport,login", or "all"
        //   "operation": "add", "remove", or "list"
        } else if (num == BOT_LISTEN_IM) {
            if (WEBHOOK_URL == "") {
                request_secure_url();
            }
            llOwnerSay("Sending bot listen IM request...");
            LifeBotsAPI("set_http_callback", [
              "url", WEBHOOK_URL,
              "events", "im",
              "operation", "add"
            ]);
        } else if (num == BOT_SAY_CHAT) {
            llOwnerSay("Sending bot say chat request...");
            LifeBotsAPI("say_chat_channel", [
              "channel", "0",
              "message", message
            ]);
        } else if (num == BOT_INSTANT_MESSAGE) {
            llOwnerSay("Sending bot instant message request...");
            LifeBotsAPI("im", [
              "slname", (string)trigger,
              "message", message
            ]);
        } else if (num == BOT_SAY_GROUP_CHAT) {
            llOwnerSay("Sending bot say group chat request...");
            LifeBotsAPI("send_group_im", [
              "groupuuid", (string)trigger,
              "message", message
            ]);
        } else if (num == BOT_SEND_NOTICE) {
            // Split the message parameter into list
            list msgstr=llParseString2List(message,["\n"],[]);
            // The first line is the subject, the second line is the text
            string SUBJECT = llList2String(msgstr,0);
            string TEXT = llList2String(msgstr,1);
            llOwnerSay("Sending bot send notice request...");
            LifeBotsAPI("send_notice", [
              "groupuuid", (string)trigger,
              "subject", SUBJECT,
              "text", TEXT
            ]);
        // Movement
        } else if (num == ALWAYS_RUN) {
            llOwnerSay("Sending bot always run request...");
            LifeBotsAPI("alwaysRun", [ ]);
        } else if (num == ALWAYS_WALK) {
            llOwnerSay("Sending bot always walk request...");
            LifeBotsAPI("alwaysWalk", [ ]);
        } else if (num == SCAN_AVATARS) {
            llOwnerSay("Sending bot scan nearby avatars request...");
            if (((string)((integer)message) == message) || ((string)((float)message) == message)) {
                LifeBotsAPI("nearbyavatars_scan", [
                  "radius", (float)message
                ]);
            } else {
                LifeBotsAPI("nearbyavatars_scan", [ ]);
            }
        } else if (num == BOT_SIT) {
            llOwnerSay("Sending bot sit request...");
            LifeBotsAPI("sit", [
              "uuid", (string)trigger,
              "save", message
            ]);
        } else if (num == BOT_STAND) {
            llOwnerSay("Sending bot stand request...");
            LifeBotsAPI("stand", [ ]);
        } else if (num == BOT_FLY) {
            llOwnerSay("Sending bot fly request...");
            LifeBotsAPI("fly", [
              "fly", message
            ]);
        } else if (num == BOT_TELEPORT) {
            llOwnerSay("Sending bot teleport request...");
            LifeBotsAPI("teleport", [
              "location", message
            ]);
        } else if (num == BOT_WALK) {
        // TODO: validate instruction is one of FORWARD, BACKWARD, LEFT, RIGHT, TURNLEFT, TURNRIGHT, FLY, or STOP
        // TODO: validate param1 is one of START or STOP (not needed for STOP instruction)
            llOwnerSay("Sending bot walk request...");
            LifeBotsAPI("move", [
              "instruction", message,
              "param1", (string)trigger
            ]);
        } else if (num == BOT_WALKTO) {
            llOwnerSay("Sending bot walk to request...");
            LifeBotsAPI("walkto", [
              "coords", message
            ]);
        // Group Management
        // TODO: BOT_SELECT_GROUP_TAG
        } else if (num == BOT_LIST_GROUPS) {
            llOwnerSay("Sending bot group list request...");
            LifeBotsAPI("listgroups", [ ]);
        } else if (num == BOT_LIST_GROUP_ROLES) {
            llOwnerSay("Sending bot list group roles request...");
            LifeBotsAPI("list_group_roles", [
              "groupuuid", (string)trigger
            ]);
        } else if (num == BOT_GROUP_JOIN) {
            llOwnerSay("Sending bot group join request...");
            LifeBotsAPI("group_join", [
              "groupuuid", (string)trigger
            ]);
        } else if (num == BOT_GROUP_LEAVE) {
            llOwnerSay("Sending bot group leave request...");
            LifeBotsAPI("group_leave", [
              "groupuuid", (string)trigger
            ]);
        } else if (num == BOT_ACTIVATE_GROUP) {
            llOwnerSay("Sending bot activate group request...");
            LifeBotsAPI("activate_group", [
              "groupuuid", (string)trigger
            ]);
        } else if (num == ACTIVATE_ROLE) {
            llOwnerSay("Sending bot activate group role request...");
            LifeBotsAPI("activate_role", [
              "groupuuid", (string)trigger,
              "roleuuid", message
            ]);
        } else if (num == BOT_GROUP_SET_ROLE) {
            // Split the message parameter into list
            list rolestr=llParseString2List(message,[","],[]);
            // The first line is the group id, the second line is the role id
            string grpuuid = llList2String(rolestr,0);
            string roluuid = llList2String(rolestr,1);
            llOwnerSay("Sending bot set group role request...");
            LifeBotsAPI("setrole", [
              "groupuuid", grpuuid,
              "roleuuid", roluuid,
              "member", (string)trigger
            ]);
        } else if (num == BOT_GROUP_EJECT) {
            llOwnerSay("Sending bot group eject request...");
            LifeBotsAPI("group_eject", [
              "groupuuid", (string)trigger,
              "avatar", message
            ]);
        } else if (num == BOT_GROUP_INVITE) {
            // Split the message parameter into list
            list msgstr=llParseString2List(message,["\n"],[]);
            // The first line is the group id, the second line is the role id
            string GROUPUUID = llList2String(msgstr,0);
            string ROLEUUID = llList2String(msgstr,1);

            llOwnerSay("Sending group_invite request...");
            LifeBotsAPI("group_invite", [
              "avatar", (string)trigger,
              "groupuuid", GROUPUUID,
              "roleuuid", ROLEUUID
            ]);
        // Avatar / Friendship
        } else if (num == AVATAR_DISPLAY_NAME) {
            llOwnerSay("Sending bot avatar display name request...");
            LifeBotsAPI("getDisplayName", [
              "uuid", (string)trigger
            ]);
        } else if (num == BOT_OFFER_TELEPORT) {
            llOwnerSay("Sending bot offer teleport request...");
            LifeBotsAPI("offer_teleport", [
              "avatar", (string)trigger,
              "message", message
            ]);
        } else if (num == TELEPORT_OFFER_ACCEPT) {
            llOwnerSay("Sending teleport offer accept request...");
            LifeBotsAPI("teleport_offer_accept", [
              "session_id", (string)trigger,
              "accept", "1"
            ]);
        } else if (num == TELEPORT_OFFER_DECLINE) {
            llOwnerSay("Sending teleport offer decline request...");
            LifeBotsAPI("teleport_offer_accept", [
              "session_id", (string)trigger,
              "accept", "0"
            ]);
        } else if (num == AVATAR_PICKS) {
            llOwnerSay("Sending bot avatar picks request...");
            LifeBotsAPI("avatar_picks", [
              "avatar", (string)trigger
            ]);
        } else if (num == AVATAR_GROUPS) {
            llOwnerSay("Sending bot avatar groups request...");
            LifeBotsAPI("avatar_groups", [
              "avatar", (string)trigger
            ]);
        } else if (num == AVATAR_GROUPS_MATCH) {
            llOwnerSay("Sending bot avatar groups match request...");

            LifeBotsAPI("avatar_groups", [
              "avatar", (string)trigger,
              "matchnames", message
            ]);
        } else if (num == AVATAR_GROUPS_SKIP) {
            llOwnerSay("Sending bot avatar groups skip request...");

            LifeBotsAPI("avatar_groups", [
              "avatar", (string)trigger,
              "skipnames", message
            ]);
        } else if (num == AVATAR_GROUPS_MATCH_SKIP) {
            llOwnerSay("Sending bot avatar groups match and skip request...");
            // Split the message parameter into list
            list matstr=llParseString2List(message,["\n"],[]);
            // The first line is the match names param, the second line is the skip names param
            string MATCHNAMES = llList2String(matstr,0);
            string SKIPNAMES = llList2String(matstr,1);

            LifeBotsAPI("avatar_groups", [
              "avatar", (string)trigger,
              "matchnames", MATCHNAMES,
              "skipnames", SKIPNAMES
            ]);
        } else if (num == AVATAR_INFO) {
            llOwnerSay("Sending bot avatar profile info request...");
            LifeBotsAPI("avatar_info", [
              "avatar", (string)trigger
            ]);
        } else if (num == BOT_UNFRIEND) {
            llOwnerSay("Sending bot unfriend request...");
            LifeBotsAPI("cancel_friendship", [
              "slkey", (string)trigger
            ]);
        } else if (num == BOT_FRIENDSHIP_CAN_EDIT) {
            llOwnerSay("Sending bot friendship can edit request...");
            LifeBotsAPI("edit_friendship", [
              "slkey", (string)trigger,
              "can_edit", message
            ]);
        } else if (num == BOT_FRIENDSHIP_SEE_ONLINE) {
            llOwnerSay("Sending bot friendship see online request...");
            LifeBotsAPI("edit_friendship", [
              "slkey", (string)trigger,
              "see_online", message
            ]);
        } else if (num == BOT_FRIENDSHIP_SEE_ON_MAP) {
            llOwnerSay("Sending bot friendship see on map request...");
            LifeBotsAPI("edit_friendship", [
              "slkey", (string)trigger,
              "see_on_map", message
            ]);
        } else if (num == BOT_OFFER_FRIENDSHIP) {
            llOwnerSay("Sending bot offer friendship request...");
            LifeBotsAPI("offer_friendship", [
              "avatar", (string)trigger,
              "message", message
            ]);
        // Money
        // TODO:
        //   BOT_LISTEN_INVENTORY_OFFER
        //   BOT_LISTEN_MONEY_PAYMENTS
        } else if (num == BOT_GIVE_MONEY_OBJECT) {
            llOwnerSay("Sending bot give money object request...");
            LifeBotsAPI("give_money_object", [
              "object_uuid", (string)trigger,
              "amount", (integer)message
            ]);
        } else if (num == BOT_GIVE_MONEY) {
            llOwnerSay("Sending bot give money request...");
            LifeBotsAPI("give_money", [
              "avatar", (string)trigger,
              "amount", (integer)message
            ]);
        } else if (num == BOT_GET_BALANCE) {
            llOwnerSay("Sending bot get balance request...");
            LifeBotsAPI("get_balance", [ ]);
        // Inventory
        } else if (num == BOT_NOTECARD_EDIT) {
            llOwnerSay("Sending bot notecard edit request...");
            LifeBotsAPI("notecard_edit", [
              "uuid", (string)trigger,
              "text", message
            ]);
        } else if (num == BOT_NOTECARD_READ) {
            llOwnerSay("Sending bot notecard read request...");
            LifeBotsAPI("notecard_read", [
              "uuid", (string)trigger
            ]);
        } else if (num == BOT_NOTECARD_CREATE) {
            llOwnerSay("Sending bot notecard create request...");
            LifeBotsAPI("notecard_create", [
              "name", (string)trigger,
              "text", message
            ]);
        } else if (num == BOT_INVENTORY_DELETE) {
            llOwnerSay("Sending bot inventory delete request...");
            LifeBotsAPI("inventory_delete", [
              "uuid", (string)trigger
            ]);
        } else if (num == BOT_GIVE_INVENTORY) {
            llOwnerSay("Sending bot give inventory request...");
            LifeBotsAPI("give_inventory", [
              "avatar", (string)trigger,
              "object", message
            ]);
        // Bot Appearance
        } else if (num == BOT_ATTACHMENTS) {
            llOwnerSay("Sending bot attachments request...");
            LifeBotsAPI("attachments", [ ]);
        } else if (num == BOT_REBAKE) {
            llOwnerSay("Sending bot rebake request...");
            LifeBotsAPI("rebake", [ ]);
        } else if (num == BOT_WEAR) {
            llOwnerSay("Sending bot wear inventory item request...");
            LifeBotsAPI("wear", [
              "uuid", (string)trigger,
              "wear", message
            ]);
        } else if (num == BOT_TAKEOFF) {
            llOwnerSay("Sending bot remove worn item request...");
            LifeBotsAPI("takeoff", [
              "uuid", (string)trigger
            ]);
        // Sim Management
        // TODO: BOT_SIM_ACCESS_ALL_ESTATES
        } else if (num == REGION_INFO) {
            llOwnerSay("Sending region info request...");
            LifeBotsAPI("region_info", [ ]);
        } else if (num == SIM_RETURN_OBJECTS) {
            llOwnerSay("Sending sim return objects request...");
            if (message == "all_estates") {
                LifeBotsAPI("sim_return", [
                  "avatar", (string)trigger,
                  "all_estates", 1
                ]);
            } else {
                LifeBotsAPI("sim_return", [
                  "avatar", (string)trigger
                ]);
            }
        } else if (num == SIM_RETURN_SCRIPTED_OBJECTS) {
            llOwnerSay("Sending sim return scripted objects request...");
            if (message == "all_estates") {
                LifeBotsAPI("sim_return", [
                  "avatar", (string)trigger,
                  "scripted", 1,
                  "all_estates", 1
                ]);
            } else {
                LifeBotsAPI("sim_return", [
                  "avatar", (string)trigger,
                  "scripted", 1
                ]);
            }
        } else if (num == SIM_RETURN_OTHERS_OBJECTS) {
            llOwnerSay("Sending sim return others objects request...");
            if (message == "all_estates") {
                LifeBotsAPI("sim_return", [
                  "avatar", (string)trigger,
                  "others", 1,
                  "all_estates", 1
                ]);
            } else {
                LifeBotsAPI("sim_return", [
                  "avatar", (string)trigger,
                  "others", 1
                ]);
            }
        } else if (num == BOT_SIM_ACCESS) {
            llOwnerSay("Sending bot sim access request...");
            LifeBotsAPI("sim_access", [
              "avatar", (string)trigger,
              "operation", message
            ]);
        } else if (num == BOT_SIM_SEND_MESSAGE) {
            llOwnerSay("Sending bot sim send message request...");
            LifeBotsAPI("sim_send_message", [
              "message", message
            ]);
        } else if (num == BOT_SIM_RESTART_START) {
            llOwnerSay("Sending bot sim restart request...");
            LifeBotsAPI("sim_send_message", [
              "message", "Restarting simulator in " + message + " seconds!"
            ]);
            LifeBotsAPI("sim_restart", [
              "state", "schedule",
              "delay", (integer)message
            ]);
        } else if (num == BOT_SIM_RESTART_STOP) {
            llOwnerSay("Sending bot sim cancel restart request...");
            LifeBotsAPI("sim_send_message", [
              "message", "Cancelling simulator restart"
            ]);
            LifeBotsAPI("sim_restart", [
              "state", "cancel",
              "delay", 0
            ]);
        } else if (num == BOT_SIM_KICK) {
            llOwnerSay("Sending bot sim kick request...");
            LifeBotsAPI("sim_kick", [
              "avatar", (string)trigger
            ]);
        // Miscellaneous commands
        // TODO: BOT_LISTEN_DIALOG
        } else if (num == BOT_DIALOG_REPLY) {
            // Split the message parameter into list
            list repstr=llParseString2List(message,["\n"],[]);
            // The first line is the channel, the second line is the button text
            string CHANNEL = llList2String(repstr,0);
            string BUTTON = llList2String(repstr,1);
            llOwnerSay("Sending bot reply dialog request...");
            LifeBotsAPI("reply_dialog", [
              "object", (string)trigger,
              "channel", CHANNEL,
              "button", BUTTON
            ]);
        } else if (num == BOT_TOUCH_OBJECT) {
            llOwnerSay("Sending bot touch object request...");
            LifeBotsAPI("touch_prim", [
              "uuid", (string)trigger
            ]);
        } else if (num == BOT_ATTACHMENT_OBJECT) {
            llOwnerSay("Sending bot touch attachment request...");
            LifeBotsAPI("touch_attachment", [
              "objectname", message
            ]);
        // LifeBots API Extensions
        // TODO: object search needs guidance on interface
        } else if (num == NAME_TO_UUID) {
            llOwnerSay("Sending display name to UUID request...");
            LifeBotsAPI("name2key", [
              "name", message
            ]);
        } else if (num == UUID_TO_NAME) {
            llOwnerSay("Sending UUID to display name request...");
            if ((message == "0") || (message == "1")) {
                LifeBotsAPI("key2name", [
                  "key", (string)trigger,
                  "request_case", message
                ]);
            } else {
                LifeBotsAPI("key2name", [
                  "key", (string)trigger
                ]);
            }
        } else if (num == FIND_OBJECTS) {
            integer range = 96;
            if (message != "") {
                range = (integer)message;
            }
            llOwnerSay("Sending bot find objects request...");
            LifeBotsAPI("find_objects", [
              "range", range
            ]);
        } else if (num == FIND_OBJECTS_WITH_PROP) {
            integer prop = 96;
            if (message != "") {
                prop = (integer)message;
            }
            llOwnerSay("Sending bot find objects with props request...");
            LifeBotsAPI("find_objects", [
              "range", prop,
              "with_props", "1"
            ]);
        } else if (num == FIND_OBJECTS_PARCEL) {
            llOwnerSay("Sending bot find objects parcel request...");
            LifeBotsAPI("find_objects", [
              "current_parcel", "1"
            ]);
        } else if (num == FIND_OBJECT_UUID) {
            llOwnerSay("Sending bot find object uuid request...");
            LifeBotsAPI("find_objects", [
              "uuid", (string)trigger
            ]);
        // Groups
        } else if (num == GROUP_OFFER_ACCEPT) {
            llOwnerSay("Sending bot group offer accept request...");
            LifeBotsAPI("group_offer_accept", [
              "session_id", (string)trigger,
              "avatar_uuid", message,
              "accept", "1"
            ]);
        } else if (num == GROUP_OFFER_DECLINE) {
            llOwnerSay("Sending bot group offer decline request...");
            LifeBotsAPI("group_offer_accept", [
              "session_id", (string)trigger,
              "avatar_uuid", message,
              "accept", "0"
            ]);
        } else if (num == GROUP_VISIBILITY) {
            string profile = "1";
            if (message == "0") {
                profile = message;
            }
            llOwnerSay("Sending bot group visibility request...");
            LifeBotsAPI("group_visibility", [
              "groupuuid", (string)trigger,
              "profile", profile
            ]);
        } else if (num == LIST_GROUPS_UUID) {
            llOwnerSay("Sending bot list groups by uuid request...");
            LifeBotsAPI("listgroups", [
              "limit_uuid", (string)trigger
            ]);
        } else if (num == LIST_GROUPS_NAME) {
            llOwnerSay("Sending bot list groups by name request...");
            LifeBotsAPI("listgroups", [
              "limit_name", message
            ]);
        } else if (num == GROUP_INFO) {
            llOwnerSay("Sending bot group info request...");
            LifeBotsAPI("group_info", [
              "groupuuid", (string)trigger
            ]);
        } else if (num == LIST_GROUP_MEMBERS) {
            llOwnerSay("Sending bot list group members request...");
            LifeBotsAPI("get_group_members", [
              "groupuuid", (string)trigger
            ]);
        // Inventory
        } else if (num == TAKE_DELETE_OBJECT) {
            llOwnerSay("Sending bot take or delete object request...");
            LifeBotsAPI("inworld_prim_take", [
              "uuid", (string)trigger,
              "operation", message
            ]);
        } else if (num == LIST_OUTFITS) {
            llOwnerSay("Sending bot list outfits request...");
            LifeBotsAPI("get_outfits", [ ]);
        } else if (num == GET_WORN_OUTFIT) {
            llOwnerSay("Sending bot get worn outfit request...");
            LifeBotsAPI("get_outfit", [ ]);
        } else if (num == WEAR_OUTFIT) {
            llOwnerSay("Sending bot wear outfit request...");
            LifeBotsAPI("wear_outfit", [
              "outfitname", message
            ]);
        } else if (num == INVENTORY_TO_OBJECT) {
            llOwnerSay("Sending bot transfer inventory to object request...");
            LifeBotsAPI("inventory_to_prim", [
              "prim_uuid", (string)trigger,
              "object_uuid", message
            ]);
        } else if (num == LIST_INVENTORY) {
            llOwnerSay("Sending bot list inventory request...");
            integer ext = stringToBoolean(message);
            if (trigger == NULL_KEY) {
                LifeBotsAPI("listinventory", [
                  "extended", ext
                ]);
            } else {
                LifeBotsAPI("listinventory", [
                  "uuid", (string)trigger,
                  "extended", ext
                ]);
            }
        // Miscellaneous
        } else if (num == ADJUST_HOVER_HEIGHT) {
            llOwnerSay("Sending bot adjust hover height request...");
            LifeBotsAPI("set_hoverheight", [
              "height", (float)message
            ]);
        } else {
            // TODO: which others did we not catch in this link_message event
            if (num > 250000) {
              if ((num != BOT_SETUP_SUCCESS) && (num != BOT_SETUP_FAILED) && (num != BOT_JSON_RESPONSE)) {
                llOwnerSay("Unsupported API request: num=" + (string)num + ", message=" + message);
              }
            }
        }
    }

}
