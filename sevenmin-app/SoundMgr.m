//
//  SoundMgr.m
//  sevenmin-app
//
//  Created by Anita Santoso on 17/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "SoundMgr.h"

@interface SoundMgr()
@property (nonatomic, strong) AVAudioPlayer *whistlePlayer;
@property (nonatomic, strong) AVAudioPlayer *tickPlayer;
@end

@implementation SoundMgr

JTSYNTHESIZE_SINGLETON_FOR_CLASS(SoundMgr)

- (void)playWhistleSound {
    NSURL *soundUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"whistle" ofType:@"m4a"]];
    NSError *error;
    
    self.whistlePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:&error];
    self.whistlePlayer.delegate = self;
    self.whistlePlayer.numberOfLoops = 0;
    [self.whistlePlayer play];
}

- (void)playTickingSound {
    NSURL *soundUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"clock_tick" ofType:@"m4a"]];
    NSError *error;
    
    self.tickPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:&error];
    self.tickPlayer.delegate = self;
    self.tickPlayer.numberOfLoops = 0;
    [self.tickPlayer play];
}

- (void)stop {
    [self.whistlePlayer stop];
    [self.tickPlayer stop];
}

@end
