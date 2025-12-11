// Scan_n_Sparkle v2.9
// Copyright (c) 2012-2025 Missy Restless and the Truth & Beauty Lab
// All rights reserved.
//
// Adapted from Pandorabot Follow Script
//
// Created 06-Jan-2012 by Missy Restless - Integrated for use with Pandorabots
// Modified 12-Jan-2012 by Missy Restless - Integrated target menu and messages
//     from Inner Spheres Pandorabot
// Modified 13-Jan-2012 by Missy Restless - Added position presets via dialog
// Modified 16-Jan-2012 by Missy Restless - Option to switch physics (needed
//     for objects that "float" while owner is away)
// Modified 18-Jan-2012 by Missy Restless - Added offset adjustment dialog
// Modified 19-Jan-2012 by Missy Restless - Option to set primary follow target
// Modified 20-Jan-2012 by Missy Restless - Check if object is > 32 prims
// Modified 01-Feb-2012 by Missy Restless - Support for firing but not following
// Modified 07-Feb-2012 by Missy Restless - Support for texture changes / particle displays
// Modified 14-Feb-2012 by Missy Restless - Adapted for use in Smart Ring series
// Modified 15-Feb-2012 by Missy Restless - Added lightning and thunder
// Modified 21-Feb-2012 by Missy Restless - Added Bling and Sparkle
// Modified 27-Feb-2012 by Missy Restless - Added Shamrocks particle display
// Modified 28-Feb-2012 by Missy Restless - Added interactive display control
//     commands More, Less, Slower, Faster, Next, Prev, Default
// Modified 06-Mar-2012 by Missy Restless - Added scan by name
// Modified 11-Mar-2012 by Missy Restless - Integrated with standard Pandorabot
// Modified 10-Dec-2025 by Missy Restless - Integrated with LifeBots Control Panel
//

list nearby_keys = [];
list nearby_names = [];
list command_names = [ "Laser", "Burst", "Bubbles", "Cycle", "Hearts",
                       "Lightning", "Bling", "Sparkle", "Blue Balls",
                       "Shamrocks", "More", "Less", "Faster", "Slower",
                       "Next Ptcl", "Prev Ptcl", "Default", "Sync", "Scan",
                       "Avatars", "Random", "Off" ];
list thunder_sounds = [ "15c24161-55a7-4d75-73e2-9f04ae731e8a",
                        "0f025c4c-821e-03fa-b7b1-4444c39389b9" ];
list lightning_flippeds = [ "0337c683-1d99-1ce0-d742-7cdc0d2b1df9",
                            "5ffcc2cf-d510-e09c-25d4-0fbb5354e143",
                            "51929336-0443-7ce1-99d5-8d18c30c9b37",
                            "7089694e-e115-92d8-9235-95df926aa708",
                            "bccc3f67-53a2-0bae-1672-6c4afefacbe5",
                            "ccb8fcc5-11d8-a06a-928e-a16bdea03d21" ];
list lightning_textures = [ "eec12f2c-2146-2eb8-7b9b-106036849d5e",
                            "f9e1c845-d552-7c1b-881c-8b0b1c3b8502",
                            "5c52d9c1-10d1-641a-9a0d-43a43b9b20e4",
                            "2b0ca55c-4a3f-a83d-a380-504ca31011d6",
                            "fb8e36bd-ace1-0135-83a4-b23808199210",
                            "d2adfd78-3006-7660-4705-055d12efef0f" ];
float range = 20.0;            // Range (in meters) of scan for avatars
float speed = 1.0;             // Frequency of particle emission
integer cycle = 0;             // Whether to cycle thru displays and anims
integer use_lightning = 0;     // Whether to cycle thru lightning displays
integer flipped = 0;           // Whether to use the flipped lightning textures
integer laser_count = 0;       // Counter for duration of laser
integer firing = 0;            // Toggle whether the laser is firing
integer scanning = 0;          // Toggle whether the follower is scanning
integer num_anims = 0;         // Number of animations in Smart Ring inventory
integer anim_num = 0;          // Number of animation to use
integer num_disps = 10;        // Number of particle displays to cycle thru
integer disp_num = 0;          // Number of particle display to use
integer num_lites = 6;         // Number of lightning displays to cycle thru
integer lite_num = 0;          // Number of lightning display to use
integer num_thuns = 10;        // Number of thunder sounds to cycle thru
integer thun_num = 0;          // Number of thunder sound to use
integer random = 0;            // Whether displays/animations should be random
integer use_anims = 0;         // Whether to use the animations when emitting
integer num_particles = 1;     // Number of particles to emit
string animation = "";         // Name of animation to use
string fire_anim = "Double Draw";         // Animation to play when firing
string beam_anim = "Kick Down That Open Door"; // Anim to play when scanning
string bubb_anim = "Yoga Relaxation Sit";
string part_anim = "Yoga Relaxation Stand";
string lightning = "";
string scan_by_name = "";      // Name with which scan is filtered
string thunder = "";
string _ON = "ON";
string _OFF = "OFF";
string _NONE = "__none__";
key owner = NULL_KEY;
key av_target = NULL_KEY;      // The target avatar for particle stream
key key_target;
key object_key = NULL_KEY;

// Takes a key and position vector, turns toward position, beam toward pos
start_beam(key barget,  vector barget_pos) {
    stop_particles();
    if ((animation != "") && (use_anims)) {
        if ((fire_anim != "") && (!cycle))
            animation = fire_anim;
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    llParticleSystem([ 
           PSYS_PART_START_SCALE, <0.1, 0.1, FALSE>,
           PSYS_PART_END_SCALE, <0.1, 0.1, FALSE>, 
           PSYS_PART_START_COLOR, <1.0, 0.0, 0.0>,
           PSYS_PART_END_COLOR, <0.0, 0.0, 1.0>, 
           PSYS_PART_START_ALPHA, 1.0,
           PSYS_PART_END_ALPHA, 0.5,     
           PSYS_SRC_BURST_PART_COUNT, num_particles, 
           PSYS_SRC_BURST_RATE, speed,  
           PSYS_PART_MAX_AGE,         1.3, 
           PSYS_SRC_MAX_AGE,          0.0,  
           PSYS_SRC_PATTERN, 2,
           PSYS_SRC_BURST_SPEED_MIN, 0.5,
           PSYS_SRC_BURST_SPEED_MAX, 2.0, 
           PSYS_SRC_BURST_RADIUS, 0.0,
           PSYS_SRC_ANGLE_BEGIN,  0.05*PI,
           PSYS_SRC_ANGLE_END, 0.05*PI,  
           PSYS_SRC_OMEGA, < 0.0, 0.0, 0.0 >, 
           PSYS_SRC_ACCEL, < 0.0, 0.0, 0.0 >,  
           PSYS_SRC_TARGET_KEY, barget,       
           PSYS_PART_FLAGS, ( 0      
                                | PSYS_PART_INTERP_COLOR_MASK   
                                | PSYS_PART_EMISSIVE_MASK   
                                | PSYS_PART_TARGET_LINEAR_MASK    
                                | PSYS_PART_FOLLOW_SRC_MASK     
                                | PSYS_PART_TARGET_POS_MASK     
            )]);
}

// Takes a key and position vector, turns toward position, shoots at key
start_particles(key target,  vector target_pos) {
    stop_particles();
    av_target = target;
    if ((animation != "") && (use_anims)) {
        if ((fire_anim != "") && (!cycle))
            animation = fire_anim;
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    
    llParticleSystem([ 
           PSYS_SRC_TEXTURE, "d852f0f6-fba7-2186-df21-952fd004ea10", 
           PSYS_PART_START_SCALE, <0.2, 0.2, FALSE>,
           PSYS_PART_END_SCALE, <0.5, 0.5, FALSE>, 
           PSYS_PART_START_COLOR, <1.0, 0.0, 0.0>,
           PSYS_PART_END_COLOR, <0.0, 0.0, 1.0>, 
           PSYS_PART_START_ALPHA, 1.0,
           PSYS_PART_END_ALPHA, 0.5,     
           PSYS_SRC_BURST_PART_COUNT, num_particles, 
           PSYS_SRC_BURST_RATE, speed,  
           PSYS_PART_MAX_AGE,         1.3, 
           PSYS_SRC_MAX_AGE,          0.0,  
           PSYS_SRC_PATTERN, 2,
           PSYS_SRC_BURST_SPEED_MIN, 0.5,
           PSYS_SRC_BURST_SPEED_MAX, 2.0, 
           PSYS_SRC_BURST_RADIUS, 0.0,
           PSYS_SRC_ANGLE_BEGIN,  0.05*PI,
           PSYS_SRC_ANGLE_END, 0.05*PI,  
           PSYS_SRC_OMEGA, < 0.0, 0.0, 0.0 >, 
           PSYS_SRC_ACCEL, < 0.0, 0.0, 0.0 >,  
           PSYS_SRC_TARGET_KEY, target,       
           PSYS_PART_FLAGS, ( 0      
                                | PSYS_PART_INTERP_COLOR_MASK   
                                | PSYS_PART_INTERP_SCALE_MASK   
                                | PSYS_PART_EMISSIVE_MASK   
                                | PSYS_PART_FOLLOW_VELOCITY_MASK
                                | PSYS_PART_WIND_MASK            
                                | PSYS_PART_FOLLOW_SRC_MASK     
                                | PSYS_PART_TARGET_POS_MASK     
            )]);
}

bubbles_on() {
    stop_particles();
    if ((animation != "") && (use_anims)) {
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    llParticleSystem([
            PSYS_PART_FLAGS, ( 0
                             | PSYS_PART_EMISSIVE_MASK
                             | PSYS_PART_INTERP_COLOR_MASK
                             | PSYS_PART_INTERP_SCALE_MASK
                             | PSYS_PART_FOLLOW_VELOCITY_MASK ),
            PSYS_PART_MAX_AGE, 15,
            PSYS_PART_START_COLOR, <1.00000, 0.25000, 1.00000>,
            PSYS_PART_END_COLOR, <1.00000, 1.00000, 1.00000>,
            PSYS_PART_START_SCALE, <.1,.1,.1>,
            PSYS_PART_END_SCALE, <.6,.6,.9>,
            PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
            PSYS_SRC_BURST_RATE, speed,
            PSYS_SRC_ACCEL, <0.0, 0.0, 0.1>,
            PSYS_SRC_BURST_PART_COUNT, num_particles,
            PSYS_SRC_BURST_RADIUS, 0.000000,
            PSYS_SRC_BURST_SPEED_MIN, 0.1,
            PSYS_SRC_BURST_SPEED_MAX, 0.1,
            PSYS_SRC_INNERANGLE, 1.55, 
            PSYS_SRC_OUTERANGLE, 1.54,
            PSYS_SRC_OMEGA, <0.,0.,10.>,
            PSYS_SRC_MAX_AGE, 0,
            PSYS_SRC_TEXTURE, "",
            PSYS_PART_START_ALPHA, 0.3,
            PSYS_PART_END_ALPHA, 0.6
    ]);
}

hearts() {
    stop_particles();
    if ((animation != "") && (use_anims)) {
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    llParticleSystem([ 
           PSYS_SRC_TEXTURE, "5b3f3df0-b20b-5dc4-b49e-377c5805a0e3",
           PSYS_PART_START_SCALE, <0.2, 0.2, FALSE>,
           PSYS_PART_END_SCALE, <0.6, 0.6, FALSE>, 
           PSYS_PART_START_ALPHA, 1.0,
           PSYS_PART_END_ALPHA, 0.5,     
         
           PSYS_SRC_BURST_PART_COUNT, num_particles, 
           PSYS_SRC_BURST_RATE, speed,  
           PSYS_PART_MAX_AGE,         2.0, 
           PSYS_SRC_MAX_AGE,          0.0,  
        
           PSYS_SRC_PATTERN, 2,
           PSYS_SRC_BURST_SPEED_MIN, 0.5,
           PSYS_SRC_BURST_SPEED_MAX, 2.0, 
           PSYS_SRC_BURST_RADIUS, 0.000000,
        
           PSYS_SRC_ANGLE_BEGIN,  0.05*PI,
           PSYS_SRC_ANGLE_END, 0.05*PI,  
           PSYS_SRC_OMEGA, < 0.0, 0.0, 0.0 >, 
        
           PSYS_SRC_ACCEL, < 0.0, 0.0, 0.0 >,  
           PSYS_SRC_TARGET_KEY, (key)"",       
              
           PSYS_PART_FLAGS, ( 0      
                                | PSYS_PART_INTERP_COLOR_MASK   
                                | PSYS_PART_INTERP_SCALE_MASK   
                                | PSYS_PART_EMISSIVE_MASK   
                                | PSYS_PART_FOLLOW_VELOCITY_MASK
                                | PSYS_PART_WIND_MASK            
                            ) 
           ]);
}

shamrocks() {
    stop_particles();
    if ((animation != "") && (use_anims)) {
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    llParticleSystem([ 
           PSYS_SRC_TEXTURE, "7831c620-2a9f-c67b-b7b6-108e149e490c",
           PSYS_PART_START_SCALE, <0.2, 0.2, FALSE>,
           PSYS_PART_END_SCALE, <0.6, 0.6, FALSE>, 
           PSYS_PART_START_ALPHA, 1.0,
           PSYS_PART_END_ALPHA, 0.5,     
         
           PSYS_SRC_BURST_PART_COUNT, num_particles, 
           PSYS_SRC_BURST_RATE, speed,  
           PSYS_PART_MAX_AGE,         2.0, 
           PSYS_SRC_MAX_AGE,          0.0,  
        
           PSYS_SRC_PATTERN, 2,
           PSYS_SRC_BURST_SPEED_MIN, 0.5,
           PSYS_SRC_BURST_SPEED_MAX, 2.0, 
           PSYS_SRC_BURST_RADIUS, 0.000000,
        
           PSYS_SRC_ANGLE_BEGIN,  0.05*PI,
           PSYS_SRC_ANGLE_END, 0.05*PI,  
           PSYS_SRC_OMEGA, < 0.0, 0.0, 0.0 >, 
        
           PSYS_SRC_ACCEL, < 0.0, 0.0, 0.0 >,  
           PSYS_SRC_TARGET_KEY, (key)"",       
              
           PSYS_PART_FLAGS, ( 0      
                                | PSYS_PART_INTERP_COLOR_MASK   
                                | PSYS_PART_INTERP_SCALE_MASK   
                                | PSYS_PART_EMISSIVE_MASK   
                                | PSYS_PART_FOLLOW_VELOCITY_MASK
                                | PSYS_PART_WIND_MASK            
                            ) 
           ]);
}

Bling() {
    stop_particles();
    llParticleSystem([ 
        PSYS_PART_FLAGS , ( 0 
                             | PSYS_PART_INTERP_COLOR_MASK
                             | PSYS_PART_INTERP_SCALE_MASK
                             | PSYS_PART_FOLLOW_SRC_MASK
                             | PSYS_PART_FOLLOW_VELOCITY_MASK
                             | PSYS_PART_EMISSIVE_MASK ) ,
        PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
        PSYS_SRC_TEXTURE, "" ,
        PSYS_SRC_MAX_AGE, 0.0 ,
        PSYS_PART_MAX_AGE, 0.2 ,
        PSYS_SRC_BURST_RATE, speed,
        PSYS_SRC_BURST_PART_COUNT, num_particles ,
        PSYS_SRC_BURST_RADIUS, 10.0 ,
        PSYS_SRC_BURST_SPEED_MIN, .1 ,
        PSYS_SRC_BURST_SPEED_MAX, .1 ,
        PSYS_SRC_ACCEL, <0,0,0> ,
        PSYS_PART_START_COLOR, <1,1,1> ,
        PSYS_PART_END_COLOR, <1,1,1> ,
        PSYS_PART_START_ALPHA, 1.0 ,
        PSYS_PART_END_ALPHA, 1.0 ,
        PSYS_PART_START_SCALE, <.04,.25,.01> ,
        PSYS_PART_END_SCALE, <.03,.25,.01> ,
        PSYS_SRC_ANGLE_BEGIN, 1.54 ,
        PSYS_SRC_ANGLE_END, 1.55 ,
        PSYS_SRC_OMEGA, <0.0,0.0,0.0>
    ]);
}

Sparkle() {
    stop_particles();
    if ((animation != "") && (use_anims)) {
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    llParticleSystem([ 
        PSYS_PART_START_SCALE, <0.00, 0.10, 0>,
        PSYS_PART_END_SCALE, <0.10, 0.00, 0>,
        PSYS_PART_START_COLOR, <1.00,1.00,1.00>,
        PSYS_PART_END_COLOR, <1.00,1.00,1.00>,
        PSYS_PART_START_ALPHA, (float) 1.0,
        PSYS_PART_END_ALPHA, (float) 1.0,
        PSYS_SRC_BURST_PART_COUNT, num_particles,
        PSYS_SRC_BURST_RATE, speed,
        PSYS_PART_MAX_AGE, (float) 0.30,
        PSYS_SRC_MAX_AGE, (float) 0.00,
        PSYS_SRC_PATTERN, (integer) 8,
        PSYS_SRC_BURST_SPEED_MIN, (float) 00.10,
        PSYS_SRC_BURST_SPEED_MAX, (float) 00.10,
        PSYS_SRC_BURST_RADIUS, (float) 00.50,
        PSYS_SRC_ANGLE_BEGIN, (float) 0.00 *PI,
        PSYS_SRC_ANGLE_END, (float) 1.00 *PI,
        PSYS_SRC_OMEGA, <00.00, 00.00, 00.00>,
        PSYS_SRC_ACCEL, < 00.00, 00.00, - 00.10>,
        PSYS_PART_FLAGS, (integer) ( 0 | PSYS_PART_INTERP_COLOR_MASK | PSYS_PART_INTERP_SCALE_MASK | PSYS_PART_EMISSIVE_MASK )
    ]);
}

Blue_Balls() {
    stop_particles();
    if ((animation != "") && (use_anims)) {
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    llParticleSystem([ 
        PSYS_PART_MAX_AGE, 10.5,
        PSYS_PART_START_COLOR, <0.45,1,1>,
        PSYS_PART_END_COLOR, <0.45,1,1>,
        PSYS_PART_START_SCALE, <0.3,0.3,0.3>,
        PSYS_PART_END_SCALE, <0.3,0.3,0.3>,
        PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_ANGLE_CONE,
        PSYS_SRC_BURST_RATE, speed,
        PSYS_SRC_ACCEL, <0,1.0,0>,
        PSYS_SRC_BURST_PART_COUNT, num_particles,
        PSYS_SRC_BURST_SPEED_MIN, 0.05,
        PSYS_SRC_BURST_SPEED_MAX, 2.0,
        PSYS_SRC_INNERANGLE, 0.5,
        PSYS_SRC_OUTERANGLE, 0.0,
        PSYS_SRC_OMEGA, <0,0,0>,
        PSYS_PART_START_ALPHA, 1.0,
        PSYS_PART_END_ALPHA, 0.25,
        PSYS_PART_FLAGS,
            ( 0 | PSYS_PART_EMISSIVE_MASK | PSYS_PART_INTERP_COLOR_MASK | PSYS_PART_WIND_MASK | PSYS_PART_FOLLOW_SRC_MASK | PSYS_PART_FOLLOW_VELOCITY_MASK )
    ]);
}

part_two() {
    stop_particles();
    if ((animation != "") && (use_anims)) {
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    llParticleSystem([ 
           PSYS_SRC_TEXTURE, "", 
           PSYS_PART_START_SCALE, <0.2, 0.2, FALSE>,
           PSYS_PART_END_SCALE, <0.5, 0.5, FALSE>, 
           PSYS_PART_START_COLOR, <1.0, 0.0, 0.0>,
           PSYS_PART_END_COLOR, <0.0, 0.0, 1.0>,
           PSYS_PART_START_ALPHA, 1.0,
           PSYS_PART_END_ALPHA, 0.5,     
         
           PSYS_SRC_BURST_PART_COUNT, num_particles, 
           PSYS_SRC_BURST_RATE, speed,  
           PSYS_PART_MAX_AGE,         2.0, 
           PSYS_SRC_MAX_AGE,          0.0,  
        
           PSYS_SRC_PATTERN, 2,
           PSYS_SRC_BURST_SPEED_MIN, 0.5,
           PSYS_SRC_BURST_SPEED_MAX, 2.0, 
           PSYS_SRC_BURST_RADIUS, 0.000000,
        
           PSYS_SRC_ANGLE_BEGIN,  0.05*PI,
           PSYS_SRC_ANGLE_END, 0.05*PI,  
           PSYS_SRC_OMEGA, < 0.0, 0.0, 0.0 >, 
        
           PSYS_SRC_ACCEL, < 0.0, 0.0, 0.0 >,  
           PSYS_SRC_TARGET_KEY, (key)"",       
              
           PSYS_PART_FLAGS, ( 0      
                                | PSYS_PART_INTERP_COLOR_MASK   
                                | PSYS_PART_INTERP_SCALE_MASK   
                                | PSYS_PART_EMISSIVE_MASK   
                                | PSYS_PART_FOLLOW_VELOCITY_MASK
                                | PSYS_PART_WIND_MASK            
                            ) 
    ]);
}

lightning_strike() {
    stop_particles();
    if ((animation != "") && (use_anims)) {
        if (animation != _NONE)
            llStartAnimation(animation);
    }
    llParticleSystem([ 
           PSYS_SRC_TEXTURE, lightning, 
           PSYS_PART_START_SCALE, <0.5, 0.5, FALSE>,
           PSYS_PART_END_SCALE, <4.0, 4.0, FALSE>, 
           PSYS_PART_START_ALPHA, 1.0,
           PSYS_PART_END_ALPHA, 0.7,     
         
           PSYS_SRC_BURST_PART_COUNT, num_particles, 
           PSYS_SRC_BURST_RATE, speed,  
           PSYS_PART_MAX_AGE,          20.0, 
           PSYS_SRC_MAX_AGE,           0.0,  

           PSYS_SRC_PATTERN, 2,
           PSYS_SRC_BURST_SPEED_MIN, 0.0,
           PSYS_SRC_BURST_SPEED_MAX, 0.5, 
           PSYS_SRC_BURST_RADIUS, 4.000000,
        
           PSYS_SRC_ANGLE_BEGIN,  PI,
           PSYS_SRC_ANGLE_END, PI,  
           PSYS_SRC_OMEGA, < 0.0, 0.0, 0.0 >, 
        
           PSYS_SRC_ACCEL, < 0.0, 0.0, 0.0 >,  
           PSYS_SRC_TARGET_KEY, object_key,       
              
           PSYS_PART_FLAGS, ( 0      
                                | PSYS_PART_INTERP_COLOR_MASK   
                                | PSYS_PART_INTERP_SCALE_MASK   
                                | PSYS_PART_EMISSIVE_MASK   
                                | PSYS_PART_TARGET_POS_MASK 
                                | PSYS_PART_FOLLOW_SRC_MASK 
                                | PSYS_PART_TARGET_LINEAR_MASK    
                            ) 
    ]);
    if (thunder != "")
        llPlaySound(thunder, 1.0);
}

stop_anims() {
    list anims2stop;
    integer list_pos = 0;
    integer list_length;

    anims2stop = [];
    list_pos = 0;
    anims2stop = llGetAnimationList(owner);
    list_length = llGetListLength(anims2stop);
    if(list_length > 0){
        while(list_pos < list_length){
            llStopAnimation(llList2String(anims2stop, list_pos));
            list_pos++;
        }
    }
}

stop_particles() {
    llParticleSystem([]);
    if (animation != "") {
        if (animation != _NONE)
            llStopAnimation(animation);
        if (random)
            anim_num = (integer)llFrand((float)(num_anims + 1));
        else
            anim_num++;
        if (anim_num > num_anims)
            anim_num = 0;
        if (anim_num < num_anims)
            animation = llGetInventoryName(INVENTORY_ANIMATION, anim_num);
        else
            animation = _NONE;
    }
}

start_anim(string amation) {
    if (amation != "") {
        stop_anims();
        use_anims = 1;
        animation = amation;
        llStartAnimation(animation);
    }
}

Info(key okey) {
    string regionname = llDumpList2String(llParseString2List(
                        llGetRegionName(),[" "],[]),"%20");
    list a = llGetObjectDetails(okey,
              [OBJECT_NAME, OBJECT_DESC, OBJECT_POS,
               OBJECT_OWNER, OBJECT_GROUP, OBJECT_CREATOR,
               OBJECT_RUNNING_SCRIPT_COUNT,
               OBJECT_TOTAL_SCRIPT_COUNT,
               OBJECT_SCRIPT_MEMORY,
               OBJECT_SCRIPT_TIME,
               OBJECT_PRIM_EQUIVALENCE]);
    vector pos = llList2Vector(a, 2);
    integer x = (integer)pos.x;
    integer y = (integer)pos.y;
    integer z = (integer)pos.z;
    string slurl = "http://slurl.com/secondlife/" +
                   regionname + "/" +
                   (string)x + "/" + (string)y + "/" + (string)z + "/";
    llOwnerSay("Found UUID " + (string)okey + " with:" +
    "\nName: \""        + llList2String(a,0) + "\"" +
    "\nDescription: \"" + llList2String(a,1) + "\"" +
    "\nPosition: "      + llList2String(a,2) +
    "\nSlurl: "         + slurl +
    "\nOwner: "         + llList2String(a,3) +
    "\nGroup: "         + llList2String(a,4) +
    "\nCreator: "       + llList2String(a,5));
    llOwnerSay("Performance statistics:" +
    "\n\tRunning scripts: "   + llList2String(a,6) +
    "\n\tTotal scripts: "     + llList2String(a,7) +
    "\n\tScript memory: "     + llList2String(a,8) +
    "\n\tScript time: "       + llList2String(a,9) +
    "\n\tPrim equivalence: "  + llList2String(a,10) + "\n");
}

Set_Defaults() {
    if (disp_num == 0) {
        num_particles = 1;
        speed = 0.01;
    }
    else if (disp_num == 1) {
        num_particles = 6;
        speed = 0.1;
    }
    else if (disp_num == 2) {
        num_particles = 6;
        speed = 0.1;
    }
    else if (disp_num == 3) {
        num_particles = 10;
        speed = 0.1;
    }
    else if (disp_num == 4) {
        num_particles = 1;
        speed = 0.01;
    }
    else if (disp_num == 5) {
        num_particles = 1;
        speed = 20.0;
    }
    else if (disp_num == 6) {
        num_particles = 6;
        speed = 0.5;
    }
    else if (disp_num == 7) {
        num_particles = 2;
        speed = 0.05;
    }
    else if (disp_num == 8) {
        num_particles = 31;
        speed = 2.6;
    }
    else if (disp_num == 9) {
        num_particles = 6;
        speed = 0.1;
    }
}

Change_Display() {
    if (disp_num == 0)
        start_beam(key_target, llList2Vector(
                      llGetObjectDetails(key_target, [OBJECT_POS]), 0));
    else if (disp_num == 1)
        shamrocks();
    else if (disp_num == 2)
        part_two();
    else if (disp_num == 3)
        bubbles_on();
    else if (disp_num == 4)
        start_particles(key_target, llList2Vector(
                      llGetObjectDetails(key_target, [OBJECT_POS]), 0));
    else if (disp_num == 5)
        Cycle_Lightning();
    else if (disp_num == 6)
        Bling();
    else if (disp_num == 7)
        Sparkle();
    else if (disp_num == 8)
        Blue_Balls();
    else if (disp_num == 9)
        hearts();
}

Cycle_Display() {
    if (random)
        disp_num = (integer)llFrand((float)num_disps);
    else
        disp_num++;
    if (disp_num >= num_disps) {
        disp_num = 0;
        if (random)
            anim_num = (integer)llFrand((float)num_anims);
        else
            anim_num++;
        if (anim_num >= num_anims)
            anim_num = 0;
    }
    Set_Defaults();
    Change_Display();
}

Cycle_Lightning() {
    if (random)
        lite_num = (integer)llFrand((float)num_lites);
    else
        lite_num++;
    if (lite_num >= num_lites) {
        lite_num = 0;
        if (random)
            anim_num = (integer)llFrand((float)num_anims);
        else
            anim_num++;
        if (anim_num >= num_anims)
            anim_num = 0;
    }
    // Set lightning texture and thunder sound to use
    if (lite_num < num_lites) {
        if (flipped)
            lightning = llList2Key(lightning_flippeds, lite_num);
        else
            lightning = llList2Key(lightning_textures, lite_num);
        thunder = "";
        if ((integer)llFrand(3.0) == 1) {
            thunder = llList2Key(thunder_sounds, thun_num);
            thun_num++;
            if (thun_num >= num_thuns)
                thun_num = 0;
        }
        lightning_strike();
    }
    else
        stop_particles();
}

default
{
    on_rez(integer start_param)
    {
        llResetScript();
    }

    state_entry()
    {
        stop_particles();
        owner = llGetOwner();
        object_key = llGetKey();
        num_lites = llGetListLength(lightning_textures);
        num_thuns = llGetListLength(thunder_sounds);
        num_anims = 0;
        if (llGetInventoryType(fire_anim) == INVENTORY_ANIMATION)
            num_anims++;
        else
            fire_anim = "";
        if (llGetInventoryType(beam_anim) == INVENTORY_ANIMATION)
            num_anims++;
        else
            beam_anim = "";
        if (llGetInventoryType(bubb_anim) == INVENTORY_ANIMATION)
            num_anims++;
        else
            bubb_anim = "";
        if (llGetInventoryType(part_anim) == INVENTORY_ANIMATION)
            num_anims++;
        else
            part_anim = "";
        use_anims = 0;
        if (num_anims > 0) {
            use_anims = 1;
            command_names = command_names + [ "Anims On", "Anims Off",
                                              "Draw Anim", "Kick Anim",
                                              "Yoga Sit", "Yoga Stand" ];
        }
        llMessageLinked(LINK_THIS, 89,
                    llDumpList2String(command_names, ","), "");
        if (llGetAttached())
            llRequestPermissions(owner, PERMISSION_TRIGGER_ANIMATION);
    }

    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_TRIGGER_ANIMATION)
        {
            if (num_anims > 0)
                animation = llGetInventoryName(INVENTORY_ANIMATION, 0);
        }
    }
    
    timer()
    {
        if (laser_count < 0) {
            firing = 0;
            scanning = 0;
            stop_particles();
            laser_count = 0;
            llSetTimerEvent(0.0);
        }
        if (firing || scanning) {
            llTriggerSound("237ee9be-d7d7-1aed-671e-060b39b58d11", 1.0);
            laser_count += 1;
            if(laser_count == 8)
            {
                laser_count = -1;
                llSetTimerEvent(5.0);
            }
        }
        if (cycle)
            Cycle_Display();
        else if (use_lightning) {
            disp_num = 5;
            Set_Defaults();
            Cycle_Lightning();
        }
    }
 
    link_message(integer sender, integer num, string message, key trigger)
    {
        string tmpnam;
        integer length;
        integer i;

        if ((num == 103) || (num == 154)) {
            if (message == "Laser") {
                cycle = 0;
                use_lightning = 0;
                firing = 1;
                llSensor("", "", AGENT, range, PI);
            }
            else if (message == "Bling") {
                cycle = 0;
                use_lightning = 0;
                disp_num = 6;
                Set_Defaults();
                Bling();
            }
            else if (message == "Sparkle") {
                cycle = 0;
                use_lightning = 0;
                disp_num = 7;
                Set_Defaults();
                Sparkle();
            }
            else if (message == "Blue Balls") {
                cycle = 0;
                use_lightning = 0;
                disp_num = 8;
                Set_Defaults();
                Blue_Balls();
            }
            else if (message == "Burst") {
                cycle = 0;
                use_lightning = 0;
                disp_num = 2;
                Set_Defaults();
                part_two();
            }
            else if (message == "Bubbles") {
                cycle = 0;
                disp_num = 3;
                Set_Defaults();
                bubbles_on();
            }
            else if (message == "Cycle") {
                cycle = 1;
                use_lightning = 0;
                random = 0;
                disp_num = 0;
                anim_num = 1;
                Cycle_Display();
                nearby_keys = [];
                nearby_names = [];
                firing = 0;
                scanning = 0;
                llSensor("", "", ACTIVE|PASSIVE, range, PI);
                llSetTimerEvent(60.0);
            }
            else if (message == "Lightning") {
                cycle = 0;
                use_lightning = 1;
                random = 1;
                lite_num = 0;
                anim_num = 1;
                disp_num = 5;
                Set_Defaults();
                Cycle_Lightning();
                firing = 0;
                scanning = 0;
                llSetTimerEvent(20.0);
            }
            else if (message == "Random") {
                cycle = 1;
                use_lightning = 0;
                random = 1;
                anim_num = (integer)llFrand((float)num_anims);
                disp_num = (integer)llFrand((float)num_disps);
                Cycle_Display();
                nearby_keys = [];
                nearby_names = [];
                firing = 0;
                scanning = 0;
                llSensor("", "", ACTIVE|PASSIVE, range, PI);
                llSetTimerEvent(60.0);
            }
            else if (message == "Sync") {
                disp_num = 0;
                anim_num = 1;
                random = 0;
            }
            else if (message == "Hearts") {
                cycle = 0;
                use_lightning = 0;
                disp_num = 9;
                Set_Defaults();
                hearts();
            }
            else if ((message == "Shamrocks") || (message == "Clovers")) {
                cycle = 0;
                use_lightning = 0;
                disp_num = 1;
                Set_Defaults();
                shamrocks();
            }
            else if (message == "Off") {
                llSetTimerEvent(0.0);
                laser_count = 0;
                firing = 0;
                scanning = 0;
                cycle = 0;
                use_lightning = 0;
                stop_particles();
            }
            else if (message == "Avatars") {
                nearby_keys = [];
                nearby_names = [];
                firing = 0;
                llSensor("", "", AGENT, range, PI);
            }
            else if (message == "Scan") {
                nearby_keys = [];
                nearby_names = [];
                firing = 0;
                llSensor("", "", AGENT|ACTIVE|PASSIVE, range, PI);
            }
            else if (message == "Draw Anim") {
                start_anim(fire_anim);
            }
            else if (message == "Kick Anim") {
                start_anim(beam_anim);
            }
            else if (message == "Yoga Sit") {
                start_anim(bubb_anim);
            }
            else if (message == "Yoga Stand") {
                start_anim(part_anim);
            }
            else if (message == "Anims On") {
                if (num_anims > 0)
                    use_anims = 1;
            }
            else if (message == "Anims Off") {
                use_anims = 0;
            }
            else if (message == "More") {
                if (num_particles < 5)
                    num_particles *= 2;
                else
                    num_particles += 5;
                Change_Display();
            }
            else if (message == "Less") {
                if (num_particles < 10)
                    num_particles /= 2;
                else
                    num_particles -= 5;
                if (num_particles < 1)
                    num_particles = 1;
                Change_Display();
            }
            else if (message == "Faster") {
                if (speed < 0.01)
                    speed = 0.0;
                else
                    speed /= 2.0;
                Change_Display();
            }
            else if (message == "Slower") {
                if (speed < 1.0)
                    speed *= 2.0;
                else
                    speed += 1.0;
                Change_Display();
            }
            else if (message == "Next Ptcl") {
                disp_num += 1;
                if (disp_num >= num_disps)
                    disp_num = 0;
                Set_Defaults();
                Change_Display();
            }
            else if (message == "Prev Ptcl") {
                disp_num -= 1;
                if (disp_num < 0)
                    disp_num = num_disps - 1;
                Set_Defaults();
                Change_Display();
            }
            else if (message == "Default") {
                Set_Defaults();
                Change_Display();
            }
            else if (message == "Get Commands") {
                llMessageLinked(LINK_THIS, 89,
                    llDumpList2String(command_names, ","), "");
            }
        }
        else if (num == 1540) {
            cycle = 0;
            use_lightning = 0;
            firing = 0;
            scanning = 1;
            scan_by_name = message;
            llSensor(message, "", AGENT|ACTIVE|PASSIVE, 96.0, PI);
        }
        else if (num == 350) {
            if (message == "Full Report") {
                length = llGetListLength(nearby_keys);
                for (i = 0; i < length; ++i) {
                    Info(llList2Key(nearby_keys, i));
                }
            }
            else if (message == "flipped") {
                flipped = 1;
                num_lites = llGetListLength(lightning_flippeds);
            }
            else if (message == _ON) {
                nearby_keys = [];
                nearby_names = [];
            }
            else if (message == _OFF) {
                llMessageLinked(LINK_THIS, 501, _ON, "");
                llSleep(0.2);
                length = llGetListLength(nearby_names);
                for (i = 0; i < length; ++i) {
                    llMessageLinked(LINK_THIS, 501,
                                    llList2String(nearby_names, i), "");
                }
                llSleep(0.2);
                llMessageLinked(LINK_THIS, 501, _OFF, "");
            }
            else {
                nearby_keys = nearby_keys + [message];
                tmpnam = llKey2Name((key)message);
                if (tmpnam == "")
                    nearby_names = nearby_names + ["(empty)"];
                else {
                    if (llStringLength(tmpnam) > 12)
                        nearby_names = nearby_names + 
                                       [llGetSubString(tmpnam, 0, 11)];
                    else
                        nearby_names = nearby_names + [tmpnam];
                }
            }
        }
        else if (num == 502) {
            integer tar_pos = llListFindList(nearby_names, [message]);
            if (~tar_pos) {
                key t_av = llList2Key(nearby_keys, tar_pos);
                if (trigger == "0") {
                    firing = 1;
                    disp_num = 4;
                    Set_Defaults();
                    start_particles(t_av,
                      llList2Vector(llGetObjectDetails(t_av, [OBJECT_POS]), 0));
                    llSetTimerEvent(0.1);
                }
                else if (trigger == "2") {
                    scanning = 1;
                    disp_num = 0;
                    Set_Defaults();
                    Info(t_av);
                    start_beam(t_av, llList2Vector(
                                     llGetObjectDetails(t_av,[OBJECT_POS]),0));
                    llSetTimerEvent(0.1);
                }
            }
        }
    }

    changed(integer change)
    {
        key avatar = NULL_KEY;
        if (change & CHANGED_INVENTORY)
        {
            llResetScript();
        }
        else if (change & CHANGED_LINK)
        {
            avatar = llAvatarOnSitTarget();
            if (avatar != NULL_KEY)
            {
                llRequestPermissions(avatar, PERMISSION_TRIGGER_ANIMATION);
            }
        }
    }

    no_sensor() {
        firing = 0;
        scanning = 0;
        scan_by_name = "";
        laser_count = 0;
        if (!cycle)
            llSetTimerEvent(0.0);
    }

    sensor(integer total_number)
    {
        integer num_av = 0;
        integer j;
        string _name;
        string _key;
        vector pos_target;

        if (firing) {
            for (num_av = total_number - 1; num_av > -1; num_av--) {
                key_target = llDetectedKey(num_av);
                pos_target = llDetectedPos(num_av);
                if (key_target == av_target) {
                    disp_num = 4;
                    Set_Defaults();
                    start_particles(key_target, pos_target);
                    llSetTimerEvent(0.1);
                    return;
                }
            }
        }
        if (firing) {
            disp_num = 4;
            Set_Defaults();
            start_particles(key_target, pos_target);
            llSetTimerEvent(0.1);
            return;
        }
        // Scan was filtered by name, beam the closest
        if (scan_by_name != "") {
            for (num_av = 0; num_av < total_number; num_av++) {
                key_target = llDetectedKey(num_av);
                pos_target = llDetectedPos(num_av);
                disp_num = 4;
                Set_Defaults();
                start_particles(key_target, pos_target);
                scan_by_name = "";
                llSetTimerEvent(0.1);
                return;
            }
        }
        // Not firing, just scanning
        for (num_av = 0; num_av < total_number; num_av++)
        {
            _key = (string)llDetectedKey(num_av);
            nearby_keys = nearby_keys + [_key];
            _name = llKey2Name((key)_key);
            if (_name == "")
                nearby_names = nearby_names + ["(empty)"];
            else
                nearby_names = nearby_names + [_name];
        }
        num_av = llGetListLength(nearby_keys);
        if (cycle)
            key_target = llList2Key(nearby_keys, num_av - 1);
        else {
            for (j = 0; j < num_av; ++j) {
                Info(llList2Key(nearby_keys, j));
            }
        }
    }
}
