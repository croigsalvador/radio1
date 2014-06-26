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
    
    @try { //prevent crashes... data of the json not well formated (sometimes) bcc api...
        aSong.title = nvl(dict[kTagAPISongTitle]);
        aSong.artist = nvl(dict[kTagAPISongArtist]);
        aSong.imageURL = nvl([NSURL URLWithString:dict[kTagAPISongImageURL]]);
        aSong.mediaStringURL = nvl(dict[kTagAPISongPlayList]);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception parsing> %@",exception);
        aSong = nil;
    }
    @finally {
        return aSong;
    }

}

@end
