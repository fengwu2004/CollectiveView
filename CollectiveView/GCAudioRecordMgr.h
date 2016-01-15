//
//  GCAudioRecordMgr.h
//  GameChat
//
//  Created by user on 16/1/13.
//  Copyright © 2016年 Ruoogle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGAudioQueue.h"

@class GCAudio;
@class GCAudioRecordMgr;

@protocol GCAudioRecordMgrDelegate <NSObject>

- (void)audioRecordSend:(GCAudio *)audio sender:(GCAudioRecordMgr*)sender;

- (void)recordWillStart:(GCAudioRecordMgr*)sender;

- (void)recordWillEnd:(GCAudioRecordMgr*)sender;

@end

//--------------------------------------------------------
@interface GCAudioRecordMgr : NSObject<RGAudioQueueDelegate, RGAudioQueuePlayDelegate, RGAudioQueueRecorderDelegate>

@property (nonatomic, weak) id<GCAudioRecordMgrDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)recordBegin;

- (void)recordEnd;

@end
