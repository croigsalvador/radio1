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
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation ASAudioPlayerViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.playerItem];
}

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
    [self startPlayingAction:nil];
    self.playButton.enabled = YES;
}

- (AVPlayer *)mediaPlayer {
    if (!_mediaPlayer) {
        _mediaPlayer = [[AVPlayer alloc] init];
        _mediaPlayer.actionAtItemEnd = AVPlayerActionAtItemEndPause;
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
        _playButton.enabled = YES;
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
         _stopButton.enabled = YES;
    }
    return _stopButton;
}


#pragma mark - Actions

- (void)startPlayingAction:(id)sender {
    [UIView transitionFromView:self.playButton toView:self.stopButton
                      duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:self.playerItem];
                          
        self.playerItem = [AVPlayerItem playerItemWithURL:_audioURL];
        if (self.playerItem) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(audioItemDidFinishPlaying:)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:[self.mediaPlayer currentItem]];
        }
        [self.mediaPlayer replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.mediaPlayer play];
    }];
}

- (void)stopPlayingAction:(id)sender {
    [self.mediaPlayer pause];
    [UIView transitionFromView:self.stopButton toView:self.playButton
                      duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Public Methods

- (void)playAudioImmediatelyWithURL:(NSURL *)url {
    self.audioURL = url;
    [self startPlayingAction:nil];
}

#pragma mark - AV Player item notifications

-(void)audioItemDidFinishPlaying:(NSNotification *) notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopPlayingAction:nil];
    });
}

@end
