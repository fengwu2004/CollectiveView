//
//  StoreMgr.h
//  Lottery
//
//  Created by user on 16/2/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFLogManager : NSObject

@property (nonatomic, assign) BOOL stopSave;

+ (YFLogManager*)sharedInstance;

- (void)log:(NSString*)text;

- (void)clear;

- (void)flush;

@end
