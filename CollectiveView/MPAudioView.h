//
//  MPAudioView.h
//  Phamily
//
//  Created by zys on 12-12-1.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

typedef enum MPAudioViewPosition_ {
  
  MPAudioViewPosition_Middle = 1,
  MPAudioViewPosition_Up = 2
  
} MPAudioViewPosition;
typedef void(^BlockType)();

@interface MPAudioView : UIView {

  UILabel *_intervalLbl;
  NSInteger _seconds;
  NSTimeInterval _startTime;
  UIWindow *_overlayWindow;
  UILabel *_descLabel;
}

@property (nonatomic, copy) BlockType resetBlock;
@property (nonatomic, copy) BlockType timeLimitBlock;

+ (MPAudioView *)sharedView;

+ (void)show:(AudioQueueRef)v desc:(NSString*)desc;

+ (void)showWithNowTime:(AudioQueueRef)v desc:(NSString*)desc position:(MPAudioViewPosition)position;

+ (void)showWithNowTime:(AudioQueueRef)v desc:(NSString*)desc;

+ (void)showWithTime:(AudioQueueRef)v time:(NSTimeInterval)time desc:(NSString*)desc;



+ (void)dismiss:(AudioQueueRef)v;
@end
