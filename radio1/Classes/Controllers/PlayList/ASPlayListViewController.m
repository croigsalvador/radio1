//
//  ASPlayListViewController.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASPlayListViewController.h"
#import "ASSongDetailViewController.h"

#import "ASSongCollectionViewCell.h"
#import "Song.h"

static NSString * const kPlayListCellIdentifier             = @"PlayListCellIdentifier";
static const CGFloat kHeightCell                            = 80.0;
static const CGFloat kMinLineSpaceCells                     = 8.0;
static const CGFloat kMinInterSpaceCells                    = 8.0;
static const UIEdgeInsets collectionSectionInsets           = {8.0, 8.0, 8.0, 8.0};

@interface ASPlayListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *playListCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *playListData;
@property (nonatomic, strong) NSOperation *op;
@end

@implementation ASPlayListViewController

- (void)dealloc {
    [self.op cancel];
}

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
    self.op = [asNetworkManager getPlayListSongsWithTuneId:self.item.tokenAPI completion:^(NSArray *results, NSError *error) {
        if (!error) {
            weakSelf.playListData = results;
            [weakSelf.playListCollectionView reloadData];
        } else {
            //error
        }
    }];
}

#pragma mark - Private Custom Getter

- (UICollectionView *)playListCollectionView {
    if (!_playListCollectionView) {
        _playListCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _playListCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _playListCollectionView.dataSource = self;
        _playListCollectionView.delegate = self;
        _playListCollectionView.backgroundColor = [UIColor primaryColor];
        
        [_playListCollectionView registerClass:[ASSongCollectionViewCell class] forCellWithReuseIdentifier:kPlayListCellIdentifier];
    }
    return _playListCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.sectionInset = collectionSectionInsets;
        _flowLayout.minimumInteritemSpacing = kMinInterSpaceCells;
        _flowLayout.minimumLineSpacing = kMinLineSpaceCells;
        _flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.playListCollectionView.bounds) - collectionSectionInsets.left - collectionSectionInsets.right, kHeightCell);
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
        Song *song = [self.playListData objectAtIndex:indexPath.row];
        ASSongDetailViewController *songDetailVC = [[ASSongDetailViewController alloc] init];
        songDetailVC.song = song;
        
        [self.navigationController pushViewController:songDetailVC animated:YES];
    }
}

@end
