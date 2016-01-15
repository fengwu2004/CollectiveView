//
//  AQSRecoder.h
//  Phamily
//
//  Created by zys on 12-11-19.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

typedef enum _PLAYTYPE{
  PLAYTYPE_STOP ,
  PLAYTYPE_PLAYING,
  PLAYTYPE_PAUSE,
}PLAYTYPE;


@class RGAudioQueue;
typedef RGAudioQueue *(^AudioQueueBlockType)(void);

@protocol RGAudioQueueDelegate <NSObject>

-(void)initError:(RGAudioQueue*)audioQueue;
@optional
-(void)initSucc:(RGAudioQueue*)audioQueue;

@end

@protocol RGAudioQueueRecorderDelegate <NSObject>

@optional
-(void)recordError:(RGAudioQueue*)audioQueue;
-(void)recordFinished:(RGAudioQueue*)audioQueue length:(double)length;
-(void)recordAvailable:(RGAudioQueue*)audioQueue available:(BOOL)available;
@end

@protocol RGAudioQueuePlayDelegate <NSObject>

@optional
-(void)playResume:(RGAudioQueue*)audioQueue;
-(void)playStop:(RGAudioQueue*)audioQueue;
-(void)playPause:(RGAudioQueue*)audioQueue;
-(void)playAvailable:(RGAudioQueue*)audioQueue available:(BOOL)available;
@end


@interface RGAudioQueue : NSObject{
   
}

@property (nonatomic,assign) id<RGAudioQueueDelegate> delegate;
@property (nonatomic,assign) id<RGAudioQueueRecorderDelegate> recorderDelegate;
@property (nonatomic,assign) id<RGAudioQueuePlayDelegate> playerDelegate;

+ (RGAudioQueue *)sharedInstance;

- (void)reset;
- (void)resetRecordCategory;
- (void)resetPlayCategory;
- (void)startRecord:(NSString*)filePath fileName:(NSString*)fileName;
- (void)stopRecord:(BOOL)succRecord;
- (void)stopPlayQueue;
- (void)pausePlayQueue;

- (BOOL)startPlay:(NSString*)filePath;
- (void)continuePlay;
- (PLAYTYPE)returnPlayType;
- (BOOL)isHeadphone;
- (AudioQueueRef)audioQueueFromAQS;
- (void)setActive:(BOOL)active;

@end
