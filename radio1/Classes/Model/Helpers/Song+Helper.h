//
//  Song+Helper.h
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "Song.h"

@interface Song (Helper)

+ (Song *)songWithDictionary:(NSDictionary*)dict;

@end
