//
//  Globals.h
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

static  NSString* const kBaseUrl            = @"http://www.bbc.co.uk/";
#define asNetworkManager                    [ASNetworkManager sharedInstance]
#define isLandscape                         (!UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation))

#define nvl(val)                            (val == [NSNull null])?nil:val

#pragma clang diagnostic pop