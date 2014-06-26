//
//  ASAudioPlayerViewController.h
//  radio1
//
//  Created by Alex Sanz on 26/06/2014.
//  Copyright (c) 2014 Alex Sanz. All rights reserved.
//

@interface ASAudioPlayerViewController : UIViewController

@property (nonatomic, strong) NSURL *audioURL;
@property (nonatomic, strong) UIImage *imageTune;
@property (nonatomic, copy) NSString *titleSong;

- (void)playAudioImmediatelyWithURL:(NSURL *)url;

@end
