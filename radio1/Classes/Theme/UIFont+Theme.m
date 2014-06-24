//
//  UIFont+Theme.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "UIFont+Theme.h"

@implementation UIFont (Theme)

+ (UIFont *)brandMainFontWithSize:(CGFloat)size {
    return  [UIFont fontWithName:@"GeezaPro-Light" size:size];
}

+ (UIFont *)brandMainBoldFontWithSize:(CGFloat)size {
    return  [UIFont fontWithName:@"GeezaPro-Bold" size:size];
    
}
@end
