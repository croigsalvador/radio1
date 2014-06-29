//
//  radio1Tests.m
//  radio1Tests
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ASMenuViewController.h"
#import "ASMenuViewController+Private.h"
#import "ASMenuCollectionViewCell.h"

static const NSInteger kNumberOfSectionsMenu        = 1;

@interface ASMenuViewControllerTest : XCTestCase
@property (nonatomic, strong) ASMenuViewController *vc;
@end

@implementation ASMenuViewControllerTest

- (void)setUp {
    [super setUp];
    self.vc = [[ASMenuViewController alloc] init];
    self.vc.menuData = [self.vc populateMenuArrayAsynchronous];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//[Init] Test the init method and custom getters.
- (void)testInitNotNil {
    XCTAssertNotNil(self.vc, @"Test ASMenuViewController object not instantiated");
    XCTAssertNotNil(self.vc.operationQueue, @"Test ASMenuViewController (operationQueue) object not instantiated");
    XCTAssertNotNil(self.vc.menuCollectionView, @"Test ASMenuViewController (menuCollectionView) object not instantiated");
    XCTAssertNotNil(self.vc.menuCollectionView.delegate, @"Test ASMenuViewController (menuCollectionView.delegate) object not setted");
    XCTAssertNotNil(self.vc.menuCollectionView.dataSource, @"Test ASMenuViewController (menuCollectionView.datasource) object not setted");
    XCTAssertNotNil(self.vc.flowLayout, @"Test ASMenuViewController object (flowLayout) not instantiated");
}
- (void)testViewDidLoad {
    [self.vc viewDidLoad];
    //Load operation added to the operation queue
    XCTAssertGreaterThan([self.vc.operationQueue operationCount], 0, @"Test ASMenuViewControllerDidLoad (operantion) object not instantiated");
}

- (void)testPopulateMenuArrayAsynchronous {
    NSMutableArray *menuData = [self.vc populateMenuArrayAsynchronous];
    XCTAssertGreaterThan([menuData count], 0, @"Test PopulateMenuArrayAsynchronous (menuData) object not instantiated");
}

- (void)testNumberOfItemsInSectionWithNilCollectionView {
    UICollectionView *nilCollectionView = nil;
    NSInteger numberOfItems = [nilCollectionView numberOfItemsInSection:0];
    XCTAssertEqual(numberOfItems, 0, @"Test numberOfItemsInSection number of items for a nil collection >0");
}

- (void)testNumberOfItemsInSectionWithMenuCollectionView {
    NSInteger numberOfItems = [self.vc.menuCollectionView numberOfItemsInSection:0];
    XCTAssertEqual(numberOfItems, [self.vc.menuData count], @"Test numberOfItemsInSection number of items different than number of self.menudata");
}

- (void)testNumberSectionsWithMenuCollectionView {
    NSInteger numberOfSections = [self.vc.menuCollectionView numberOfSections];
    XCTAssertEqual(numberOfSections, kNumberOfSectionsMenu, @"Test numberOfSections number of sections not correct");
}

- (void)testNumberSectionsWithNilCollectionView {
    UICollectionView *nilCollectionView = nil;
    NSInteger numberOfSections = [nilCollectionView numberOfSections];
    XCTAssertEqual(numberOfSections, 0, @"Test numberOfSections number of sections not correct");
}

- (void)testCellForIndexPathWithNilCollectionView {
    UICollectionView *nilCollectionView = nil;
    UICollectionViewCell *cell = [self.vc collectionView:nilCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    XCTAssertNil(cell, @"Test cellForIndexPath (0,0) for NIL collectionview is not a NIL");
}

- (void)testCellForIndexPathWithMenuCollectionView {
    ASMenuCollectionViewCell *cell = (ASMenuCollectionViewCell *)[self.vc collectionView:self.vc.menuCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    XCTAssertEqual([cell class], [ASMenuCollectionViewCell class], @"Test cellForIndexPath (0,0) is not a ASMenuCollectionViewCell");
}

@end
