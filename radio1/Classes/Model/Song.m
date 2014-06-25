//
//  Song.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "Song.h"

@implementation Song

- (NSString *)description {
    return [NSString stringWithFormat:@"Song: %@ - Artist: %@", self.title, self.artist];
}

@end
