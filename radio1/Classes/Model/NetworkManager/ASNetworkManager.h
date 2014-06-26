//
//  ASNetworkManager.h
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"

@class Song, MediaAudio;

@interface ASNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedInstance;

#pragma mark - Public Methods

- (AFHTTPRequestOperation *)getPlayListSongsWithTuneId:(NSString *)tuneId  completion:(void (^)(NSArray *results, NSError *error))completionBlock;
- (AFHTTPRequestOperation *)getSongPlayDetails:(Song *)song completion:( void (^)(MediaAudio *result, NSError *error) )completionBlock;
- (AFHTTPRequestOperation *)getRelatedTunesWithArtistName:(NSString *)artistName completion:(void (^)(NSArray *results, NSError *error))completionBlock;
@end
