//
//  MediaAudio.h
//  radio1
//
//  Created by Alex Sanz on 25/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

@interface MediaAudio : NSObject  <NSXMLParserDelegate>

@property (nonatomic, strong) NSURL *audioURL;
@property (nonatomic, assign) NSInteger duration;

- (void)parseXMLResponse:(NSXMLParser *)parser;

@end
