//
//  ASPlayListViewController.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASPlayListViewController.h"
#import "ASSongCollectionViewCell.h"
#import "Song.h"

static NSString *kPlayListCellIdentifier            = @"PlayListCellIdentifier";
static CGFloat kHeightCell                          = 80.0;
static CGFloat kMinLineSpaceCells                   = 5.0;
static CGFloat kMinInterSpaceCells                  = 5.0;
static UIEdgeInsets collectionSectionInsets         = {5.0, 5.0, 5.0, 5.0};


@interface ASPlayListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *playListCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *playListData;
@end

@implementation ASPlayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playListCollectionView];

    [self populateDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Private Methods 

- (void)populateDataFromServer{
    __weak __typeof__(self) weakSelf = self;
    [asNetworkManager getPlayListSongsWithTuneId:self.item.tokenAPI completion:^(NSArray *results, NSError *error) {
        if (!error) {
            weakSelf.playListData = [results  mutableCopy];
            [weakSelf.playListCollectionView reloadData];
        } else {
            //error
        }
    }];
}

#pragma mark - Private Custom Getter

-(UICollectionView *)playListCollectionView {
    if (!_playListCollectionView) {
        
        _playListCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _playListCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _playListCollectionView.dataSource = self;
        _playListCollectionView.delegate = self;
        _playListCollectionView.backgroundColor = [UIColor blackColor];
        
        [_playListCollectionView registerClass:[ASSongCollectionViewCell class] forCellWithReuseIdentifier:kPlayListCellIdentifier];
        
    }
    return _playListCollectionView;
}

-(UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width-collectionSectionInsets.left-collectionSectionInsets.right, kHeightCell);
        _flowLayout.sectionInset = collectionSectionInsets;
        _flowLayout.minimumInteritemSpacing = kMinInterSpaceCells;
        _flowLayout.minimumLineSpacing = kMinLineSpaceCells;
    }
    return _flowLayout;
}
#pragma mark - CollectionView Datasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.playListCollectionView) {
        Song *aSong = (Song *)[self.playListData objectAtIndex:indexPath.row];
        ASSongCollectionViewCell *cell = (ASSongCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kPlayListCellIdentifier forIndexPath:indexPath];
        [cell configureCellWithTitle:aSong.title artist:aSong.artist imageURL:aSong.imageURL];
        
      return cell;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.playListCollectionView) {
        return [self.playListData count];
    } else {
        return 0.0;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.playListCollectionView) {
        return 1;
    } else {
        return 0;
    }
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.playListCollectionView) {
//        MenuItem *item=  (MenuItem *)[self.menuData objectAtIndex:indexPath.row];
//        [asNetworkManager getPlayListSongsWithTuneId:item.tokenAPI completion:^(NSArray *results, NSError *error) {
//            
//        }];
    }
}
@end