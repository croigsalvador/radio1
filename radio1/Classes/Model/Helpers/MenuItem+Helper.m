//
//  MenuItem+Helper.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "MenuItem+Helper.h"

@implementation MenuItem (Helper)

+ (MenuItem *)menuItemWithDictionary:(NSDictionary*)dict {
    
    MenuItem *item      = [[MenuItem alloc] init];
    item.displayName    = dict[kTagMenuItemDisplayName];
    item.tokenAPI       = dict[kTagMenuItemTokenAPI];
    item.imageIconName  = dict[kTagMenuItemImageIcon];

    CGFloat red     = [(dict[kTagMenuItemBaseColor][kTagMenuItemBaseColorRed]) floatValue]/255;
    CGFloat green   = [(dict[kTagMenuItemBaseColor][kTagMenuItemBaseColorGreen]) floatValue]/255;
    CGFloat blue    = [(dict[kTagMenuItemBaseColor][kTagMenuItemBaseColorBlue]) floatValue]/255;
    
    item.baseColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    return item;
}

@end
