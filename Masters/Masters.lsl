///////////////////////////////////////////////////////////////////////////
//  Copyright (C) Wizardry and Steamworks 2014 - License: CC BY 2.0      //
///////////////////////////////////////////////////////////////////////////
//
// This script is the equivalent of a C9 masters setting meant for Corrade
// version 10 where the bot will accept everything from the owner of this
// script.
//
///////////////////////////////////////////////////////////////////////////
 
///////////////////////////////////////////////////////////////////////////
//    Copyright (C) 2014 Wizardry and Steamworks - License: CC BY 2.0    //
///////////////////////////////////////////////////////////////////////////
string wasKeyValueGet(string k, string data) {
    if(llStringLength(data) == 0) return "";
    if(llStringLength(k) == 0) return "";
    list a = llParseString2List(data, ["&", "="], []);
    integer i = llListFindList(a, [ k ]);
    if(i != -1) return llList2String(a, i+1);
    return "";
}
 
///////////////////////////////////////////////////////////////////////////
//    Copyright (C) 2013 Wizardry and Steamworks - License: CC BY 2.0    //
///////////////////////////////////////////////////////////////////////////
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
 
///////////////////////////////////////////////////////////////////////////
//    Copyright (C) 2015 Wizardry and Steamworks - License: CC BY 2.0    //
///////////////////////////////////////////////////////////////////////////
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
 
///////////////////////////////////////////////////////////////////////////
//    Copyright (C) 2015 Wizardry and Steamworks - License: CC BY 2.0    //
///////////////////////////////////////////////////////////////////////////
// unescapes a string in conformance with RFC1738
string wasURLUnescape(string i) {
    return llUnescapeURL(
        llDumpList2String(
            llParseString2List(
                llDumpList2String(
                    llParseString2List(
                        i, 
                        ["+"], 
                        []
                    ), 
                    " "
                ), 
                ["%0D%0A"], 
                []
            ), 
            "\n"
        )
    );
}

///////////////////////////////////////////////////////////////////////////
//    Copyright (C) 2015 Wizardry and Steamworks - License: CC BY 2.0    //
///////////////////////////////////////////////////////////////////////////
string wasListToCSV(list l) {
    list v = [];
    do {
        string a = llDumpList2String(
            llParseStringKeepNulls(
                llList2String(
                    l, 
                    0
                ), 
                ["\""], 
                []
            ),
            "\"\""
        );
        if(llParseStringKeepNulls(
            a, 
            [" ", ",", "\n", "\""], []
            ) != 
            (list) a
        ) a = "\"" + a + "\"";
        v += a;
        l = llDeleteSubList(l, 0, 0);
    } while(l != []);
    return llDumpList2String(v, ",");
}
 
// corrade data
key CORRADE = NULL_KEY;
string GROUP = "";
string PASSWORD = "";
string TAG = "";
list SUPPORTED_NOTIFICATIONS = [
        "lure",
        "permission",
        "inventory"
];
 
// for holding the callback URL
string callback = "";
 
// for notecard reading
integer line = 0;
 
// key-value data will be read into this list
list tuples = [];
 
default {
    state_entry() {
        if(llGetInventoryType("configuration") != INVENTORY_NOTECARD) {
            llOwnerSay("Sorry, could not find a configuration inventory notecard.");
            return;
        }
        // DEBUG
        llOwnerSay("Reading configuration file...");
        llGetNotecardLine("configuration", line);
    }
    dataserver(key id, string data) {
        if(data == EOF) {
            // invariant, length(tuples) % 2 == 0
            if(llGetListLength(tuples) % 2 != 0) {
                llOwnerSay("Error in configuration notecard.");
                return;
            }
            CORRADE = llList2Key(
                tuples,
                llListFindList(
                    tuples, 
                    [
                        "corrade"
                    ]
                )
                +1
            );
            if(CORRADE == NULL_KEY) {
                llOwnerSay("Error in configuration notecard: corrade");
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
                +1
            );
            if(GROUP == "") {
                llOwnerSay("Error in configuration notecard: group");
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
                +1
            );
            if(PASSWORD == "") {
                llOwnerSay("Error in configuration notecard: password");
                return;
            }
            TAG = llList2String(
                tuples,
                llListFindList(
                    tuples, 
                    [
                        "tag"
                    ]
                )
                +1
            );
            if(TAG == "") {
                llOwnerSay("Error in configuration notecard: tag");
                return;
            }
            // DEBUG
            llOwnerSay("Read configuration notecard...");

            // GC
            tuples = [];

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
        llGetNotecardLine("configuration", ++line);
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if(change & CHANGED_OWNER) {
            llResetScript();
        }
    }
}

state url {
    state_entry() {
        // DEBUG
        llOwnerSay("Requesting URL...");
        llRequestURL();
    }
    http_request(key id, string method, string body) {
        if(method != URL_REQUEST_GRANTED) return;
        callback = body;

        // DEBUG
        llOwnerSay("Got URL.");

        state bind;
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if(change & CHANGED_OWNER) {
            llResetScript();
        }
    }
}

state bind {
    state_entry() {
        // DEBUG
        llOwnerSay("Binding to notifications: " + 
            llDumpList2String(SUPPORTED_NOTIFICATIONS, ","));

        llInstantMessage(CORRADE, 
            wasKeyValueEncode(
                [
                    "command", "notify",
                    "group", wasURLEscape(GROUP),
                    "password", wasURLEscape(PASSWORD),
                    "type", wasURLEscape(
                        wasListToCSV(
                            SUPPORTED_NOTIFICATIONS
                        )
                    ),
                    "action", "set",
                    "tag", wasURLEscape(TAG),
                    "URL", wasURLEscape(callback),
                    "callback", wasURLEscape(callback)
                ]
            )
        );

        llSetTimerEvent(60);
    }

    timer() {
        // DEBUG
        llOwnerSay("Timeout binding to notifications...");
        llResetScript();
    }
    http_request(key id, string method, string body)
    {
        llHTTPResponse(id, 200, "OK");
        if(wasKeyValueGet("command", body) != "notify") 
            return;

        if(wasKeyValueGet("success", body) != "True") {
            // DEBUG
            llOwnerSay("Failed binding to notifications: " + 
                wasURLUnescape(
                    wasKeyValueGet("error", body)
                )
            );
           llResetScript();
        }
        // DEBUG
        llOwnerSay("Notifications successfully bound...");
        state wait;
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if(change & CHANGED_OWNER) {
            llResetScript();
        }
    }
    state_exit()
    {
        llSetTimerEvent(0);
    }
}

state wait {
    http_request(key id, string method, string body) {
        llHTTPResponse(id, 200, "OK");

        string type = wasKeyValueGet("type", body);
        if(llListFindList(SUPPORTED_NOTIFICATIONS, [ type ]) == -1) 
            return;

        // DEBUG
        llOwnerSay("Got notification: " + type);
        llOwnerSay(wasURLUnescape(body));

        if(type == "permission") {
            // Only process from tasks owned by the owner of this script.
            if(wasKeyValueGet("owner", body) != llGetOwner())
                return;

            llInstantMessage(CORRADE, 
                    wasKeyValueEncode(
                        [
                            "command", "replytoscriptpermissionrequest",
                            "group", wasURLEscape(GROUP),
                            "password", wasURLEscape(PASSWORD),
                            "action", "reply",
                            "task", wasKeyValueGet("task", body),
                            "item", wasKeyValueGet("item", body),
                            "permissions", wasKeyValueGet("permissions", body),
                            "region", wasKeyValueGet("region", body)
                        ]
                    )
            );
            
            return;
        }
        
        if(type == "lure") {
            // Only process from tasks owned by the owner of this script.
            if(wasKeyValueGet("agent", body) != llGetOwner())
                return;

            llInstantMessage(CORRADE,
                wasKeyValueEncode(
                    [
                        // Decline the teleport lure from
                        // the avatar Batman Robin
                        "command", "replytoteleportlure",
                        "group", wasURLEscape(GROUP),
                        "password", wasURLEscape(PASSWORD),
                        // reply to the teleport lure
                        "action", "accept",
                        // obtained through the lure notification
                        "session", wasKeyValueGet("session", body),
                        "agent", wasKeyValueGet("agent", body)
                    ]
                )
            );

            return;
        }

        if(type == "inventory") {
            // Only process from tasks owned by the owner of this script.
            if(wasKeyValueGet("agent", body) != llGetOwner())
                return;

            llInstantMessage(CORRADE,
                wasKeyValueEncode(
                    [
                        // accept an inventory offer
                        "command", "replytoinventoryoffer",
                        "group", wasURLEscape(GROUP),
                        "password", wasURLEscape(PASSWORD),
                        "action", "accept", // decline, ignore or purge
                        // can be retrieved from the inventory notification
                        "session", wasKeyValueGet("session", body)
                    ]
                )
            );

            return;
        }

        // Add more?
    }
    on_rez(integer num) {
        llResetScript();
    }
    changed(integer change) {
        if(change & CHANGED_OWNER) {
            llResetScript();
        }
    }
    state_exit()
    {
        llSetTimerEvent(0);
    }
}
