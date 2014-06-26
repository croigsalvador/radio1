//
//  ASAudioPlayerViewController.m
//  radio1
//
//  Created by Alex Sanz on 26/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

#import "ASAudioPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+AFNetworking.h"

static const CGSize kButtonSize                 = {50.0 , 50.0};
static const CGFloat kAnimationDuration         = 0.3;
static const CGFloat kHeightLabel               = 18.0;
static const UIEdgeInsets labelInsets           = {2.0, 4.0, 0.0, 0.0};

@interface ASAudioPlayerViewController () <AVAudioPlayerDelegate>

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *stopButton;

@property (nonatomic, strong) NSURL *audioURL;
@property (nonatomic, strong) AVPlayer *mediaPlayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) UIImageView *tuneImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *albumLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSTimer *myTimer;
@end

@implementation ASAudioPlayerViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  blackColor];
    [self.view addSubview:self.stopButton];
    [self.view addSubview:self.playButton];
    [self.view addSubview:self.tuneImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.albumLabel];
    [self.view addSubview:self.timeLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopPlayingAction:nil];
}

#pragma mark - Private Custom Getter

- (AVPlayer *)mediaPlayer {
    if (!_mediaPlayer) {
        _mediaPlayer = [[AVPlayer alloc] init];
        _mediaPlayer.actionAtItemEnd = AVPlayerActionAtItemEndPause;
    }
    return _mediaPlayer;
}

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

- (UIImageView *)tuneImageView {
    if (!_tuneImageView) {
        CGRect frame = self.playButton.bounds;
        frame.origin.x = CGRectGetWidth(self.playButton.bounds);
        _tuneImageView = [[UIImageView alloc] initWithFrame:frame];
        _tuneImageView.backgroundColor = [UIColor blackColor];
    }
    return _tuneImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect frame = self.view.bounds;
        frame.origin.x = CGRectGetMaxX(self.tuneImageView.frame);
        frame.size.width -= CGRectGetMaxX(self.tuneImageView.frame);
        frame.size.height = kHeightLabel;
    
        _titleLabel = [UILabel baseLabelWithFrame:UIEdgeInsetsInsetRect(frame, labelInsets) fontSize:13 bold:YES];
        _titleLabel.backgroundColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)albumLabel {
    if (!_albumLabel) {
        CGRect frame = self.titleLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.titleLabel.frame);
        
        _albumLabel = [UILabel baseLabelWithFrame:frame fontSize:12 bold:NO];
        _albumLabel.backgroundColor = [UIColor blackColor];
    }
    return _albumLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        CGRect frame = self.albumLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.albumLabel.frame);
        
        _timeLabel = [UILabel baseLabelWithFrame:frame fontSize:12 bold:NO];
        _timeLabel.backgroundColor = [UIColor blackColor];
        _timeLabel.text = @"00:01";
    }
    return _timeLabel;
}

#pragma mark - Actions

- (void)startPlayingAction:(id)sender {
    [UIView transitionFromView:self.playButton toView:self.stopButton
                      duration:kAnimationDuration options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:self.playerItem];
                          
        self.playerItem = [AVPlayerItem playerItemWithURL:self.audioURL];
        if (self.playerItem) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(audioItemDidFinishPlaying:)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:[self.mediaPlayer currentItem]];
        }
        [self.mediaPlayer replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.mediaPlayer play];
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                        target:self
                                                      selector:@selector(currentAudioTime:)
                                                      userInfo:nil
                                                       repeats:YES];
                          
    }];
}

- (void)stopPlayingAction:(id)sender {
    [self.mediaPlayer pause];
    [UIView transitionFromView:self.stopButton toView:self.playButton
                      duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.timeLabel.text = @"--";
    }];
    
}

#pragma mark - Public Methods

- (void)playAudioImmediatelyWithURL:(NSURL *)url imageURL:(NSURL *)imageURL title:(NSString *)title artist:(NSString *)artist {
    self.audioURL = [url copy];
    [self.tuneImageView setImageWithURL:[imageURL copy]];
    [self startPlayingAction:nil];
    self.titleLabel.text = [title copy];
    self.albumLabel.text = [artist copy];
}

#pragma mark - Private Methods 

- (void)currentAudioTime:(NSTimer *)timer {
    CGFloat currentSecond = CMTimeGetSeconds([self.mediaPlayer currentTime]);
    self.timeLabel.text =[NSString stringWithFormat:@"%.2f",currentSecond ];
}

#pragma mark - AV Player item notifications

-(void)audioItemDidFinishPlaying:(NSNotification *) notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopPlayingAction:nil];
        
    });
}

@end
