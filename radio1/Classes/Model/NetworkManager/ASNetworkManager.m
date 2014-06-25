//
//  ASNetworkManager.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASNetworkManager.h"
#import "Song+Helper.h"

@interface ASNetworkManager ()

@property (nonatomic)  dispatch_queue_t parsingQueue;

@end

@implementation ASNetworkManager

#pragma mark - Shared Instance

+ (instancetype)sharedInstance {
    static ASNetworkManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[ASNetworkManager alloc] init];
    });
    
    return manager;
}

- (id)init{
    
    self = [self initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    if(self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.parsingQueue = dispatch_queue_create("com.bbc.radio.parser",NULL);
    }
    return self;
}

#pragma mark - Public Methods

- (AFHTTPRequestOperation *)getPlayListSongsWithTuneId:(NSString *)tuneId  completion:( void (^)(NSArray *results, NSError *error) )completionBlock {
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                 URLString:[NSString stringWithFormat:@"%@%@/%@",kBaseUrl,tuneId,@"playlist.json"]
                                                                                parameters:nil error:nil];
 
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(self.parsingQueue, ^{
            NSDictionary * playList = responseObject[kTagAPIPlayList];
            NSMutableArray *playListResult = [[NSMutableArray alloc] init];
            NSLog(@"Init parser - check time");
            [[playList allKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *keyPlayList = (NSString*)obj;
                [playList[keyPlayList] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSDictionary *songDict = (NSDictionary *)obj;
                    [playListResult addObject:[Song songWithDictionary:songDict]];
                }];
            }];
            NSLog(@"End Parsing Songs, songs parsed: [%ld]", [playListResult count]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock) {
                    completionBlock(playListResult, nil);
                }
            });

        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(nil, error);
            }
        });
    }];

    [self.operationQueue addOperation:operation];
    return operation;
    
}
@end
