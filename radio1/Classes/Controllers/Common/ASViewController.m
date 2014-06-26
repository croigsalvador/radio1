//
//  ASViewController.m
//  radio1
//
//  Created by Alex Sanz on 24/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASViewController.h"

@interface ASViewController ()

@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Public methods

- (void)addChildViewController:(UIViewController *)childController toView:(UIView *)toView {
    [self addChildViewController:childController];
    [childController didMoveToParentViewController:self];
    
    CGRect frame = childController.view.frame;
    frame.size.height = CGRectGetHeight(toView.frame);
    frame.size.width = CGRectGetWidth(toView.frame);
    childController.view.frame = frame;
    
    [toView addSubview:childController.view];
}


@end
