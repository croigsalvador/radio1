//
//  UILabel+Theme.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "UILabel+Theme.h"

@implementation UILabel (Theme)

+ (UILabel *)baseLabelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont brandMainFontWithSize:17.0];
    label.textColor = [UIColor primaryTextColor];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines  = 0;
    return  label;
}

@end
