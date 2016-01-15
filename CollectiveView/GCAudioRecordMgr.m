//
//  GCAudioRecordMgr.m
//  GameChat
//
//  Created by user on 16/1/13.
//  Copyright © 2016年 Ruoogle. All rights reserved.
//

#import "GCAudioRecordMgr.h"
#import "MPAudioView.h"
#import "GCAudio.h"
#import <AVFoundation/AVFoundation.h>

@interface GCAudioRecordMgr()

@property (nonatomic, assign) GCMediaGenerateFrom from;
@property (nonatomic, retain) NSDictionary *extraDic;
@property (nonatomic, retain) GCAudio *nowAudio;

@end

static GCAudioRecordMgr *_sharedInstance;

@implementation GCAudioRecordMgr

+ (instancetype)sharedInstance {
	
	if (!_sharedInstance) {
		
		_sharedInstance = [[GCAudioRecordMgr alloc] init];
	}
	
	return _sharedInstance;
}

- (void)recordBegin {
	
	[_delegate recordWillStart:self];
	
	RGAudioQueue *audioQueue = [RGAudioQueue sharedInstance];
	
	audioQueue.delegate = self;
	
	audioQueue.recorderDelegate = self;
	
	_nowAudio = [[GCAudio alloc] initWithGCMediaGenerateFrom:_from withExtraInfo:_extraDic isInTempFolder:NO];
	
	[audioQueue startRecord:_nowAudio.localCachePath fileName:_nowAudio.audioName];
	
	[MPAudioView showWithNowTime:[audioQueue audioQueueFromAQS] desc:nil position:MPAudioViewPosition_Up];
	
	[[MPAudioView sharedView] setResetBlock:^(void) {
		
		[[RGAudioQueue sharedInstance] reset];
	}];
	
	[[MPAudioView sharedView] setTimeLimitBlock:^(void) {
		
		[GCUtilties simpleOkAlert:@"录音超时咯~"];
	}];
}

- (void)recordEnd {
	
	RGAudioQueue *audioQueue = [RGAudioQueue sharedInstance];

	[_delegate recordWillEnd:self];
	
	[audioQueue stopRecord:TRUE];
	
	[MPAudioView dismiss:[audioQueue audioQueueFromAQS]];
	
	if (_nowAudio.lengthInSeconds < kRecordLimitLength) {
		
		[GCUtilties simpleOkAlert:@"声音少于1秒,多说两句嘛~"];
		
		_nowAudio = nil;
		
		return;
	}
	
	[_delegate audioRecordSend:_nowAudio sender:self];
	
	_delegate = nil;
}

- (void)initError:(RGAudioQueue *)audioQueue {
	
	[audioQueue reset];
}

- (void)setWithGCMediaGenerateFrom:(GCMediaGenerateFrom)from extra:(NSDictionary*)extraDic isInTempFolder:(BOOL)isInTemp {
	
	_from = from;
	
	_extraDic = [[NSDictionary alloc] initWithDictionary:extraDic];
}

-(void)recordFinished:(RGAudioQueue*)audioQueue length:(double)length {
	
	_nowAudio.lengthInSeconds = (int)length;
}

@end
