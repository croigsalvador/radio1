//
//  ASMenuViewController.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASMenuViewController.h"
#import "ASMenuCollectionViewCell.h"
#import "MenuItem+Helper.h"

static NSString *kMenuCellIdentifier                = @"MenuCellIdentifier";

static CGFloat kHeightCell                          = 75.0;
static CGFloat kMinLineSpaceCells                   = 10.0;
static CGFloat kMinInterSpaceCells                  = 10.0;
static UIEdgeInsets collectionSectionInsets         = {10.0, 10.0, 10.0, 10.0};

@interface ASMenuViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableArray *menuData;

@property (nonatomic, strong) UICollectionView *menuCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

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
    [self.view addSubview:self.menuCollectionView];
    
    NSInvocationOperation * loadOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(populateMenuArrayAsynchronous) object:nil];
    [self.operationQueue addOperation:loadOperation];
    self.view.backgroundColor = [UIColor blackColor];
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
}

#pragma mark - Private Custom Setters

-(void)setMenuData:(NSMutableArray *)menuData {
    _menuData = menuData;
    //I'm using this as example of custom setter the reload colud be called in addDataToMenuArrayWithArray: as well
    [self.menuCollectionView reloadData];
}

#pragma mark - Private Custom Getter

-(UICollectionView *)menuCollectionView {
    if (!_menuCollectionView) {
        
        _menuCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _menuCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _menuCollectionView.dataSource = self;
        _menuCollectionView.delegate = self;
        _menuCollectionView.backgroundColor = [UIColor blackColor];
        
        [_menuCollectionView registerClass:[ASMenuCollectionViewCell class] forCellWithReuseIdentifier:kMenuCellIdentifier];
        
    }
    return _menuCollectionView;
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
    if (collectionView == self.menuCollectionView) {
        ASMenuCollectionViewCell *cell= (ASMenuCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kMenuCellIdentifier forIndexPath:indexPath];
        MenuItem *item=  (MenuItem *)[self.menuData objectAtIndex:indexPath.row];
        cell.backgroundColor= item.baseColor;
        
        [cell configureCellWithTitle:item.displayName imageName:item.imageIconName];
        return cell;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.menuCollectionView) {
        return [self.menuData count];
    } else {
        return 0.0;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.menuCollectionView) {
        return 1;
    } else {
        return 0;
    }
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.menuCollectionView) {
        NSLog(@"Selected!! - %@", [self.menuData objectAtIndex:indexPath.row]);
    }
}
@end
