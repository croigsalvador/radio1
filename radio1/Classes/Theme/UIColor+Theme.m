//
//  UIColor+Theme.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)primaryTextColor {
    return [UIColor whiteColor];
}
+ (UIColor *)primaryColor {
    return [UIColor blackColor];
}
+ (UIColor *)secondaryColor {
    return [UIColor colorWithRed:(30.0/255) green:(30.0/255) blue:(30.0/255) alpha:(30.0/255)];
}


@end
