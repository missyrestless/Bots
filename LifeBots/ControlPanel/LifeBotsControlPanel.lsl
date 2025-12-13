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
                                                //
// Internal                                     //
integer CONTROL_PANEL_MANAGE        = 300000;   //
integer MENU_ACCESS                 = 300001;   //
integer SET_VISIBILITY              = 300002;   //
integer SET_RESTRICTED_ACCESS       = 300003;   //
integer SET_LISTEN_HANDLE           = 300004;   //
//////////////////////////////////////////////////
//////////////////////////////////////////////////
// LifeBots Command & Control Bridge
//////////////////////////////////////////////////

string API_URL = "https://api.lifebots.cloud/api/bot.html";
string API_KEY = "";
string BOT_NAME = "";
string BOT_SECRET = "";

string _BOTNAME = "";
string DEVICE_NAME = "";
string LOGIN_SITON = "";

// Configuration Notecard
string CONFIG_CARD = "Configuration";
integer NotecardLine;
key QueryID;

key Owner = NULL_KEY;

list particle_names = [ ];
list nearby_names = [ ];
list COMMAND_NAMES = [];

integer SHOW_BOT_MENU = TRUE;
integer OWNER_BOT_MENU = FALSE;
integer INVISIBLE = FALSE; // Enable making the bot invisible
integer PART_ENABLED = FALSE; // Does the bot emit particles etc ?
integer RESTRICTED_ACCESS = 1;
integer dialog_handle = 0;
integer handle = 1;
integer enabled = 1;
float range = 20.0;

// Reused strings
string _DEFAULT = "default";
string _RESET = "Reset";
string _EXIT = "<<< Exit >>>";
string _ENABLE = "ENABLE";
string _DISABLE = "DISABLE";
string _OFF = "OFF";
string _ON = "ON";
string _GUIDE = "LifeBots Control Panel User Guide";
string OWNER_MANUAL = "LifeBots Owner Manual";
string ADDON_MANUAL = "LifeBots Add-On Manual";
string _OMAN = "Owner Doc";
string _AMAN = "Addon Doc";
string _UMAN = "User Guide";
string _LM = "Landmark";
string _INFO = "Info";
string _ABLE = "You can enable/disable";
string _EDIT = "here\nor edit the Configuration notecard to change\nthe default setting.";
string _SELECT = ".\nSelect one of the";
string _CURRENT = "is currently ";
string _ENBLED = "ENABLED\n";
string _DSBLED = "DISABLED\n";

string  _DialogMessage;
integer _DialogChannel;
list    _DialogOptions;
integer _DialogIsRoot;
key     _DialogUser;

integer _PAGENO;
integer _MAXPAGES;

string _PREVIOUS = "<<< Prev <<<";
string _NEXT = ">>> Next >>>";
string _BACK = "<<< Back <<<";
string _SPACE = " ";

list _NavigationRoot = [_PREVIOUS, _SPACE, _NEXT, _EXIT];
list _Navigation = [_BACK, _PREVIOUS, _NEXT, _EXIT];

string _MAIN = "Main";
string _SPARKLE = "Scan_n_Sparkle";
string _POSITION = "Position";
string _ADJUST = "Adjust";
string _DOC = "Help";
string _VISIBLE = "Visibility";
string _COMMANDS = "Commands";
string _INNER = "InnerSpheres";
string _IS = "Inner Spheres";
string _STOP = "Stop";
string _START = "Start";
string _FLEX = "Flexible";
string _SIZE = "Size";
string _SPEED = "Speed";
string _FADE = "Fade";
string _TEXTURE = "Texture";
string _GEOMETRY = "Geometry";
string _PARTICLES = "Particles";
string _SCAN = "Scan";
string _RANGE = "Range";
string _AGENT = "Avatars";
string _ACTIVE = "Active";
string _PASSIVE = "Passive";
string _SCRIPTED = "Scripted";
string _TARGET = "LaserTarget";
string _SARGET = "Scan Results";
string _RAIN = "Rain";
string _SNOW = "Snow";
string _BUBBLES = "Bubbles";
string _SOUND = "Sound";
string _SOFT = "Softness";
string _GRAV = "Gravity";
string _FRIC = "Friction";
string _WIND = "Wind";
string _TENSION = "Tension";
string _FORCE = "Force";
string _TINY = "Tiny";
string _SMALL = "Small";
string _MEDIUM = "Medium";
string _LARGE = "Large";
string _XL = "XL";
string _XXL = "XXL";
string _SLOWEST = "Slowest";
string _SLOWER = "Slower";
string _SLOW = "Slow";
string _FAST = "Fast";
string _FASTER = "Faster";
string _FASTEST = "Fastest";
string _SPHERES = "Sphere";
string _PRISM = "Prism";
string _CYLINDER = "Cylinder";
string _BOX = "Box";
string _TORUS = "Torus";
string _TUBE = "Tube";
string _RING = "Ring";
string _ALL = "All";
string _ROOT = "Root Only";
string _CHILD = "Children";
list Z_1 = [ _EXIT, "0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9" ];
list TEN = [ _EXIT, "1.0","2.0","3.0","4.0","5.0","6.0","7.0","8.0","9.0" ];
list SLOW_FAST = [ _SPACE, _EXIT, _SLOWEST, _SLOWER, _SLOW, _FAST, _FASTER, _FASTEST ];
list ON_OFF = [ _SPACE, _EXIT, _ON, _SPACE, _OFF ];

// List of the menus in the system
list _NavigationMenus = [ _MAIN, _ADJUST, _POSITION, _RANGE, _SCAN, _VISIBLE, _INNER, _FLEX, _SIZE, _SPEED, _FADE, _SOUND, _BUBBLES, _SNOW, _RAIN, _PARTICLES, _TEXTURE, _GEOMETRY, _GRAV, _SOFT, _FRIC, _WIND, _FORCE, _TENSION ];

list _NavigationStack;        // Manages the menus calling submenus

ShowDialogInitial( string aMessage, list aOptions, key aAvatar ) {

    _PAGENO = -1;
    _MAXPAGES = 0;

    _DialogIsRoot = ( llGetListLength(_NavigationStack) <= 1 );
    _DialogOptions = aOptions;
    _DialogMessage = aMessage;
    
    _DialogUser = aAvatar;
    
    ShowDialog();
}

ShowDialog() {
    if ((llGetListLength(_DialogOptions) <= 12) && (_DialogIsRoot)) {
        llDialog(_DialogUser, _DialogMessage, _DialogOptions, _DialogChannel );
    } else if ((llGetListLength(_DialogOptions) <= 10) && (!_DialogIsRoot)) {
        llDialog(_DialogUser, _DialogMessage, [_BACK, _EXIT] +
                                               _DialogOptions, _DialogChannel );
    } else {
        if ( _PAGENO < 0 ) {
            _PAGENO = 1;
            _MAXPAGES = (llGetListLength(_DialogOptions)-1) / 8 + 1;
        } else if ( _PAGENO == 0 ) {
            _PAGENO = _MAXPAGES;
        } else if ( _PAGENO > _MAXPAGES ) {
            _PAGENO = 1;
        }
        
        integer I=0;
        list ELEMENTS = [];
        integer START = (_PAGENO-1)*8;
        integer END = START + 8;
        if ( END > llGetListLength(_DialogOptions) )
            END = llGetListLength(_DialogOptions);
            
        for ( I=START; I < END; I++ ) {
            ELEMENTS += [llList2String(_DialogOptions,I)];
        }

        if ( _DialogIsRoot ) 
            ELEMENTS = _NavigationRoot + ELEMENTS;
        else
            ELEMENTS = _Navigation + ELEMENTS;

        llDialog(_DialogUser, _DialogMessage, ELEMENTS, _DialogChannel );
    }
}

ReshowCurrentMenu( key aAvatarKey ) {
    integer IDX = llGetListLength( _NavigationStack ) - 1;
    string CurrentMenu = llList2String( _NavigationStack, IDX );

    MenuStarter( CurrentMenu, aAvatarKey, FALSE );
}

PopBack( key aAvatarKey ) {
    // Strip off current menu
    integer IDX = llGetListLength( _NavigationStack ) - 1;
    
    // Get the current menu
    string CurrentMenu = llList2String( _NavigationStack, IDX - 1);

    // Strip off top and current menu. Why?
    // Because we re-add it with a call to MenuStarter
    _NavigationStack = llListReplaceList( _NavigationStack, [], IDX-1, IDX );

    MenuStarter( CurrentMenu, aAvatarKey, TRUE );
}

ListenHandler( string aMenu, string aButton, string aAvatarName, key aAvatarKey ) {
    
    if ( aButton == _PREVIOUS ) {       // Previous Page
        _PAGENO--;
        ShowDialog();

    } else if ( aButton == _NEXT ) {    // Previous Page
        _PAGENO++;
        ShowDialog();

    } else if ( aButton == _SPACE ) {
        ShowDialog();

    } else if ( aButton == _BACK ) {
        PopBack( aAvatarKey );

    } else if ( llListFindList( _NavigationMenus, [aButton] ) >= 0 ) {
        MenuStarter( aButton, aAvatarKey, TRUE );
        
    } else if ( MenuListen( aMenu, aButton, aAvatarName, aAvatarKey ) ) {
        ReshowCurrentMenu( aAvatarKey );        
    }
}

ShowMainMenu( key aAvatarKey ) {
    if (enabled) {
        _NavigationStack = [];
        MenuStarter( _MAIN, aAvatarKey, TRUE );
    }
}

MenuStarter( string aMenu, key aID, integer aPush ) {

    string DialogMessage = PRODUCT + ", version " + VERSION ;
    list   DialogOptions;

    if ( aMenu == _MAIN ) {
        DialogOptions = [];
        DialogMessage = "Main Menu - " +  PRODUCT;
        if (handle)
            DialogOptions = DialogOptions + [ _OFF ];
        else
            DialogOptions = DialogOptions + [ _ON ];
        if (llGetInventoryType(_IS) == INVENTORY_SCRIPT)
            DialogOptions = DialogOptions + [ _INNER ];
        if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
            DialogOptions = DialogOptions + [ _COMMANDS, _PARTICLES ];
        if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
            DialogOptions = DialogOptions + [ _SCAN, _TARGET ];
        if ((SHOW_BOT_MENU) && (_BOTNAME != "")) {
            if ((aID == Owner) || ((RESTRICTED_ACCESS == 2) && llSameGroup(aID))) {
                DialogOptions = DialogOptions + [ _VISIBLE, _DOC, _RESET ];
            } else {
                DialogOptions = [ _EXIT, _DOC ];
                if (llGetInventoryType(OWNER_MANUAL)==7)
                    DialogOptions = DialogOptions + [ _OMAN ];
                if (llGetInventoryType(ADDON_MANUAL)==7)
                    DialogOptions = DialogOptions + [ _AMAN ];
                if (llGetInventoryType(_GUIDE)==7)
                    DialogOptions = DialogOptions + [ _UMAN ];
                if (llGetInventoryType(
                    llGetInventoryName(INVENTORY_LANDMARK, 0)) == 3)
                    DialogOptions = DialogOptions + [ _LM ];
                if (llGetInventoryType(
                    llGetInventoryName(INVENTORY_NOTECARD, 0)) == 7)
                    DialogOptions = DialogOptions + [ _INFO ];
                if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
                    DialogOptions = DialogOptions + [ _COMMANDS ];
            }
          } else {
              DialogOptions = DialogOptions + [ _VISIBLE, _DOC, _RESET ];
          }
    } else if ( aMenu == _INNER ) {
        DialogMessage = _IS + " menu: configure rotating display.";
        DialogOptions = [ _STOP, _FLEX, _START, _SIZE, _FADE, _SPEED, _TEXTURE, _GEOMETRY, _PARTICLES, _SOUND ];
    } else if ( aMenu == _FLEX ) {
        DialogMessage = _IS + " Flexibility:";
        DialogOptions = [ _SPACE, _SOFT, _GRAV, _FRIC, _WIND, _TENSION, _FORCE ];
    } else if ( aMenu == _SIZE ) {
        DialogMessage = _IS + " Size:";
        DialogOptions = [ _SPACE, _TINY, _SMALL, _MEDIUM, _LARGE, _XL, _XXL ];
    } else if ( aMenu == _FADE ) {
        DialogMessage = _IS + " Fade:";
        DialogOptions = SLOW_FAST;
    } else if ( aMenu == _SPEED ) {
        DialogMessage = _IS + " Speed:";
        DialogOptions = SLOW_FAST;
    } else if ( aMenu == _PARTICLES ) {
        if (llGetInventoryType(_IS) == INVENTORY_SCRIPT) {
            DialogMessage = _IS + " Particles:";
            DialogOptions = [ _ON, _OFF, _BUBBLES, _RAIN, _SNOW, _TARGET, _ALL, "Inward", "Outward" ] + particle_names;
        }
        else if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT) {
            DialogMessage = _SPARKLE + " Particles:";
            DialogOptions = [ _ENABLE, _DISABLE ] + COMMAND_NAMES;
        }
        else {
            DialogMessage = "Particles feature not present.";
            DialogOptions = [];
        }

    } else if ( aMenu == _RAIN ) {
        DialogMessage = _IS + " Rain:";
        DialogOptions = ON_OFF;
    } else if ( aMenu == _SNOW ) {
        DialogMessage = _IS + " Snow:";
        DialogOptions = ON_OFF;
    } else if ( aMenu == _BUBBLES ) {
        DialogMessage = _IS + " Bubbles:";
        DialogOptions = ON_OFF;
    } else if ( aMenu == _SOUND ) {
        DialogMessage = _IS + " Sound:";
        DialogOptions = ON_OFF;
    } else if ( aMenu == _GEOMETRY ) {
        DialogMessage = _IS + " Geometry:";
        DialogOptions = [ _SPHERES, _PRISM, _CYLINDER, _BOX, _TORUS, _TUBE, _RING, _ALL, _ROOT, _CHILD ];
    } else if ( aMenu == _TEXTURE ) {
        DialogMessage = _IS + " Texture:";
        DialogOptions = [_STOP, "Last Texture", _START, "Next Texture"];
    } else if ( aMenu == _GRAV ) {
        DialogMessage = _IS + " Gravity:";
        DialogOptions = Z_1;
    } else if ( aMenu == _SOFT ) {
        DialogMessage = _IS + " Softness:";
        DialogOptions = [ "1", "2", "3", "4", "5", "6", "7", "8", "9" ];
    } else if ( aMenu == _FRIC ) {
        DialogMessage = _IS + " Friction:";
        DialogOptions = TEN;
    } else if ( aMenu == _WIND ) {
        DialogMessage = _IS + " Wind:";
        DialogOptions = Z_1;
    } else if ( aMenu == _TENSION ) {
        DialogMessage = _IS + " Tension:";
        DialogOptions = TEN;
    } else if ( aMenu == _FORCE ) {
        DialogMessage = _IS + " Force:";
        DialogOptions = Z_1;
    } else if ( aMenu == _VISIBLE ) {
        DialogMessage = "Visibility Menu: set LifeBot visible/invisible";
        DialogMessage = DialogMessage + "\nLifeBot " + _CURRENT;
        if (INVISIBLE)
          DialogMessage = DialogMessage + "invisible\n";
        else
          DialogMessage = DialogMessage + "visible\n";
        DialogMessage = DialogMessage + _ABLE + " visibility " + _EDIT;
        DialogOptions = [];
        if (INVISIBLE)
            DialogOptions = DialogOptions + ["Visible"];
        else
            DialogOptions = DialogOptions + ["Invisible"];
    } else if ( aMenu == _RANGE ) {
        DialogMessage = "\nSelect the range of scans (in meters).\nRange " + _CURRENT + (string)range + " meters.";
        DialogOptions = ["2.0", "5.0", "10.0", "20.0", "30.0", "40.0", "50.0", "60.0", "70.0", "80.0", "90.0"];
    } else if ( aMenu == _SCAN ) {
        DialogMessage = "\nScan the area for objects or avatars:";
        DialogOptions = [_RANGE, _AGENT, _ACTIVE, _PASSIVE, _SCRIPTED, _ALL];
    } else if ( aMenu == _PARTICLES ) {
        DialogMessage = "\nParticle displays and chat commands " + _CURRENT;
        if (PART_ENABLED)
          DialogMessage = DialogMessage + _ENBLED;
        else
          DialogMessage = DialogMessage + _DSBLED;
        DialogMessage = DialogMessage + _ABLE + " displays & commands " + _EDIT;
        DialogOptions = [];
        if (PART_ENABLED)
            DialogOptions = DialogOptions + [ _DISABLE ];
        else
            DialogOptions = DialogOptions + [ _ENABLE ];
    } else if ( aMenu == _COMMANDS ) {
        DialogMessage = _SELECT + _SPACE + _BOTNAME + " command";
        if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT) {
            DialogMessage = _SELECT + " commands";
            DialogOptions = COMMAND_NAMES;
        }
    } else {
        return;
    }

    if ( aPush ) {
        _NavigationStack += [ aMenu ];
    }

    ShowDialogInitial( "\n" + DialogMessage, DialogOptions, aID );
}

integer MenuListen( string aMenu, string aButton, string aAvatarName, key aAvatarKey ) {
    integer RESHOWDIALOG = TRUE;

    if ( aButton == _EXIT ) {
            return FALSE;
    }
    if ( aMenu == _MAIN ) {
        if (( aButton == _OFF ) || ( aButton == _ON )) {
            llMessageLinked(LINK_THIS, CONTROL_PANEL_MANAGE, aButton, aMenu);
            return FALSE;
        } else if ( aButton == _DOC ) {
            if (llGetInventoryType(OWNER_MANUAL) == 7)
                 llGiveInventory(aAvatarKey, OWNER_MANUAL);
            if (llGetInventoryType(ADDON_MANUAL) == 7)
                 llGiveInventory(aAvatarKey, ADDON_MANUAL);
            if (llGetInventoryType(_GUIDE) == 7)
                 llGiveInventory(aAvatarKey, _GUIDE);
        } else if ( aButton == _OMAN ) {
            llGiveInventory(aAvatarKey, OWNER_MANUAL);
        } else if ( aButton == _AMAN ) {
            if (llGetInventoryType(ADDON_MANUAL) == 7)
                llGiveInventory(aAvatarKey, ADDON_MANUAL);
        } else if ( aButton == _UMAN ) {
            llGiveInventory(aAvatarKey, _GUIDE);
        } else if ( aButton == _LM ) {
            llGiveInventory(aAvatarKey,
                            llGetInventoryName(INVENTORY_LANDMARK, 0));
        } else if ( aButton == _INFO ) {
            llGiveInventory(aAvatarKey,
                            llGetInventoryName(INVENTORY_NOTECARD, 0));
        } else if ( aButton == _RESET ) {
            llMessageLinked(LINK_THIS, CONTROL_PANEL_MANAGE, aButton, aMenu);
            llResetScript();
            return FALSE;
        }
    } else if ( aMenu == _INNER ) {
        if ( aButton == _STOP ) {
            llMessageLinked(LINK_THIS, 333, aButton, aMenu);
        } else if ( aButton == _START ) {
            llMessageLinked(LINK_THIS, 333, aButton, aMenu);
        }
    } else if ( aMenu == _SIZE ) {
        if ( aButton == _TINY ) {
            llMessageLinked(LINK_THIS, 336, aButton, aMenu);
        } else if ( aButton == _SMALL ) {
            llMessageLinked(LINK_THIS, 336, aButton, aMenu);
        } else if ( aButton == _MEDIUM ) {
            llMessageLinked(LINK_THIS, 336, aButton, aMenu);
        } else if ( aButton == _LARGE ) {
            llMessageLinked(LINK_THIS, 336, aButton, aMenu);
        } else if ( aButton == _XL ) {
            llMessageLinked(LINK_THIS, 336, aButton, aMenu);
        } else if ( aButton == _XXL ) {
            llMessageLinked(LINK_THIS, 336, aButton, aMenu);
        }
    } else if ( aMenu == _FADE ) {
        if ( aButton == _SLOWEST ) {
            llMessageLinked(LINK_THIS, 337, aButton, aMenu);
        } else if ( aButton == _SLOWER ) {
            llMessageLinked(LINK_THIS, 337, aButton, aMenu);
        } else if ( aButton == _SLOW ) {
            llMessageLinked(LINK_THIS, 337, aButton, aMenu);
        } else if ( aButton == _FAST ) {
            llMessageLinked(LINK_THIS, 337, aButton, aMenu);
        } else if ( aButton == _FASTER ) {
            llMessageLinked(LINK_THIS, 337, aButton, aMenu);
        } else if ( aButton == _FASTEST ) {
            llMessageLinked(LINK_THIS, 337, aButton, aMenu);
        }
    } else if ( aMenu == _SPEED ) {
        if ( aButton == _SLOWEST ) {
            llMessageLinked(LINK_THIS, 335, aButton, aMenu);
        } else if ( aButton == _SLOWER ) {
            llMessageLinked(LINK_THIS, 335, aButton, aMenu);
        } else if ( aButton == _SLOW ) {
            llMessageLinked(LINK_THIS, 335, aButton, aMenu);
        } else if ( aButton == _FAST ) {
            llMessageLinked(LINK_THIS, 335, aButton, aMenu);
        } else if ( aButton == _FASTER ) {
            llMessageLinked(LINK_THIS, 335, aButton, aMenu);
        } else if ( aButton == _FASTEST ) {
            llMessageLinked(LINK_THIS, 335, aButton, aMenu);
        }
    } else if ( aMenu == _GEOMETRY ) {
        if ( aButton == _SPHERES ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _PRISM ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _CYLINDER ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _BOX ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _TORUS ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _TUBE ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _RING ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _ALL ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _ROOT ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        } else if ( aButton == _CHILD ) {
            llMessageLinked(LINK_THIS, 334, aButton, aMenu);
        }
    } else if ( aMenu == _GRAV ) {
        llMessageLinked(LINK_THIS, 338, aButton, aMenu);
    } else if ( aMenu == _SOFT ) {
        llMessageLinked(LINK_THIS, 339, aButton, aMenu);
    } else if ( aMenu == _FRIC ) {
        llMessageLinked(LINK_THIS, 340, aButton, aMenu);
    } else if ( aMenu == _WIND ) {
        llMessageLinked(LINK_THIS, 341, aButton, aMenu);
    } else if ( aMenu == _FORCE ) {
        llMessageLinked(LINK_THIS, 342, aButton, aMenu);
    } else if ( aMenu == _TENSION ) {
        llMessageLinked(LINK_THIS, 343, aButton, aMenu);
    } else if ( aMenu == _PARTICLES ) {
        if ( aButton == _ENABLE ) {
            PART_ENABLED = TRUE;
            if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
                llSetScriptState(_SPARKLE, TRUE);
        } else if ( aButton == _DISABLE ) {
            PART_ENABLED = FALSE;
            if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
                llSetScriptState(_SPARKLE, FALSE);
        } else {
            if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT) {
                if ( aButton == _EXIT ) {
                    llMessageLinked(LINK_THIS, CONTROL_PANEL_MANAGE, aButton, aMenu);
                    return FALSE;
                }
                if ( aButton == _SPACE ) {
                    return TRUE;
                }
                else {
                    llMessageLinked(LINK_SET, 103, aButton, aMenu);
                }
            }
            else if (llGetInventoryType(_IS) == INVENTORY_SCRIPT)
                llMessageLinked(LINK_THIS, 344, aButton, aMenu);
        }
    } else if ( aMenu == _SARGET ) {
        if (aButton == "Full Report") {
            llMessageLinked(LINK_THIS, 350, aButton, "");
        }
    } else if ( aMenu == _SOUND ) {
        llMessageLinked(LINK_THIS, 345, aButton, aMenu);
    } else if ( aMenu == _RAIN ) {
        llMessageLinked(LINK_THIS, 346, aButton, aMenu);
    } else if ( aMenu == _SNOW ) {
        llMessageLinked(LINK_THIS, 347, aButton, aMenu);
    } else if ( aMenu == _TEXTURE ) {
            llMessageLinked(LINK_THIS, 348, aButton, aMenu);
    } else if ( aMenu == _BUBBLES ) {
        llMessageLinked(LINK_THIS, 349, aButton, aMenu);
    } else if ( aMenu == _VISIBLE ) {
        if ( aButton == "Visible" ) {
            llMessageLinked(LINK_THIS, CONTROL_PANEL_MANAGE, aButton, aMenu);
            INVISIBLE = FALSE;
        }
        else if ( aButton == "Invisible" ) {
            llMessageLinked(LINK_THIS, CONTROL_PANEL_MANAGE, aButton, aMenu);
            INVISIBLE = TRUE;
        }
    } else if ( aMenu == _RANGE ) {
        range = (float)aButton;
    } else if ( aMenu == _POSITION ) {
        llMessageLinked(LINK_THIS, 155, aButton, aMenu);
    } else if ( aMenu == _ADJUST ) {
        llMessageLinked(LINK_THIS, 156, aButton, aMenu);
    } else if ( aMenu == _COMMANDS ) {
        if ( aButton == _EXIT ) {
            llMessageLinked(LINK_THIS, CONTROL_PANEL_MANAGE, aButton, aMenu);
            return FALSE;
        }
        if ( aButton == _SPACE ) {
            return TRUE;
        }
        else {
            llMessageLinked(LINK_SET, 103, aButton, aMenu);
        }
    }
    return RESHOWDIALOG;
}

SetScriptState(string script, integer action) {
    if (llGetInventoryType(script) == INVENTORY_SCRIPT)
        llSetScriptState(script, action);
}

Prep_Restart() {
    SetScriptState(_SCAN, TRUE);
    if (handle)
        llListenRemove(handle);
    handle = 0;
}

// Send LifeBots HTTP API commands
LifeBotsAPI(string command, list params) {

  // Populate the query data
  list query = [
    "action="  + command,
    "apikey="  + llEscapeURL(API_KEY),
    "botname=" + llEscapeURL(BOT_NAME),
    "secret="  + llEscapeURL(BOT_SECRET)
  ];

  integer i;
  for(i = 0; i<llGetListLength(params); i += 2) {
    query += [ llList2String(params, i) + "=" + llEscapeURL(llList2String(params, i+1)) ];
  }

  string queryString = llDumpList2String(query, "&");
 
  llHTTPRequest(API_URL, [HTTP_METHOD,"POST"], queryString);
}

default {
    state_entry()
    {
        if (dialog_handle == 0) {
            _DialogChannel = -1000000000 - (integer)llFrand(999999999);
            dialog_handle = llListen(_DialogChannel,"",NULL_KEY,"");
        }
        Owner = llGetOwner();
        if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
            PART_ENABLED = TRUE;
        if (llGetInventoryType(_IS) == INVENTORY_SCRIPT) {
            _NavigationMenus = [ _MAIN, _ADJUST, _POSITION, _RANGE, _SCAN, _VISIBLE, _INNER, _FLEX, _SIZE, _SPEED, _FADE, _SOUND, _BUBBLES, _SNOW, _RAIN, _PARTICLES, _TEXTURE, _GEOMETRY, _GRAV, _SOFT, _FRIC, _WIND, _FORCE, _TENSION ];
        }
        else {
            if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
                _NavigationMenus = [ _MAIN, _ADJUST, _POSITION, _RANGE, _SCAN, _PARTICLES, _VISIBLE ];
            else
                _NavigationMenus = [ _MAIN, _ADJUST, _POSITION, _RANGE, _SCAN, _VISIBLE ];
        }
        llMessageLinked(LINK_THIS, 154, "Get Commands", "");
        if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
            _NavigationMenus = _NavigationMenus + [ _COMMANDS ];
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
            if (dialog_handle)
                llListenRemove(dialog_handle);
            dialog_handle = 0;
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

    touch_start(integer total_number)
    {
        integer i;
        key toucher;

        for (i=0;i<total_number;i++) {
          toucher = llDetectedKey(i);
          if ((toucher == Owner) ||
            ((RESTRICTED_ACCESS == 2) && llSameGroup(toucher))) {
            ShowMainMenu(toucher);
          }
        }
    }

    listen(integer channel, string name, key id, string message)
    {
      if ( channel == _DialogChannel ) {
          integer IDX = llGetListLength( _NavigationStack ) - 1;
          if ( IDX < 0 )
              return;
          ListenHandler( llList2String( _NavigationStack, IDX ), message, name, id );
      }
    }

    link_message(integer sender, integer num, string message, key trigger)
    {
        // TODO: Cleanup legacy link messages
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
        } else if (num == MENU_ACCESS) {
            if (OWNER_BOT_MENU) {
              if ((trigger == Owner) ||
                  ((RESTRICTED_ACCESS == 2) && llSameGroup(trigger))) {
                ShowMainMenu(trigger);
              }
            }
            else {
              ShowMainMenu(trigger);
            }
        } else if (num == SET_VISIBILITY) {
            INVISIBLE = (integer)message;
        } else if (num == SET_RESTRICTED_ACCESS) {
            RESTRICTED_ACCESS = (integer)message;
        } else if (num == SET_LISTEN_HANDLE) {
            handle = (integer)message;
        } else if (num == 87) {
            SHOW_BOT_MENU = (integer)message;
        } else if (num == 88) {
            OWNER_BOT_MENU = (integer)message;
        } else if (num == 89) {
            COMMAND_NAMES = llParseString2List(message, [","], []);
        } else if (num == 90) {
            _BOTNAME = message;
        } else if (num == 350) {
            if (message == "flipped")
                enabled = 0;
        } else if (num == 401) {
            particle_names = llParseString2List(message, [","], []);
        } else if (num == CONTROL_PANEL_MANAGE) {
            if (message == _OFF) {
                if (handle)
                    llListenRemove(handle);
                handle = 0;
                llSetTimerEvent(0.0);
                state off;
            }
            else if (message == _ON) {
                if (handle)
                    llListenRemove(handle);
                handle = 0;
                llSetTimerEvent(30.0);
                Prep_Restart();
                state default;
            }
            else if (message == "Reset") {
                if (handle)
                    llListenRemove(handle);
                handle = 0;
                llResetScript();
            }
            else if (message == "Visible") {
                if (INVISIBLE)
                    llSetLinkAlpha(LINK_SET, 1.0, ALL_SIDES);
                INVISIBLE = FALSE;
            }
            else if (message == "Invisible") {
                if (!INVISIBLE)
                    llSetLinkAlpha(LINK_SET, 0.0, ALL_SIDES);
                INVISIBLE = TRUE;
            }
            else if ( message == "Owner Only" ) {
                RESTRICTED_ACCESS = 1;
            }
            else if ( message == "Group Only" ) {
                RESTRICTED_ACCESS = 2;
            }
            else if ( message == "All" ) {
                RESTRICTED_ACCESS = 0;
            }
        }
    }

    sensor(integer numDetected) {
        integer i;
        for (i = 0; i < numDetected; i++)
        {
            llMessageLinked(LINK_THIS, 350, (string)llDetectedKey(i), "");
        }
        llSleep(0.5);
        llMessageLinked(LINK_THIS, 350, _OFF, "");
    }
}

state off {
    state_entry()
    {
        if (handle)
            llListenRemove(handle);
        handle = 0;
        SetScriptState(_SCAN, FALSE);
        llMessageLinked(LINK_THIS, SET_LISTEN_HANDLE, (string)handle, "");
    }
    
    on_rez(integer param)
    {
        llResetScript();
    }

    changed(integer change)
    {
        if ( change & CHANGED_INVENTORY ) {
            if (handle)
                llListenRemove(handle);
            handle = 0;
            llResetScript();
        }
        if (change & CHANGED_LINK) { 
            Prep_Restart();
            state default;
        }
    }

    touch_start(integer num)
    {
        integer i = 0;
        for (; i<num; ++i) {
            if (RESTRICTED_ACCESS == 1) { // Only owner can turn me back on
                if (llDetectedKey(i) == Owner) {
                    llMessageLinked(LINK_THIS, 13, _ON, "");
                    Prep_Restart();
                    state default;
                }
            } else if (RESTRICTED_ACCESS == 2) { // Group can turn me back on
                if (llSameGroup(llDetectedKey(i))) {
                    llMessageLinked(LINK_THIS, 13, _ON, "");
                    Prep_Restart();
                    state default;
                }
            }
            else { // Anyone can turn me back on
                llMessageLinked(LINK_THIS, 13, _ON, "");
                Prep_Restart();
                state default;
            }
        }
    }

    link_message(integer sender, integer num, string message, key trigger)
    {
        if (num == CONTROL_PANEL_MANAGE) {
            if (message == _ON) {
                if (handle)
                    llListenRemove(handle);
                handle = 0;
                Prep_Restart();
                state default;
            }
        }
    }
}
