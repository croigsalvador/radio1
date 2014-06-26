//
//  ItunesSong+Helper.h
//  radio1
//
//  Created by Alex Sanz on 26/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ItunesSong.h"

@interface ItunesSong (Helper)
+ (ItunesSong *)itunesSongWithDictionary:(NSDictionary*)dict;
@end
