//
//  SoundMgr.h
//  sevenmin-app
//
//  Created by Anita Santoso on 17/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTSingleton.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundMgr : NSObject<AVAudioPlayerDelegate>

+ (SoundMgr*)sharedInstance;
- (void)playWhistleSound;
- (void)stop;
@end
