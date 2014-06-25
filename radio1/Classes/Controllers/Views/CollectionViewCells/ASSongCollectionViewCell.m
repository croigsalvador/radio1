//
//  ASSongCollectionViewCell.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASSongCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

static const CGFloat kMargin                    = 5.0;
static const CGFloat kBorderWidth               = 0.8;

@interface ASSongCollectionViewCell ()

@property (nonatomic, strong) UIImageView *songImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *artistLabel;

@end

@implementation ASSongCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.songImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.artistLabel];
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = kBorderWidth;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

#pragma mark - Custom getter

- (UIImageView *)songImageView{
    if (!_songImageView) {
        CGRect frame = self.bounds;
        frame.size.width = CGRectGetHeight(frame);
        _songImageView = [[UIImageView alloc] initWithFrame:frame];
    }
    return _songImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect frame  = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(kMargin, CGRectGetMaxX(self.songImageView.frame) + kMargin, 0.0, kMargin));
        frame.size.height =  CGRectGetHeight(frame)/2;
        _titleLabel = [UILabel baseLabelWithFrame:frame fontSize:14.0 bold:YES];
    }
    return _titleLabel;
}

- (UILabel *)artistLabel {
    if (!_artistLabel) {
        CGRect frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(CGRectGetMaxY(self.titleLabel.frame), CGRectGetMaxX(self.songImageView.frame) + kMargin, 0.0, kMargin));
        frame.size.height = CGRectGetHeight(frame)/2;
        _artistLabel = [UILabel baseLabelWithFrame:frame fontSize:12.0 bold:NO];
    }
    return _artistLabel;
}

#pragma mark - Public Methods

- (void)configureCellWithTitle:(NSString *)title artist:(NSString *)artist imageURL:(NSURL *)url {
    [self.songImageView setImageWithURL:url]; //set a placeholder
    self.titleLabel.text = title;
    self.artistLabel.text = artist;
}
@end
