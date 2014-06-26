//
//  ASRequestEndPoints.h
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

//Tags for parsing the MenuItem
static NSString * const kTagMenuItemMenuItems           = @"menuItems";
static NSString * const kTagMenuItemDisplayName         = @"diplayName";
static NSString * const kTagMenuItemTokenAPI            = @"tokenAPI";
static NSString * const kTagMenuItemImageIcon           = @"imageIcon";
static NSString * const kTagMenuItemBaseColor           = @"baseColor";
static NSString * const kTagMenuItemBaseColorRed        = @"Red";
static NSString * const kTagMenuItemBaseColorGreen      = @"Green";
static NSString * const kTagMenuItemBaseColorBlue       = @"Blue";

//Tags for the playlist api call

static NSString * const kTagAPIPlayList                 = @"playlist";
static NSString * const kTagAPISongTitle                = @"title";
static NSString * const kTagAPISongArtist               = @"artist";
static NSString * const kTagAPISongImageURL             = @"image";
static NSString * const kTagAPISongPlayList             = @"playlist";

//XML parser tags
static NSString * const kTagAPIMediaAudioConnection     = @"connection";
static NSString * const kTagAPIMediaAudioConnectionHref = @"href";
static NSString * const kTagAPIMediaAudioMedia          = @"media";
static NSString * const kTagAPIMediaAudioMediaDuration   = @"duration";

#pragma clang diagnostic pop