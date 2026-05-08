///////////// LifeBots Control Board ///////////////
//                                                //
// This script acts as a bridge between LifeBots  //
// command and control scripts and LifeBots bots  //
//                                                //
// On touch the LifeBots Control Board presents a //
// dialog menu with command and control choices   //
// depending on what user scripts are present     //
//                                                //
////////////////////////////////////////////////////

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
//////////////////////////////////////////////////
//////////////////////////////////////////////////
// LifeBots Command & Control Bridge
//////////////////////////////////////////////////

string apiKey = "your-lifebots-developer-api-key";

string DEF_FIRST = "Ana";
string DEF_LAST = "LifeBot";
string FIRST_NAME = DEF_FIRST;
string LAST_NAME = DEF_LAST;
string LANG_NAME = "English";
string _BOTNAME = "";
key Owner = NULL_KEY;

list particle_names = [ ];
list nearby_names = [ ];
list LANG_NAMES = [ "English", "Deutsch", "Français", "Polski", "Italiano", "Nihongo", "Español", "Nederlands", "Português", "Russkiy" ];
list COMMAND_NAMES = [];

integer SHOW_BOT_MENU = TRUE;
integer OWNER_BOT_MENU = FALSE;
integer WIKIPEDIA_ENABLED = FALSE;
integer AI_ENABLED = TRUE;
integer ALPHA_ENABLED = FALSE;
integer INVISIBLE = FALSE; // Enable making the bot invisible
integer NAME_ENABLED = TRUE; // Only respond if my name is in the chat message
integer GREET_ENABLED = FALSE; // Does the bot greet new arrivals ?
integer FOLLOW_ENABLED = FALSE; // Does the bot follow the owner/others ?
integer PART_ENABLED = FALSE; // Does the bot emit particles etc ?
integer EMAIL_ENABLED = TRUE; // Send emails
integer VERBAL_SHUTOFF_ENABLED = TRUE;
integer RESTRICTED_ACCESS = 1;
integer chat_channel = 0;
integer dialog_handle = 0;
integer handle = 1;
integer at_home = 0;
integer others = 0;
integer select_follower = 1;
integer enabled = 1;
integer ignore_touch = 0;
integer duo = 0;
float range = 20.0;
vector offset = ZERO_VECTOR;

// Reused strings
string _DEFAULT = "default";
string _RESET = "Reset";
string _UPGRADE = "Upgrade";
string _EXIT = "<<< Exit >>>";
string _OTHERS = "Follow Others";
string _FOLLOWME = "Follow Me";
string _GOHOME = "Go Home";
string _HOME = "Set Home";
string _FIRE = "Fire Laser";
string _PHYS = "Physical";
string _PHAN = "Phantom";
string _COME = "Come Here";
string _ENABLE = "ENABLE";
string _DISABLE = "DISABLE";
string _OFF = "OFF";
string _ON = "ON";
string _GUIDE = "LifeBots User Guide";
string OWNER_MANUAL = "LifeBots Owner Manual";
string ADDON_MANUAL = "LifeBot Actorbot Add-On Manual";
string _OMAN = "Owner Doc";
string _AMAN = "Addon Doc";
string _UMAN = "User Guide";
string _LM = "Landmark";
string _INFO = "Info";
string _DLOAD = ", download a PDF version of the Truth & Beauty Lab LifeBots Owner Manual at http://www.scribd.com/doc/45108454/LifeBots-Owner-Manual\nRead the Second Life LifeBots blog at http://pandorabot.blogspot.com\nVisit the Truth & Beauty Lab Marketplace at https://marketplace.secondlife.com/stores/44210 .";
string _MYNAME = "My name is ";
string _READY = "LifeBot ready to chat!";
string _VERBAL = "Verbal ";
string _ABLE = "You can enable/disable";
string _EDIT = "here\nor edit the Configuration notecard to change\nthe default setting.";
string _SELECT = ".\nSelect one of the";
string _CURRENT = "is currently ";
string _ENBLED = "ENABLED\n";
string _DSBLED = "DISABLED\n";
string _IDENT = "[LifeBot]";

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
string _GREET = "Greeter";
string _FOLLOW = "Follow";
string _SPARKLE = "Scan_n_Sparkle";
string _POSITION = "Position";
string _ADJUST = "Adjust";
string _DOC = "Help";
string _NAME = "Name";
string _EMAIL = "Email";
string _LANG = "Language";
string _CHAT = "AI Chat";
string _SHUTOFF = "Access";
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
string _FARGET = "Follow Av";
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
list _NavigationMenus = [ _MAIN, _EMAIL, _NAME, _ADJUST, _POSITION, _RANGE, _SCAN, _FOLLOW, _UPGRADE, _GREET, _CHAT, _SHUTOFF, _VISIBLE, _LANG, _INNER, _FLEX, _SIZE, _SPEED, _FADE, _SOUND, _BUBBLES, _SNOW, _RAIN, _PARTICLES, _TEXTURE, _GEOMETRY, _GRAV, _SOFT, _FRIC, _WIND, _FORCE, _TENSION ];

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

    string DialogMessage = "LifeBot Configuration Dialog";
    list   DialogOptions;
    integer pandora = 0;

    if ( aMenu == _MAIN ) {
        if (llGetInventoryType("pandorabot") == INVENTORY_SCRIPT)
            pandora = 1;
        DialogOptions = [];
        if (pandora) {
            DialogMessage = "Main Menu - LifeBot Configuration";
            if (handle)
                DialogOptions = DialogOptions + [ _OFF ];
            else
                DialogOptions = DialogOptions + [ _ON ];
        }
        else
            DialogMessage = "Main Menu";
        if (llGetInventoryType(_IS) == INVENTORY_SCRIPT)
            DialogOptions = DialogOptions + [ _INNER ];
        if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
            DialogOptions = DialogOptions + [ _COMMANDS, _PARTICLES ];
        if (llGetInventoryType(_GREET) == INVENTORY_SCRIPT)
            DialogOptions = DialogOptions + [ _GREET ];
        if (llGetInventoryType(_FOLLOW) == INVENTORY_SCRIPT)
            DialogOptions = DialogOptions + [ _FOLLOW, _SCAN, _TARGET ];
        else
            if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
                DialogOptions = DialogOptions + [ _SCAN, _TARGET ];
        if ((SHOW_BOT_MENU) && (_BOTNAME != "")) {
            if ((aID == Owner) || 
                ((RESTRICTED_ACCESS == 2) && llSameGroup(aID))) {
              if (pandora)
                  DialogOptions = DialogOptions + [ _NAME, _CHAT, _EMAIL, _SHUTOFF, _VISIBLE, _LANG, _DOC, _UPGRADE, _RESET ];
              else
                  DialogOptions = DialogOptions + [ _VISIBLE, _DOC, _UPGRADE, _RESET ];
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
            if (pandora)
                DialogOptions = DialogOptions + [ _NAME, _CHAT, _EMAIL, _SHUTOFF, _VISIBLE, _LANG, _DOC, _UPGRADE, _RESET ];
            else
                DialogOptions = DialogOptions + [ _VISIBLE, _DOC, _UPGRADE, _RESET ];
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
    } else if ( aMenu == _NAME ) {
        DialogMessage = _MYNAME + _CURRENT + FIRST_NAME + _SPACE + LAST_NAME + _SELECT + " first names " + _EDIT + " The 'Name ON/OFF' button\ntoggles whether your LifeBot responds to all\nlocal chat or just chat including his/her name";
        DialogOptions = [ DEF_FIRST, "Bob", "Polly", "Steven" ];
        if (NAME_ENABLED)
            DialogOptions = DialogOptions + [_NAME + _SPACE + _OFF];
        else
            DialogOptions = DialogOptions + [_NAME + _SPACE + _ON];
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
    } else if ( aMenu == _SHUTOFF ) {
        DialogMessage = "Menu Access: set LifeBot access";
        DialogMessage = DialogMessage + "\n\nVerbal shutoff " + _CURRENT;
        if (VERBAL_SHUTOFF_ENABLED) {
          DialogMessage = DialogMessage + _ENBLED;
          if (RESTRICTED_ACCESS == 1)
            DialogMessage = DialogMessage + " by Owner only";
          else if (RESTRICTED_ACCESS == 2)
            DialogMessage = DialogMessage + " by Group only";
          else
            DialogMessage = DialogMessage + " by All";
        }
        else
          DialogMessage = DialogMessage + _DSBLED;
        DialogMessage = DialogMessage + "\nMenu access " + _CURRENT;
        if (RESTRICTED_ACCESS == 1)
            DialogMessage = DialogMessage + " set to Owner only";
        else if (RESTRICTED_ACCESS == 2)
            DialogMessage = DialogMessage + " set to Group only";
        else
            DialogMessage = DialogMessage + " set to All";
        DialogOptions = [];
        if (VERBAL_SHUTOFF_ENABLED)
            DialogOptions = DialogOptions + [_VERBAL + _OFF];
        else
            DialogOptions = DialogOptions + [_VERBAL + _ON];
        DialogOptions = DialogOptions + ["Owner Only", "Group Only", _ALL ];
    } else if ( aMenu == _EMAIL ) {
        DialogMessage = "\nEmail " + _CURRENT;
        if (EMAIL_ENABLED)
          DialogMessage = DialogMessage + _ENBLED;
        else
          DialogMessage = DialogMessage + _DSBLED;
        DialogMessage = DialogMessage + _ABLE + " sending of email " + _EDIT;
        DialogOptions = [];
        if (EMAIL_ENABLED)
            DialogOptions = DialogOptions + [_EMAIL + _SPACE + _OFF];
        else
            DialogOptions = DialogOptions + [_EMAIL + _SPACE + _ON];
    } else if ( aMenu == _FOLLOW ) {
        DialogMessage = "\nFollow owner or nearest avatar " + _CURRENT;
        if (FOLLOW_ENABLED)
          DialogMessage = DialogMessage + _ENBLED;
        else
          DialogMessage = DialogMessage + _DSBLED;
        DialogMessage = DialogMessage + _ABLE + " following " + _EDIT;
        DialogOptions = [_ADJUST, _POSITION, _HOME, _SCAN, _FARGET, _FIRE, _PHYS, _PHAN];
        if (at_home)
            DialogOptions = [ _COME ] + DialogOptions;
        else
            DialogOptions = [ _GOHOME ] + DialogOptions;
        if (others)
            DialogOptions = [ _FOLLOWME ] + DialogOptions;
        else
            DialogOptions = [ _OTHERS ] + DialogOptions;
        if (FOLLOW_ENABLED)
            DialogOptions = [_FOLLOW + _SPACE + _OFF] + DialogOptions;
        else
            DialogOptions = [_FOLLOW + _SPACE + _ON] + DialogOptions;
    } else if ( aMenu == _RANGE ) {
        DialogMessage = "\nSelect the range of scans (in meters).\nRange " + _CURRENT + (string)range + " meters.";
        DialogOptions = ["2.0", "5.0", "10.0", "20.0", "30.0", "40.0", "50.0", "60.0", "70.0", "80.0", "90.0"];
    } else if ( aMenu == _SCAN ) {
        DialogMessage = "\nScan the area for objects or avatars:";
        DialogOptions = [_RANGE, _AGENT, _ACTIVE, _PASSIVE, _SCRIPTED, _ALL];
    } else if ( aMenu == _POSITION ) {
        DialogMessage = "\nPosition Presets for the Follower:";
        DialogOptions = [_ADJUST, "Behind Left", "Behind", "Behind Right", "Left", "Above", "Right", "Front Left", "Front", "Front Right"];
    } else if ( aMenu == _ADJUST ) {
        DialogMessage = "\nAdjust position offset of the Follower.\nOffset ";
        DialogMessage = DialogMessage + _CURRENT + ":\n<" + (string)offset.x;
        DialogMessage = DialogMessage + ", " + (string)offset.y;
        DialogMessage = DialogMessage + ", " + (string)offset.z + ">";
        DialogOptions = [_SPACE, "X-", "Y-", "Z-", "X+", "Y+", "Z+"];
    } else if ( aMenu == _GREET ) {
        DialogMessage = "\nGreeting new arrivals " + _CURRENT;
        if (GREET_ENABLED)
          DialogMessage = DialogMessage + _ENBLED;
        else
          DialogMessage = DialogMessage + _DSBLED;
        DialogMessage = DialogMessage + _ABLE + " greetings " + _EDIT;
        DialogOptions = [];
        if (GREET_ENABLED)
            DialogOptions = DialogOptions + [_GREET + _SPACE + _OFF];
        else
            DialogOptions = DialogOptions + [_GREET + _SPACE + _ON];
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
    } else if ( aMenu == _CHAT ) {
        DialogMessage = "\nAI chat " + _CURRENT;
        if (AI_ENABLED)
          DialogMessage = DialogMessage + _ENBLED;
        else
          DialogMessage = DialogMessage + _DSBLED;
        DialogMessage = DialogMessage + _ABLE + " AI chat " + _EDIT;
        DialogOptions = [];
        if (AI_ENABLED)
            DialogOptions = DialogOptions + ["Chat OFF"];
        else
            DialogOptions = DialogOptions + ["Chat ON"];
    } else if ( aMenu == _SARGET ) {
        select_follower = 2;
        DialogMessage = "Select which of the detected objects or avatars you wish to locate:";
        DialogOptions = [ "Full Report"] + nearby_names;
    } else if ( aMenu == _FARGET ) {
        select_follower = 1;
        DialogMessage = "Targets - select who will be the primary target:";
        DialogOptions = nearby_names;
    } else if ( aMenu == _TARGET ) {
        select_follower = 0;
        DialogMessage = "Particle Stream Targets - select who will be the target of the particle stream:";
        DialogOptions = nearby_names;
    } else if ( aMenu == _LANG ) {
        DialogMessage = _LANG + _CURRENT + LANG_NAME + _SELECT + " language codes " + _EDIT;
        DialogOptions = LANG_NAMES;
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
        if ( aButton == _OFF ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            return FALSE;
        }
        else if ( aButton == _ON ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            return FALSE;
        }
        else if ( aButton == _DOC ) {
            if (llGetInventoryType(OWNER_MANUAL) == 7)
                 llGiveInventory(aAvatarKey, OWNER_MANUAL);
            if (llGetInventoryType(ADDON_MANUAL) == 7)
                 llGiveInventory(aAvatarKey, ADDON_MANUAL);
            if (llGetInventoryType(_GUIDE) == 7)
                 llGiveInventory(aAvatarKey, _GUIDE);
            llInstantMessage(aAvatarKey, aAvatarName + _DLOAD);
        }
        else if ( aButton == _OMAN ) {
            llGiveInventory(aAvatarKey, OWNER_MANUAL);
            llInstantMessage(aAvatarKey, aAvatarName + _DLOAD);
        }
        else if ( aButton == _AMAN ) {
            if (llGetInventoryType(ADDON_MANUAL) == 7)
                llGiveInventory(aAvatarKey, ADDON_MANUAL);
            llInstantMessage(aAvatarKey, aAvatarName + _DLOAD);
        }
        else if ( aButton == _UMAN ) {
            llGiveInventory(aAvatarKey, _GUIDE);
            llInstantMessage(aAvatarKey, aAvatarName + _DLOAD);
        }
        else if ( aButton == _LM ) {
            llGiveInventory(aAvatarKey,
                            llGetInventoryName(INVENTORY_LANDMARK, 0));
        }
        else if ( aButton == _INFO ) {
            llGiveInventory(aAvatarKey,
                            llGetInventoryName(INVENTORY_NOTECARD, 0));
            llInstantMessage(aAvatarKey, aAvatarName + _DLOAD);
        }
        else if ( aButton == _RESET ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            llResetScript();
            return FALSE;
        }
        else if ( (aButton == _TARGET) || (aButton == _FARGET) ) {
            if (aButton == _TARGET)
                select_follower = 0;
            else
                select_follower = 1;
            llMessageLinked(LINK_THIS, 350, _ON, aMenu);
            llSleep(0.1);
            llSensor("", "", AGENT, 20.0, PI); // Look for avatars //
            return FALSE;
        }
        else if ( aButton == _UPGRADE ) {
            if (aAvatarKey == Owner) {
                llMessageLinked(LINK_THIS, 53, aButton, aMenu);
                return FALSE;
            }
            else {
                llInstantMessage(aAvatarKey,
                   "Only the owner of the LifeBot can initiate an upgrade.");
            }
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
        } else if ( aButton == _TARGET ) {
            select_follower = 0;
            llMessageLinked(LINK_THIS, 350, _ON, aMenu);
            llSleep(0.1);
            llSensor("", "", AGENT, 20.0, PI); // Look for avatars //
            return FALSE;
        }
        else
            if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT) {
                if ( aButton == _EXIT ) {
                    llMessageLinked(LINK_THIS, 53, aButton, aMenu);
                    return FALSE;
                }
                if ( aButton == _SPACE ) {
                    return TRUE;
                }
                else {
                    llMessageLinked(LINK_SET, 103, aButton, aMenu);
                    if (duo)
                        llWhisper(chat_channel, aButton);
                }
            }
            else if (llGetInventoryType(_IS) == INVENTORY_SCRIPT)
                llMessageLinked(LINK_THIS, 344, aButton, aMenu);
    } else if ( aMenu == _SARGET ) {
        if (aButton == "Full Report") {
            llMessageLinked(LINK_THIS, 350, aButton, "");
        }
        else {
            select_follower = 2;
            llMessageLinked(LINK_THIS, 502, aButton, (key)"2");
        }
    } else if ( aMenu == _FARGET ) {
        select_follower = 1;
        llMessageLinked(LINK_THIS, 502, aButton, (key)"1");
    } else if ( aMenu == _TARGET ) {
        select_follower = 0;
        llMessageLinked(LINK_THIS, 502, aButton, (key)"0");
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
    } else if ( aMenu == _NAME ) {
        if ((aButton == "Ana") || (aButton == "Bob") ||
            (aButton == "Polly") || (aButton == "Steven")) {
            FIRST_NAME = aButton;
        }
        llMessageLinked(LINK_THIS, 53, aButton, aMenu);
    } else if ( aMenu == _EMAIL ) {
        if ( aButton == _EMAIL + _SPACE + _OFF ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            EMAIL_ENABLED = FALSE;
        }
        else if ( aButton == _EMAIL + _SPACE + _ON ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            EMAIL_ENABLED = TRUE;
        }
    } else if ( aMenu == _VISIBLE ) {
        if ( aButton == "Visible" ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            INVISIBLE = FALSE;
        }
        else if ( aButton == "Invisible" ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            INVISIBLE = TRUE;
        }
    } else if ( aMenu == _SHUTOFF ) {
        if ( aButton == _VERBAL + _OFF ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            VERBAL_SHUTOFF_ENABLED = FALSE;
        }
        else if ( aButton == _VERBAL + _ON ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            VERBAL_SHUTOFF_ENABLED = TRUE;
        }
        else if ( aButton == "Owner Only" ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            RESTRICTED_ACCESS = 1;
        }
        else if ( aButton == "Group Only" ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            RESTRICTED_ACCESS = 2;
        }
        else if ( aButton == _ALL ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            RESTRICTED_ACCESS = 0;
        }
    } else if ( aMenu == _FOLLOW ) {
        if ( aButton == _FOLLOW + _SPACE + _ON ) {
            FOLLOW_ENABLED = TRUE;
            if (llGetInventoryType(_FOLLOW) == INVENTORY_SCRIPT)
                llSetScriptState(_FOLLOW, TRUE);
        } else if ( aButton == _FOLLOW + _SPACE + _OFF ) {
            FOLLOW_ENABLED = FALSE;
            if (llGetInventoryType(_FOLLOW) == INVENTORY_SCRIPT)
                llSetScriptState(_FOLLOW, FALSE);
        } else if ( (aButton == _TARGET) || (aButton == _FARGET) ) {
            if (aButton == _TARGET)
                select_follower = 0;
            else
                select_follower = 1;
            llMessageLinked(LINK_THIS, 350, _ON, aMenu);
            llSleep(0.1);
            llSensor("", "", AGENT, 20.0, PI); // Look for avatars //
            return FALSE;
        } else if ( aButton == _FOLLOWME ) {
            others = 0;
            llMessageLinked(LINK_THIS, 153, "1", aMenu);
        } else if ( aButton == _OTHERS ) {
            others = 1;
            llMessageLinked(LINK_THIS, 153, "2", aMenu);
        } else if ( aButton == _HOME ) {
            llMessageLinked(LINK_THIS, 154, aButton, aMenu);
        } else if ( aButton == _GOHOME ) {
            at_home = 1;
            llMessageLinked(LINK_THIS, 154, aButton, aMenu);
        } else if ( aButton == _COME ) {
            at_home = 0;
            llMessageLinked(LINK_THIS, 154, aButton, aMenu);
        } else if ( aButton == _PHYS ) {
            llMessageLinked(LINK_THIS, 154, aButton, aMenu);
        } else if ( aButton == _PHAN ) {
            llMessageLinked(LINK_THIS, 154, aButton, aMenu);
        } else if ( aButton == _FIRE ) {
            llMessageLinked(LINK_SET, 154, aButton, aMenu);
        }
    } else if ( aMenu == _SCAN ) {
        if (aButton == _AGENT) {
            select_follower = 2;
            llMessageLinked(LINK_THIS, 350, _ON, aMenu);
            llSleep(0.1);
            llSensor("", "", AGENT, range, PI); // Look for Avatars
            return FALSE;
        } else if (aButton == _ACTIVE) {
            select_follower = 2;
            llMessageLinked(LINK_THIS, 350, _ON, aMenu);
            llSleep(0.1);
            llSensor("", "", ACTIVE, range, PI); // Look for active objects
            return FALSE;
        } else if (aButton == _PASSIVE) {
            select_follower = 2;
            llMessageLinked(LINK_THIS, 350, _ON, aMenu);
            llSleep(0.1);
            llSensor("", "", PASSIVE, range, PI); // Look for passive objects
            return FALSE;
        } else if (aButton == _SCRIPTED) {
            select_follower = 2;
            llMessageLinked(LINK_THIS, 350, _ON, aMenu);
            llSleep(0.1);
            llSensor("", "", SCRIPTED, range, PI); // Look for scripted objects
            return FALSE;
        } else if (aButton == _ALL) {
            select_follower = 2;
            llMessageLinked(LINK_THIS, 350, _ON, aMenu);
            llSleep(0.1);
            llSensor("", "", AGENT|ACTIVE|PASSIVE, range, PI);
            return FALSE;
        }
    } else if ( aMenu == _RANGE ) {
        range = (float)aButton;
    } else if ( aMenu == _POSITION ) {
        llMessageLinked(LINK_THIS, 155, aButton, aMenu);
    } else if ( aMenu == _ADJUST ) {
        llMessageLinked(LINK_THIS, 156, aButton, aMenu);
    } else if ( aMenu == _GREET ) {
        if ( aButton == _GREET + _SPACE + _ON ) {
            GREET_ENABLED = TRUE;
            if (llGetInventoryType(_GREET) == INVENTORY_SCRIPT)
                llSetScriptState(_GREET, TRUE);
        } else if ( aButton == _GREET + _SPACE + _OFF ) {
            GREET_ENABLED = FALSE;
            if (llGetInventoryType(_GREET) == INVENTORY_SCRIPT)
                llSetScriptState(_GREET, FALSE);
        }
    } else if ( aMenu == _CHAT ) {
        if ( aButton == "Chat ON" ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            AI_ENABLED = TRUE;
        } else if ( aButton == "Chat OFF" ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            AI_ENABLED = FALSE;
        }
    } else if ( aMenu == _COMMANDS ) {
        if ( aButton == _EXIT ) {
            llMessageLinked(LINK_THIS, 53, aButton, aMenu);
            return FALSE;
        }
        if ( aButton == _SPACE ) {
            return TRUE;
        }
        else {
            llMessageLinked(LINK_SET, 103, aButton, aMenu);
            if (duo)
                llWhisper(chat_channel, aButton);
        }
    } else if ( aMenu == _LANG ) {
        llMessageLinked(LINK_THIS, 53, aButton, aMenu);
    }
    return RESHOWDIALOG;
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
            _NavigationMenus = [ _MAIN, _EMAIL, _NAME, _ADJUST, _POSITION, _RANGE, _SCAN, _FOLLOW, _UPGRADE, _GREET, _CHAT, _SHUTOFF, _VISIBLE, _LANG, _INNER, _FLEX, _SIZE, _SPEED, _FADE, _SOUND, _BUBBLES, _SNOW, _RAIN, _PARTICLES, _TEXTURE, _GEOMETRY, _GRAV, _SOFT, _FRIC, _WIND, _FORCE, _TENSION ];
        }
        else {
            if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
                _NavigationMenus = [ _MAIN, _EMAIL, _NAME, _ADJUST, _POSITION, _RANGE, _SCAN, _FOLLOW, _UPGRADE, _PARTICLES, _GREET, _CHAT, _SHUTOFF, _VISIBLE, _LANG ];
            else
                _NavigationMenus = [ _MAIN, _EMAIL, _NAME, _ADJUST, _POSITION, _RANGE, _SCAN, _FOLLOW, _UPGRADE, _GREET, _CHAT, _SHUTOFF, _VISIBLE, _LANG ];
        }
        llMessageLinked(LINK_THIS, 154, "Get Commands", "");
        if (llGetInventoryType(_SPARKLE) == INVENTORY_SCRIPT)
            _NavigationMenus = _NavigationMenus + [ _COMMANDS ];
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

    touch_start(integer total_number)
    {
        integer i;
        key toucher;

        if (ignore_touch)
            return;
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
        if (num == 93) {
            if (OWNER_BOT_MENU) {
              if ((trigger == Owner) ||
                  ((RESTRICTED_ACCESS == 2) && llSameGroup(trigger))) {
                ShowMainMenu(trigger);
              }
            }
            else {
              ShowMainMenu(trigger);
            }
        } else if (num == 70) {
            chat_channel = (integer)message;
        } else if (num == 71) {
            LANG_NAMES = llParseString2List(message, [","], []);
        } else if (num == 72) {
            LANG_NAME = message;
        } else if (num == 73) {
            FIRST_NAME = message;
        } else if (num == 74) {
            LAST_NAME = message;
        } else if (num == 75) {
            NAME_ENABLED = (integer)message;
        } else if (num == 76) {
            WIKIPEDIA_ENABLED = FALSE;
        } else if (num == 78) {
            INVISIBLE = (integer)message;
        } else if (num == 79) {
            GREET_ENABLED = (integer)message;
            if (GREET_ENABLED)
                if (llGetInventoryType(_GREET) == INVENTORY_SCRIPT)
                    llSetScriptState(_GREET, TRUE);
            else
                if (llGetInventoryType(_GREET) == INVENTORY_SCRIPT)
                    llSetScriptState(_GREET, FALSE);
        } else if (num == 179) {
            FOLLOW_ENABLED = (integer)message;
            if (FOLLOW_ENABLED)
                if (llGetInventoryType(_FOLLOW) == INVENTORY_SCRIPT)
                    llSetScriptState(_FOLLOW, TRUE);
            else
                if (llGetInventoryType(_FOLLOW) == INVENTORY_SCRIPT)
                    llSetScriptState(_FOLLOW, FALSE);
        } else if (num == 180) {
            offset = (vector)message;
        } else if (num == 80) {
            EMAIL_ENABLED = (integer)message;
        } else if (num == 81) {
            VERBAL_SHUTOFF_ENABLED = (integer)message;
        } else if (num == 82) {
            RESTRICTED_ACCESS = (integer)message;
        } else if (num == 85) {
            handle = (integer)message;
        } else if (num == 86) {
            AI_ENABLED = (integer)message;
        } else if (num == 87) {
            SHOW_BOT_MENU = (integer)message;
        } else if (num == 88) {
            OWNER_BOT_MENU = (integer)message;
        } else if (num == 89) {
            COMMAND_NAMES = llParseString2List(message, [","], []);
        } else if (num == 90) {
            _BOTNAME = message;
        } else if (num == 91) {
            ALPHA_ENABLED = FALSE;
        } else if (num == 350) {
            if (message == "flipped")
                enabled = 0;
            else if (message == "duo")
                duo = 1;
        } else if (num == 401) {
            particle_names = llParseString2List(message, [","], []);
        } else if (num == 501) {
            if (message == _ON) {
                nearby_names = [];
            }
            else if (message == _OFF) {
                _DialogOptions = nearby_names;
                if (select_follower == 1) {
                    _DialogMessage = "Targets - select who will be the primary target:";
                    _NavigationStack += [ _FARGET ];
                } else if (select_follower == 0) {
                    _DialogMessage = "Particle Stream Targets - select who will be the target of the particle stream:";
                    _NavigationStack += [ _TARGET ];
                } else if (select_follower == 2) {
                    _DialogOptions = [ "Full Report"] + nearby_names;
                    _DialogMessage = "Select which of the detected objects or avatars you wish to locate:";
                    _NavigationStack += [ _SARGET ];
                }
                ShowDialogInitial("\n" + _DialogMessage, _DialogOptions,
                                                         _DialogUser);
            }
            else if (message == "Away") {
                at_home = 0;
            }
            else if (message == "Home") {
                at_home = 1;
            }
            else {
                nearby_names = nearby_names + [message];
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
