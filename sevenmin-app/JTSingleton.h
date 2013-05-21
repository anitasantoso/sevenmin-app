//
//  JTSingleton.h
//  Dabble
//
//  Created by Armin (mannish) Kroll on 26/10/11.
//  Copyright (c) 2011 Hillan Klein and Marc Lipsitz. All rights reserved.
//

#define JTSYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
+ (classname *)sharedInstance \
{\
    static classname *sharedInstance = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        sharedInstance = [[classname alloc] init]; \
    }); \
    return sharedInstance; \
}
