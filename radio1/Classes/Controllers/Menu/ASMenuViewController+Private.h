//
//  ASMenuViewController+Private.h
//  radio1
//
//  Created by Alex Sanz on 29/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

@interface ASMenuViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableArray *menuData;

@property (nonatomic, strong) UICollectionView *menuCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

- (NSMutableArray *)populateMenuArrayAsynchronous;
@end