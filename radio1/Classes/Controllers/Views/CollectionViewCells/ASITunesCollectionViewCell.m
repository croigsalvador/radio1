//
//  ASITunesCollectionViewCell.m
//  radio1
//
//  Created by Alex Sanz on 26/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASITunesCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ASITunesCollectionViewCell ()
@property (nonatomic, strong) UIImageView *songImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ASITunesCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.songImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark - Private Methods

- (UIImageView *)songImageView{
    if (!_songImageView) {
        _songImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _songImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect frame  = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(CGRectGetWidth(self.bounds)/1.5,0.0, 0.0, 0.0));
        _titleLabel = [UILabel baseLabelWithFrame:frame fontSize:8.0 bold:NO];
        _titleLabel.backgroundColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - Public Methods

- (void)configureCellWithTitle:(NSString *)title album:(NSString *)album imageURL:(NSURL *)imageURL {
    self.songImageView.image = nil;
    self.titleLabel.text = title;
    [self.songImageView setImageWithURL:imageURL]; //set a placeholder
}


@end
