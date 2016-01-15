//
//  AQSRecoder.m
//  Phamily
//
//  Created by zys on 12-11-19.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import "RGAudioQueue.h"
#import "AQRecorder.h"
#import "Utilities.h"
#import "AQPlayer.h"
#import <AVFoundation/AVFoundation.h>

#import "NSDate+TomAddition.h"


static RGAudioQueue *aqsRecorder=nil;
@interface RGAudioQueue (){
  AQRecorder		*_recorder;
  AQPlayer		  *_player;
  BOOL				  _playbackWasInterrupted;
  BOOL				  _playbackWasPaused;
  NSTimeInterval _beginTime;
  AudioQueueRef _v;
}
@end

@implementation RGAudioQueue


- (void)reset{
  
  [self stopPlayQueue];
	
  [self stopRecord:TRUE];
	
  _beginTime = 0;
	
  _playbackWasInterrupted = NO;
	
  _playbackWasPaused = NO;
	
  _delegate = nil;
	
  _playerDelegate = nil;
	
  _recorderDelegate = nil;
}

char *OSTypeToStr(char *buf, OSType t)
{
	char *p = buf;
	char str[4], *q = str;
	*(UInt32 *)str = CFSwapInt32(t);
	for (int i = 0; i < 4; ++i) {
		if (isprint(*q) && *q != '\\')
			*p++ = *q++;
		else {
			sprintf(p, "\\x%02x", *q++);
			p += 4;
		}
	}
	*p = '\0';
	return buf;
}

+ (RGAudioQueue *)sharedInstance{
  
  @synchronized(self) {
		
    if (aqsRecorder == nil) {
			
      aqsRecorder = [[super alloc]init];
			
      [aqsRecorder initRecorder];
    }
  }
	
  return aqsRecorder;
}

-(void)setFileDescriptionForFormat: (CAStreamBasicDescription)format
{
	char buf[5];
	const char *dataFormat = OSTypeToStr(buf, format.mFormatID);
	NSString* description = [[NSString alloc] initWithFormat:@"(%d ch. %s @ %g Hz)", (unsigned int)(format.NumberChannels()), dataFormat, format.mSampleRate, nil];
  NSLog(@"record file description: %@\n", description);
	[description release];
}

#pragma mark record
- (void)startRecord:(NSString*)filePath fileName:(NSString*)fileName {
  
	[[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryRecord error:nil];
	
  [self stopPlayQueue];
	
  [self resetRecordCategory];
  
	if (_recorder->IsRunning()) // If we are currently recording, stop and save the file.
	{
		[self stopRecord:FALSE];
	}

	CFStringRef ref=(CFStringRef)[fileName copy];
		// Start the recorder
	_recorder->StartRecord(ref,[filePath copy]);
	
	[self setFileDescriptionForFormat:_recorder->DataFormat()];
	
   _beginTime= [[NSDate date] timeIntervalSince1970];
	
   _v=_recorder->Queue();
}

- (void)stopRecord:(BOOL)succRecord
{
  if (!_recorder->IsRunning()) {
		
    return;
  }
	
  _v = nil;
	
  _recorder->StopRecord();
	
  if (succRecord){
		
    if ([self.recorderDelegate respondsToSelector:@selector(recordFinished:length:)]){
			
      NSTimeInterval endTime=[[NSDate date] timeIntervalSince1970];
			
      [self.recorderDelegate recordFinished:self length:(endTime-_beginTime)];
			
      _beginTime = 0;
    }
  }
	else{
		
    if ([self.recorderDelegate respondsToSelector:@selector(recordError:)]){
			
      [self.recorderDelegate recordError:self];
    }
  }
	
//	[self setActive:NO];
}

#pragma mark Playback routines

-(void)stopPlayQueue
{
	if (!_player->IsRunning()) {
		
		return;
	}
	
 _player->StopQueue();
	
	_v = nil;
	
	if ([_playerDelegate respondsToSelector:@selector(playStop:)]){
		
		[_playerDelegate playStop:self];
	}
	
//	[self setActive:NO];
}

//暂停
-(void)pausePlayQueue
{
  if (_player->IsRunning())
	{
    if (!_playbackWasPaused) {
			
      _player->PauseQueue();
			
      _playbackWasPaused = YES;
			
      if ([_playerDelegate respondsToSelector:@selector(playPause:)]){
				
        [_playerDelegate playPause:self];
      }
    }
  }
}

- (void)continuePlay{
	
  CLog(@"==== replayButton clicked ====\n");
	
	if (_player->IsRunning())
	{
		if (_playbackWasPaused) {
			
			OSStatus result = _player->ContinueQueue();
			
      _playbackWasPaused = NO;
			
			if (result == noErr)
				
        [Utilities runOnMainQueueWithoutDeadlocking:^{
					
          [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_audioplaybackQueueResumed object:self];
        }];
		}
		else
			[self stopPlayQueue];
	}
	else
	{
		[self resetPlayCategory];
		
		OSStatus result = _player->StartQueue(false);
		
		if (result == noErr)
			
      [Utilities runOnMainQueueWithoutDeadlocking:^{
				
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_audioplaybackQueueResumed object:self];
      }];
	}
}

- (BOOL)startPlay:(NSString*)filePath
{
  _player->DisposeQueue(true);
	
  _playbackWasPaused = NO;
	
  _playbackWasInterrupted = NO;
	
  CFStringRef recordFilePath = (CFStringRef)[filePath copy];
  
  CLog(@"recordFilePath = %@\n", recordFilePath);
	
  if (recordFilePath == nil){
		
    return NO;
  }
	
  bool succ = _player->CreateQueueForFile(recordFilePath);
	
  if (!succ){
		
    return NO;
  }
	
  [self continuePlay];
	
  CLog(@"==== playButton clicked ====\n");
	
  return YES;
}

- (PLAYTYPE)returnPlayType{
  
  if(_player->IsRunning()){
    return PLAYTYPE_PLAYING;
  }else if(_playbackWasPaused){
    return PLAYTYPE_PAUSE;
  }else{
    return PLAYTYPE_STOP;
  }
}

#pragma mark AudioSession listeners
void interruptionListener(void *	inClientData, UInt32	inInterruptionState) {
	
  RGAudioQueue *THIS = (RGAudioQueue*)inClientData;
	
  CLog(@"inInterruptionState %d",(int)inInterruptionState);
	
	if (inInterruptionState == kAudioSessionBeginInterruption)
	{
		if (THIS->_recorder->IsRunning()) {
			
			[THIS stopRecord: FALSE];
		}
		else if (THIS->_player->IsRunning()) {
			//the queue will stop itself on an interruption, we just need to update the UI
      [Utilities runOnMainQueueWithoutDeadlocking:^{
				
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_audioPlaybackQueueStopped object:THIS];
      }];
			
      THIS->_playbackWasInterrupted = YES;
		}
	}
	else if ((inInterruptionState == kAudioSessionEndInterruption) && THIS->_playbackWasInterrupted)
	{
		// we were playing back when we were interrupted, so reset and resume now
		THIS->_player->StartQueue(true);
		
    [Utilities runOnMainQueueWithoutDeadlocking:^{
			
      [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_audioplaybackQueueResumed object:THIS];
    }];
		
		THIS->_playbackWasInterrupted = NO;
	}
	else{
  
  }
}

- (void)setActive:(BOOL)active {
	
	BOOL bResult = NO;
	
	if (active) {
		
		bResult = [[AVAudioSession sharedInstance] setActive:YES error:nil];
	}
	else {
		
		bResult = [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
	}
	
	if (!bResult) {
		
		CLog(@"audiosession激活失败");
	}
	else {
		
		CLog(@"audiosession激活成功");
	}
}

- (void)resetPlayCategory {

	if (![[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil]) {
		
		CLog(@"setCategory失败");
	}
	
	[self setActive:YES];
}

- (void)resetRecordCategory {
	
	[[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
	
	[self setActive:YES];
}

#pragma mark Initialization routines
- (void)initRecorder
{
	_recorder = new AQRecorder();
	
  _player = new AQPlayer();
  
  AudioSessionInitialize(NULL, NULL, interruptionListener, self);
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioPlaybackQueueResumed:) name:kNotif_audioplaybackQueueResumed object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioPlaybackQueueStopped:) name:kNotif_audioPlaybackQueueStopped object:nil];
}

# pragma mark Notification routines
- (void)audioPlaybackQueueStopped:(NSNotification *)notif{
 
  _v = nil;
	
  if (self.playerDelegate) {
		
    [self.playerDelegate playStop:self];
		
    CLog(@"audio playback stopped");
  }
	
//	[self setActive:NO];
}

- (void)audioPlaybackQueueResumed:(NSNotification *)notif{
  
  _v = _player->Queue();
	
  if (self.playerDelegate) {
		
    [self.playerDelegate playResume:self];
  }
}

//非法文件
- (void)audioPlaybackFileInvalid:(NSNotification *)notif{
  
  NSDictionary *viewsDictionary = notif.userInfo;
	
  NSString *path = [viewsDictionary objectForKey:@"inFilePath"];
	
  NSFileManager *manager = [NSFileManager defaultManager];
	
  if ([manager fileExistsAtPath:path]){
    
    [manager removeItemAtPath:path error:nil];
  }
}

- (BOOL)isHeadphone
{
	AVAudioSessionRouteDescription* route = [[AVAudioSession sharedInstance] currentRoute];
	
	for (AVAudioSessionPortDescription* desc in [route outputs]) {
		
		if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones])
			
			return YES;
	}
	
	return NO;
}

- (AudioQueueRef)audioQueueFromAQS{
	
  return _v;
}

#pragma mark Cleanup
- (void)dealloc
{
	delete _recorder;
	
  delete _player;
	
	self.delegate = nil;
	
  self.recorderDelegate = nil;
	
  self.playerDelegate = nil;
	
	[super dealloc];
}

@end
