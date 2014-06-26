//
//  ItunesSong.h
//  radio1
//
//  Created by Alex Sanz on 26/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

@interface ItunesSong : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *audioURL;

@end
