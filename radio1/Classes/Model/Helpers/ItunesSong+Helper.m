//
//  ItunesSong+Helper.m
//  radio1
//
//  Created by Alex Sanz on 26/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ItunesSong+Helper.h"

@implementation ItunesSong (Helper)

+ (ItunesSong *)itunesSongWithDictionary:(NSDictionary*)dict {
    ItunesSong *aSong = [[ItunesSong alloc] init];
    aSong.title = dict[kTagAPIItunesSongTitle];;
    aSong.artist = dict[kTagAPIItunesSongArtist];
    aSong.album = dict[kTagAPIItunesSongAlbum];
    aSong.imageURL = [NSURL URLWithString:dict[kTagAPIItunesSongImageURL]];
    aSong.audioURL = [NSURL URLWithString:dict[kTagAPIItunesSongAudioURL]];
    return aSong;
}
@end
