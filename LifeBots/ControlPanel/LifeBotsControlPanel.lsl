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
integer BOT_NOTECARD_CREATE_REPLY   = 290238;   //
//////////////////////////////////////////////////
//////////////////////////////////////////////////
// LifeBots Command & Control Bridge
//////////////////////////////////////////////////

string API_URL = "https://api.lifebots.cloud/api/bot.html";
string API_KEY = "";
string BOT_NAME = "";
string BOT_SECRET = "";

string DEVICE_NAME = "";
string LOGIN_SITON = "";

// Configuration Notecard
string CONFIG_CARD = "Configuration";
integer NotecardLine;
key QueryID;

key Owner = NULL_KEY;

// 0 = debug off, 1 = debug on
integer DEBUG = 0;

// Send LifeBots HTTP API commands
LifeBotsAPI(string command, list params) {

  if (DEBUG == 1) {
    llOwnerSay("API_KEY = " + API_KEY);
    llOwnerSay("BOT_NAME = " + BOT_NAME);
    llOwnerSay("BOT_SECRET = " + BOT_SECRET);
  }
  // Populate the query data
  list query = [
    "action="  + command,
    "apikey="  + llEscapeURL(API_KEY),
    "botname=" + llEscapeURL(BOT_NAME),
    "secret="  + llEscapeURL(BOT_SECRET)
  ];
  if (DEBUG == 1) {
    llOwnerSay("API_KEY = " + API_KEY);
    llOwnerSay("BOT_NAME = " + BOT_NAME);
    llOwnerSay("BOT_SECRET = " + BOT_SECRET);
  }

  integer i;
  for(i = 0; i<llGetListLength(params); i += 2) {
    query += [ llList2String(params, i) + "=" + llEscapeURL(llList2String(params, i+1)) ];
  }

  string queryString = llDumpList2String(query, "&");

  if (DEBUG == 1) {
    llOwnerSay("API_URL = " + API_URL);
    llOwnerSay("queryString = " + queryString);
  }
 
  llHTTPRequest(API_URL, [HTTP_METHOD,"POST"], queryString);
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
    }

    on_rez(integer param)
    {
        llResetScript();
    }

    changed(integer change)
    {
        if ( change & CHANGED_INVENTORY ) {
            llResetScript();
        }
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
                        API_KEY = value;
                    } else if ( name == "LB_SECRET" ) {
                        BOT_SECRET = value;
                    } else if ( name == "LB_BOT_NAME" ) {
                        BOT_NAME = value;
                    } else if ( name == "LOGIN_SITON" ) {
                        LOGIN_SITON = value;
                    } else if ( name == "OWNER_BOT_MENU" ) {
                        OWNER_BOT_MENU = (integer)value;
                    } else if ( name == "SHOW_BOT_MENU" ) {
                        SHOW_BOT_MENU = (integer)value;
                    } else if ( name == "INVISIBLE" ) {
                        INVISIBLE = (integer)value;
                    } else if ( name == "RESTRICTED_ACCESS" ) {
                        RESTRICTED_ACCESS = (integer)value;
                    }
                }
                NotecardLine++;
                QueryID = llGetNotecardLine( CONFIG_CARD, NotecardLine );
            }
        }
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

    link_message(integer sender, integer num, string message, key trigger)
    {
        if (num == BOT_SETUP_SETBOT) {
            BOT_NAME = message;
            BOT_SECRET = (string)trigger;
            // TODO: Check Bot status and send bot setup success/failure link message
            // Check_Bot_Status();
            llMessageLinked(LINK_SET, BOT_SETUP_SUCCESS, BOT_NAME, trigger);
            // llMessageLinked(LINK_SET, BOT_SETUP_FAILED, BOT_NAME, trigger);
        } else if (num == BOT_SETUP_DEVICENAME) {
            DEVICE_NAME = message;
        } else if (num == BOT_STATUS_QUERY) {
            llOwnerSay("Sending bot status request...");
            LifeBotsAPI("status", [ ]);
        } else if (num == BOT_RESET_TOTALCONTROL) {
            llOwnerSay("Resetting " + PRODUCT);
            llResetScript();
        } else if (num == BOT_LOGIN) {
            llOwnerSay("Sending bot login request...");
            LifeBotsAPI("login", [ ]);
        } else if (num == BOT_LOGOUT) {
            llOwnerSay("Sending bot logout request...");
            LifeBotsAPI("logout", [ ]);
        } else if (num == BOT_LOCATION) {
            llOwnerSay("Sending bot location request...");
            LifeBotsAPI("bot_location", [ ]);
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
        } else if (num == BOT_OFFER_TELEPORT) {
            llOwnerSay("Sending bot offer teleport request...");
            LifeBotsAPI("offer_teleport", [
              "avatar", (string)trigger,
              "message", message
            ]);
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
        } else if (num == BOT_WALKTO) {
            llOwnerSay("Sending bot walk to request...");
            LifeBotsAPI("walkto", [
              "coords", message
            ]);
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
        } else if (num == BOT_GROUP_SET_ROLE) {
            llOwnerSay("Sending bot activate group role request...");
            LifeBotsAPI("activate_role", [
              "groupuuid", (string)trigger,
              "roleuuid", message
            ]);
        } else if (num == BOT_GROUP_EJECT) {
            llOwnerSay("Sending bot group eject request...");
            LifeBotsAPI("group_eject", [
              "groupuuid", (string)trigger,
              "avatar", message
            ]);
        } else if (num == BOT_GROUP_INVITE) {
            // llMessageLinked(LINK_SET, BOT_GROUP_INVITE, groupID + "\n" + roleID, llDetectedKey(0));
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
        } else if (num == BOT_GIVE_INVENTORY) {
            // llMessageLinked(LINK_SET, BOT_GIVE_INVENTORY, inventoryID, llDetectedKey(0));
            llOwnerSay("Sending give_inventory request...");
            LifeBotsAPI("give_inventory", [
              "avatar", (string)trigger,
              "object", message
            ]);
        }
    }

}
