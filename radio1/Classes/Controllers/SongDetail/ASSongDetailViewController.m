//
//  ASSongDetailViewController.m
//  radio1
//
//  Created by Alex Sanz on 25/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASSongDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ASAudioPlayerViewController.h"
#import "ASITunesCollectionViewCell.h"

#import "Song.h"
#import "MediaAudio.h"
#import "ItunesSong.h"

static NSString * const kTuneCellIdentifier                 = @"TuneCellIdentifier";
static const CGFloat kMinLineSpaceCells                     = 8.0;
static const CGFloat kMinInterSpaceCells                    = 8.0;

static const CGFloat kImageHeight                           = 250.0;
static const CGFloat kPlayerHeight                          = 50.0;

@interface ASSongDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *tunesCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *tunesData;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *playerContentView;
@property (nonatomic, strong) ASAudioPlayerViewController *playerViewController;

@end

@implementation ASSongDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.edgesForExtendedLayout =  UIRectEdgeNone;
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.playerContentView];
    [self.view addSubview:self.tunesCollectionView];

    [self addChildViewController:self.playerViewController toView:self.playerContentView];
    [self populateDataFromServer];
    
    [asNetworkManager getRelatedTunesWithArtistName:self.song.artist completion:^(NSArray *results, NSError *error) {
        if (!error) {
            self.tunesData = results;
            [self.tunesCollectionView reloadData];
        } else {
            //error
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Custom Getter 

- (UIImageView *)imageView {
    if (!_imageView) {
        CGRect frame = self.view.bounds;
        frame.size.height = kImageHeight;
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.backgroundColor= [UIColor redColor];
       [self.imageView setImageWithURL:self.song.imageURL];
        
    }
    return _imageView;
}

- (UIView *)playerContentView {
    if (!_playerContentView) {
        CGRect frame = self.view.bounds;
        frame.size.height = kPlayerHeight;
        frame.origin.y = CGRectGetHeight(self.view.bounds) - kPlayerHeight;
                                       
        _playerContentView = [[UIView alloc] initWithFrame:frame];
        _playerContentView.backgroundColor = [UIColor orangeColor];
        _playerContentView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return _playerContentView;
}

- (ASAudioPlayerViewController *)playerViewController {
    if (!_playerViewController) {
        _playerViewController = [[ASAudioPlayerViewController alloc] init];
    }
    return _playerViewController;
}

- (UICollectionView *)tunesCollectionView {
    if (!_tunesCollectionView) {
        CGRect frame = self.view.bounds;
        frame.origin.y = CGRectGetMaxY(self.imageView.frame);
        frame.size.height = CGRectGetMinY(self.playerContentView.frame) - CGRectGetMaxY(self.imageView.frame) -64;
        _tunesCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.flowLayout];
//        _tunesCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tunesCollectionView.dataSource = self;
        _tunesCollectionView.delegate = self;
        _tunesCollectionView.backgroundColor = [UIColor redColor];
        
        [_tunesCollectionView registerClass:[ASITunesCollectionViewCell class] forCellWithReuseIdentifier:kTuneCellIdentifier];
    }
    return _tunesCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(74,74);
        _flowLayout.minimumInteritemSpacing = kMinInterSpaceCells;
        _flowLayout.minimumLineSpacing = kMinLineSpaceCells;
        
    }
    return _flowLayout;
}

#pragma mark - Private Methods

- (void)populateDataFromServer{
    __weak __typeof__(self) weakSelf = self;
    [asNetworkManager getSongPlayDetails:self.song completion:^(MediaAudio *result, NSError *error) {
        if (!error) {
            NSLog(@"URL Audio play: %@ duration: %d", result.audioURL, result.duration );
            weakSelf.playerViewController.audioURL = result.audioURL;
        } else {
            //error
        }
    }];
}

#pragma mark - CollectionView Datasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.tunesCollectionView) {
        ItunesSong *song = [self.tunesData objectAtIndex:indexPath.row];
        ASITunesCollectionViewCell *cell = (ASITunesCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kTuneCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
        [cell configureCellWithTitle:song.title album:nil imageURL:song.imageURL];
        
        return cell;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.tunesCollectionView) {
        return [self.tunesData count];
    } else {
        return 0.0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.tunesCollectionView) {
        return 1;
    } else {
        return 0;
    }
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.tunesCollectionView) {
        ItunesSong *song = [self.tunesData objectAtIndex:indexPath.row];
        [self.playerViewController playAudioImmediatelyWithURL:song.audioURL];
    }
}


@end
