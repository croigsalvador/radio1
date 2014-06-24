//
//  ASMenuViewController.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASMenuViewController.h"
#import "MenuItem+Helper.h"

@interface ASMenuViewController ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableArray *menuData;

@end

@implementation ASMenuViewController

#pragma mark - Life Cycle

- (id)init {
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSInvocationOperation * loadOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(populateMenuArrayAsynchronous) object:nil];
    [self.operationQueue addOperation:loadOperation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

//Example of loading data with nsinvocationoperation, the array is not too big but it's just an example of async operations
- (void)populateMenuArrayAsynchronous {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSString *path          = [[NSBundle mainBundle] pathForResource:@"PlayListMenu" ofType:@"plist"];
    NSDictionary *menuDict  = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *menuArray = [menuDict objectForKey:kTagMenuItemMenuItems];
    for (NSDictionary *menuItemDic in menuArray) {
        [dataArray addObject:[MenuItem menuItemWithDictionary:menuItemDic]];
    }
    
    [self performSelectorOnMainThread:@selector(addDataToMenuArrayWithArray:) withObject:dataArray waitUntilDone:NO];
 
}

- (void)addDataToMenuArrayWithArray:(NSMutableArray *)dataArray {
    self.menuData = dataArray;
    NSLog(@"%@", self.menuData);
}

#pragma mark - Private Custom Setters

-(void)setMenuData:(NSMutableArray *)menuData {
    _menuData = menuData;
}
@end
