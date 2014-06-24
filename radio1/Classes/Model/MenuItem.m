//
//  MenuItem.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (NSString *)description {
    return  [NSString stringWithFormat:@"DisplayName: %@ - TokenAPI: %@ - Image: %@", self.displayName, self.tokenAPI, self.imageIconName];
}

@end
