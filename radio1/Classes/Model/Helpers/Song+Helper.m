//
//  Song+Helper.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "Song+Helper.h"

@implementation Song (Helper)

+ (Song *)songWithDictionary:(NSDictionary*)dict {
    
    Song *aSong = [[Song alloc] init];
    aSong.title = dict[kTagAPISongTitle];
    aSong.artist = dict[kTagAPISongArtist];
    aSong.imageURL = [NSURL URLWithString:dict[kTagAPISongImageURL]];
    
    return aSong;
}

@end
