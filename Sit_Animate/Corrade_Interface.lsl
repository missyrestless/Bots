///////////////////////////////////////////////////////
//  Copyright (C) 2013-2015 Wizardry and Steamworks  //
//  Copyright (C) 2025      Truth & Beauty Lab       //
//  License: GNU GPLv3                               //
///////////////////////////////////////////////////////
//
// This is an automatic teleporter, and sitter for the Corrade
// Second Life / OpenSim bot. You can find more details about the bot
// by following the URL: http://was.fm/secondlife/scripted_agents/corrade
//
// The sit script works together with a "Corrade-Configuration" notecard
// The purpose of this script is to demonstrate sitting with Corrade and 
// you are free to use, change, and commercialize it under the GNU/GPLv3 
// license at: http://www.gnu.org/licenses/gpl.html
//
///////////////////////////////////////////////////////////////////////////

string wasKeyValueGet(string k, string data) {
    if(llStringLength(data) == 0) return "";
    if(llStringLength(k) == 0) return "";
    list a = llParseString2List(data, ["&", "="], []);
    integer i = llListFindList(llList2ListStrided(a, 0, -1, 2), [ k ]);
    if(i != -1) return llList2String(a, 2*i+1);
    return "";
}
 
string wasKeyValueEncode(list data) {
    list k = llList2ListStrided(data, 0, -1, 2);
    list v = llList2ListStrided(llDeleteSubList(data, 0, 0), 0, -1, 2);
    data = [];
    do {
        data += llList2String(k, 0) + "=" + llList2String(v, 0);
        k = llDeleteSubList(k, 0, 0);
        v = llDeleteSubList(v, 0, 0);
    } while(llGetListLength(k) != 0);
    return llDumpList2String(data, "&");
}

vector wasCirclePoint(float radius) {
    float x = llPow(-1, 1 + (integer) llFrand(2)) * llFrand(radius*2);
    float y = llPow(-1, 1 + (integer) llFrand(2)) * llFrand(radius*2);
    if(llPow(x,2) + llPow(y,2) <= llPow(radius,2))
        return <x, y, 0>;
    return wasCirclePoint(radius);
}

// escapes a string in conformance with RFC1738
string wasURLEscape(string i) {
    string o = "";
    do {
        string c = llGetSubString(i, 0, 0);
        i = llDeleteSubString(i, 0, 0);
        if(c == "") jump continue;
        if(c == " ") {
            o += "+";
            jump continue;
        }
        if(c == "\n") {
            o += "%0D" + llEscapeURL(c);
            jump continue;
        }
        o += llEscapeURL(c);
@continue;
    } while(i != "");
    return o;
}

// Corrade data
string CORRADE = "";
string GROUP = "";
string PASSWORD = "";
string LOCK = "";
string DEBUG = "";

// Whether the notification bind has been performed
integer bound = FALSE;
// whether to output debug messages to the owner
integer debug = FALSE;
// whether the avatar has been seated
integer seated = FALSE;
// whether the avatar should be locked to the seat
integer unlocked = TRUE;

// for holding the callback URL
string callback = "";

// for notecard reading
integer line = 0;

// key-value data will be read into this list
list tuples = [];
 
default {
    state_entry() {
        if(llGetInventoryType("Corrade-Configuration") != INVENTORY_NOTECARD) {
            llOwnerSay("ERROR: Could not find an inventory notecard.");
            return;
        }
        if (debug) {
            llOwnerSay("Reading Corrade-Configuration file...");
        }
        llGetNotecardLine("Corrade-Configuration", line);
    }
    dataserver(key id, string data) {
        if(data == EOF) {
            // invariant, length(tuples) % 2 == 0
            if(llGetListLength(tuples) % 2 != 0) {
                llOwnerSay("Error in Corrade-Configuration notecard.");
                return;
            }
            CORRADE = llList2String(
                          tuples,
                          llListFindList(
                              tuples, 
                              [
                                  "corrade"
                              ]
                          )
                      +1);
            if(CORRADE == "") {
                llOwnerSay("Error in Corrade-Configuration notecard: corrade");
                return;
            }
            GROUP = llList2String(
                          tuples,
                          llListFindList(
                              tuples, 
                              [
                                  "group"
                              ]
                          )
                      +1);
            if(GROUP == "") {
                llOwnerSay("Error in Corrade-Configuration notecard: group");
                return;
            }
            PASSWORD = llList2String(
                          tuples,
                          llListFindList(
                              tuples, 
                              [
                                  "password"
                              ]
                          )
                      +1);
            if(PASSWORD == "") {
                llOwnerSay("Error in Corrade-Configuration notecard: password");
                return;
            }
            LOCK = llList2String(
                          tuples,
                          llListFindList(
                              tuples, 
                              [
                                  "lock"
                              ]
                          )
                      +1);
            if(LOCK == "") {
                // default to release after first sit
                LOCK = "no";
            }
            if(LOCK == "yes" || LOCK == "YES") {
                unlocked = FALSE;
            }
            DEBUG = llList2String(
                          tuples,
                          llListFindList(
                              tuples, 
                              [
                                  "debug"
                              ]
                          )
                      +1);
            if(DEBUG == "") {
                // default: no debug messages
                DEBUG = "no";
            }
            if(DEBUG == "yes" || DEBUG == "YES") {
                debug = TRUE;
            }
            if (debug) {
                llOwnerSay("Read Corrade-Configuration file...");
            }
            state url;
        }
        if(data == "") jump continue;
        integer i = llSubStringIndex(data, "#");
        if(i != -1) data = llDeleteSubString(data, i, -1);
        list o = llParseString2List(data, ["="], []);
        // get rid of starting and ending quotes
        string k = llDumpList2String(
            llParseString2List(
                llStringTrim(
                    llList2String(
                        o, 
                        0
                    ), 
                STRING_TRIM), 
            ["\""], []
        ), "\"");
        string v = llDumpList2String(
            llParseString2List(
                llStringTrim(
                    llList2String(
                        o, 
                        1
                    ), 
                STRING_TRIM), 
            ["\""], []
        ), "\"");
        if(k == "" || v == "") jump continue;
        tuples += k;
        tuples += v;
@continue;
        llGetNotecardLine("Corrade-Configuration", ++line);
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if((change & CHANGED_INVENTORY) || (change & CHANGED_REGION_START)) {
            llResetScript();
        }
    }
}
 
state url {
    state_entry() {
        if (debug) {
            llOwnerSay("Requesting URL...");
        }
        llRequestURL();
    }
    http_request(key id, string method, string body) {
        if(method != URL_REQUEST_GRANTED) return;
        callback = body;
        if (debug) {
            llOwnerSay("Got URL...");
        }
        state detect;
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if((change & CHANGED_INVENTORY) || (change & CHANGED_REGION_START)) {
            llResetScript();
        }
    }
}
 
state detect {
    state_entry() {
        if (debug) {
            if (seated) {
                llOwnerSay("Detecting if Corrade goes offline...");
            } else {
                llOwnerSay("Detecting if Corrade is online...");
            }
        }
        llSetTimerEvent(30);
    }
    timer() {
        llRequestAgentData((key)CORRADE, DATA_ONLINE);
    }
    dataserver(key id, string data) {
        if(data != "1") {
            if (debug) {
                llOwnerSay("Corrade is not online, sleeping...");
            }
            seated = FALSE;
            bound = FALSE;
            llSetTimerEvent(60);
            return;
        }
        llSensorRepeat("", (key)CORRADE, AGENT, 10, TWO_PI, 1);
    }
    no_sensor() {
        if (seated && unlocked) {
            llSetTimerEvent(0);
            state main;
        } else {
            if (debug) {
                llOwnerSay("Teleporting Corrade...");
            }
            llInstantMessage((key)CORRADE, 
                wasKeyValueEncode(
                    [
                        "command", "teleport",
                        "group", wasURLEscape(GROUP),
                        "password", wasURLEscape(PASSWORD),
                        "entity", "region",
                        "region", wasURLEscape(llGetRegionName()),
                        "position", wasURLEscape(
                            (string)(
                                llGetPos() + wasCirclePoint(1)
                            )
                        ),
                        "callback", callback
                    ]
                )
            );
        }
    }
    sensor(integer num) {
        llSetTimerEvent(0);
        if (bound) {
            state main;
        } else {
            state notify;
        }
    }
    http_request(key id, string method, string body) {
        llHTTPResponse(id, 200, "OK");
        if(wasKeyValueGet("command", body) != "teleport" ||
            wasKeyValueGet("success", body) != "True") {
            if (debug) {
                llOwnerSay("Teleport failed...");
            }
            return;
        }
        llSetTimerEvent(0);
        state main;
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if((change & CHANGED_INVENTORY) || (change & CHANGED_REGION_START)) {
            llResetScript();
        }
    }
}
 
state notify {
    state_entry() {
        if (debug) {
            llOwnerSay("Binding to the permission Corrade notification...");
        }
        llInstantMessage(
            (key)CORRADE, 
            wasKeyValueEncode(
                [
                    "command", "notify",
                    "group", wasURLEscape(GROUP),
                    "password", wasURLEscape(PASSWORD),
                    "action", "add",
                    "type", "permission",
                    "URL", wasURLEscape(callback),
                    "callback", wasURLEscape(callback)
                ]
            )
        );
        llSetTimerEvent(60);
    }
    http_request(key id, string method, string body) {
        llHTTPResponse(id, 200, "OK");
        if(wasKeyValueGet("command", body) != "notify" ||
            wasKeyValueGet("success", body) != "True") {
            if (debug) {
                llOwnerSay("Failed to bind to the permission notification...");
            }
            state detect;
        }
        if (debug) {
            llOwnerSay("Permission notification installed...");
        }
        bound = TRUE;
        llSetTimerEvent(0);
        state main;
    }
    timer() {
        llSetTimerEvent(0);
        if (debug) {
            llOwnerSay("Timeout binding to permission notification...");
        }
        state detect;
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if((change & CHANGED_INVENTORY) || (change & CHANGED_REGION_START)) {
            llResetScript();
        }
    }
}
 
state main {
    state_entry() {
        if (debug) {
            llOwnerSay("Waiting...");
        }
        llSensorRepeat("", (key)CORRADE, AGENT, 10, TWO_PI, 1);
        llSetTimerEvent(60);
    }
    sensor(integer num) {
        // Corrade is already sitting. Detect when offline.
        if(llAvatarOnSitTarget() == (key)CORRADE) {
            seated = TRUE;
            return;
        }
        if (seated && unlocked) {
            return;
        } else {
            if (debug) {
                llOwnerSay("Sending sit command...");
            }
            llInstantMessage((key)CORRADE, 
                wasKeyValueEncode(
                    [
                        "command", "sit",
                        "group", wasURLEscape(GROUP),
                        "password", wasURLEscape(PASSWORD),
                        "item", wasURLEscape(
                            llGetKey()
                        ),
                        "range", 10
                    ]
                )
            );
            seated = TRUE;
            llSensorRepeat("", (key)CORRADE, AGENT, 10, TWO_PI, 10);
        }
    }
    no_sensor() {
        llSensorRemove();
        state detect;
    }
    http_request(key id, string method, string body) {
        llHTTPResponse(id, 200, "OK");
        if(wasKeyValueGet("type", body) != "permission" ||
            wasKeyValueGet("permissions", body) != "TriggerAnimation") return;
        if (debug) {
            llOwnerSay("Corrade received the permission request to trigger an animation, replying...");
        }
        llInstantMessage((key)CORRADE, 
            wasKeyValueEncode(
                [
                    "command", "replytoscriptpermissionrequest",
                    "group", wasURLEscape(GROUP),
                    "password", wasURLEscape(PASSWORD),
                    "action", "reply",
                    "item", wasURLEscape(wasKeyValueGet("item", body)),
                    "task", wasURLEscape(wasKeyValueGet("task", body)),
                    "permissions", "TriggerAnimation",
                    "region", wasURLEscape(wasKeyValueGet("region", body))
                ]
            )
        );
    }
    timer() {
        if(llAvatarOnSitTarget() == (key)CORRADE) {
            seated = TRUE;
            return;
        }
        if (debug) {
            llOwnerSay("Timeout during sit... Restarting...");
        }
        state detect;
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if((change & CHANGED_INVENTORY) || (change & CHANGED_REGION_START)) {
            llResetScript();
        }
    }
}
