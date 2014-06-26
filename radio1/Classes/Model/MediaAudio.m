//
//  MediaAudio.m
//  radio1
//
//  Created by Alex Sanz on 25/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "MediaAudio.h"

@implementation MediaAudio

- (NSString *)description {
    return  [NSString stringWithFormat:@"MediaAudio: %@ - duration: %d", [self.audioURL absoluteString], self.duration];
}

#pragma mark - Public Methods 

- (void)parseXMLResponse:(NSXMLParser *)parser {
    parser.delegate = self;
    parser.shouldResolveExternalEntities = NO;
    [parser parse];
}

#pragma mark - NSXMLParser Delegates

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kTagAPIMediaAudioConnection]) {
        self.audioURL = [NSURL URLWithString:attributeDict[kTagAPIMediaAudioConnectionHref]];
    }
    if ([elementName isEqualToString:kTagAPIMediaAudioMedia]) {
        self.duration =  [attributeDict[kTagAPIMediaAudioMediaDuration] integerValue];
    }
}
@end

