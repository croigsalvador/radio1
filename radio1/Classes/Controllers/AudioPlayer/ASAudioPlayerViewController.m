//
//  ASAudioPlayerViewController.m
//  radio1
//
//  Created by Alex Sanz on 26/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASAudioPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

static const CGSize kButtonSize                 = {50.0 , 50.0};

@interface ASAudioPlayerViewController () <AVAudioPlayerDelegate>

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) AVPlayer *mediaPlayer;

@end

@implementation ASAudioPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  blackColor];
    [self.view addSubview:self.stopButton];
    [self.view addSubview:self.playButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Custom Getter

- (void)setAudioURL:(NSURL *)audioURL {
    _audioURL = audioURL;
    [self.mediaPlayer play];
}

- (AVPlayer *)mediaPlayer {
    if (!_mediaPlayer) {
        if (self.audioURL) {
            _mediaPlayer = [AVPlayer playerWithURL:self.audioURL];
        }
    }
    return _mediaPlayer;
}

#pragma mark - Public Custom Getter

- (UIButton *)playButton {
    if (!_playButton) {
        CGRect frame = self.view.bounds;
        frame.size = kButtonSize;
        
        _playButton = [[UIButton alloc] initWithFrame:frame];
        _playButton.backgroundColor = [UIColor magentaColor];
        [_playButton setTitle:@"Play" forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(startPlayingAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UIButton *)stopButton {
    if (!_stopButton) {
        CGRect frame = self.view.bounds;
        frame.size = kButtonSize;

        _stopButton = [[UIButton alloc] initWithFrame:frame];
        _stopButton.backgroundColor = [UIColor orangeColor];
        [_stopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [_stopButton addTarget:self action:@selector(stopPlayingAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopButton;
}
#pragma mark - Actions

- (void)startPlayingAction:(UIButton *)sender {
    [UIView transitionFromView:self.playButton toView:self.stopButton
                      duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        [self.mediaPlayer play];
    }];
}

- (void)stopPlayingAction:(UIButton *)sender {
    [self.mediaPlayer pause];
    [UIView transitionFromView:self.stopButton toView:self.playButton
                      duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        
    }];
}


@end
