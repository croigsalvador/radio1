//
//  ASMenuCollectionViewCell.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASMenuCollectionViewCell.h"

static const UIEdgeInsets viewInsets     = {10.0, 10.0, 10.0, 10.0};
static const CGFloat      kBorderWidth   = 0.8;
static const CGFloat      kBorderRadius  = 0.0;

@interface ASMenuCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ASMenuCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        
        self.layer.borderColor  = [UIColor whiteColor].CGColor;
        self.layer.borderWidth  = kBorderWidth;
        self.layer.cornerRadius = kBorderRadius;;
    }
    return self;
}

#pragma mark - Custom getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect frameLabel = UIEdgeInsetsInsetRect(self.bounds, viewInsets);
        frameLabel.size.height = CGRectGetHeight(self.bounds)/2 ;
        frameLabel.origin.y = CGRectGetMaxY(self.imageView.frame);
        
        _titleLabel = [UILabel baseLabelWithFrame:frameLabel fontSize:14.0 bold:NO];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _titleLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        CGRect frameImage = UIEdgeInsetsInsetRect(self.bounds, viewInsets);
        frameImage.size.height = CGRectGetHeight(self.bounds)/2  - viewInsets.top;
        
        _imageView = [[UIImageView alloc] initWithFrame:frameImage];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _imageView;
}


#pragma mark - Public Methods 

- (void)configureCellWithTitle:(NSString*)title imageName:(NSString *)imageName {
    self.titleLabel.text = title;
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
