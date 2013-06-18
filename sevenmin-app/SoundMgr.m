//
//  SoundMgr.m
//  sevenmin-app
//
//  Created by Anita Santoso on 17/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "SoundMgr.h"

@interface SoundMgr()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation SoundMgr

JTSYNTHESIZE_SINGLETON_FOR_CLASS(SoundMgr)

- (void)playWhistleSound {
    NSLog(@"Play sound");
    NSURL *soundUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"whistle" ofType:@"m4a"]];
    
    NSError *error;
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:&error];
    self.player.delegate = self;
    self.player.numberOfLoops = 0;
    [self.player play];
}

- (void)stop {
    [self.player stop];
}

@end
