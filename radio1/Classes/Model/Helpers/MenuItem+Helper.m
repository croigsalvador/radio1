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

    return item;
}

@end
