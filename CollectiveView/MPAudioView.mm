//
//  MPAudioView.m
//  Phamily
//
//  Created by zys on 12-12-1.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import "MPAudioView.h"
#import "AQLevelMeter.h"
#import <QuartzCore/QuartzCore.h>
#import "Utilities.h"
#import "GCDefines.h"

@interface MPAudioView () {
  AQLevelMeter *_lvlMeter_in;
}
@end

static MPAudioView *audioView = nil;

@implementation MPAudioView

+ (MPAudioView *)sharedView {

  if (audioView == nil) {
    audioView = [[MPAudioView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/ 2 - 75, SCREEN_HEIGHT/ 2 - 75, 150, 150)];
  }

  return audioView;
}


- (id)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    self.layer.cornerRadius = 2;
    self.backgroundColor = [UIColor colorWithRed:43 / 255.0 green:43 / 255.0 blue:43 / 255.0 alpha:0.7];
    CGFloat originX = (self.frame.size.width - 56) / 2;
    CGFloat originY = (self.frame.size.height - 84) / 2;
    UIImageView *BgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, originY, 56, 84)];
    BgimageView.image = UIIMAGE_FROMPNG(@"pj_sh");
    [self addSubview:BgimageView];
    [BgimageView release];


    _intervalLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 30, 15)];
    _intervalLbl.backgroundColor = [UIColor clearColor];
    _intervalLbl.textColor = [UIColor whiteColor];
    _intervalLbl.font = [UIFont systemFontOfSize:13];
    [self addSubview:_intervalLbl];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.frame.size.height-30, self.frame.size.width-10, 20)];
    _descLabel.textColor=[UIColor whiteColor];
    _descLabel.textAlignment=NSTextAlignmentCenter;
    _descLabel.font=[UIFont systemFontOfSize:14];
    _descLabel.backgroundColor=[UIColor clearColor];
    _descLabel.hidden=YES;
    [self addSubview:_descLabel];
    
    originX = (self.frame.size.width - 20) / 2;
    _lvlMeter_in = [[AQLevelMeter alloc] initWithFrame:CGRectMake(originX, 38, 20, 40)];

    [_lvlMeter_in setRefreshBlock:^(void) {
      NSUInteger seconds = [[NSDate date] timeIntervalSince1970] - _startTime;
      if (seconds != _seconds) {
        _seconds = seconds;
        _intervalLbl.text = [NSString stringWithFormat:@"%ld\"", (long)_seconds];
      }
      if (seconds >= kRecordLength) {
        if (_timeLimitBlock) {
          _timeLimitBlock();
        }
      }
    }];
    [_lvlMeter_in setResetBlock:^(void) {
      if (_resetBlock) {
        _resetBlock();
      }
    }];

    [self addSubview:_lvlMeter_in];
    [_lvlMeter_in setBackgroundColor:[UIColor clearColor]];
    
    
  }
  return self;
}

+ (void)show:(AudioQueueRef)v  desc:(NSString*)desc{

  MPAudioView *audioView = [MPAudioView sharedView];
  audioView.hidden = NO;
  [audioView subView];
  [audioView setAq:v];
  [audioView showDescLabel:desc];

}

+ (void)showWithNowTime:(AudioQueueRef)v desc:(NSString*)desc position:(MPAudioViewPosition)position{
  MPAudioView *audioView = [MPAudioView sharedView];
  [MPAudioView showWithNowTime:v desc:desc];
  [audioView resetPositon:position];
  
}

+ (void)showWithNowTime:(AudioQueueRef)v desc:(NSString*)desc{

  MPAudioView *audioView = [MPAudioView sharedView];
  [MPAudioView show:v desc:desc];
  [audioView setStartTime:[[NSDate date] timeIntervalSince1970]];

}


+ (void)showWithTime:(AudioQueueRef)v time:(NSTimeInterval)time desc:(NSString*)desc{

  MPAudioView *audioView = [MPAudioView sharedView];
  [MPAudioView show:v desc:desc];
  [audioView setStartTime:time];

}

- (void)showDescLabel:(NSString*)desc{
  
  if(desc==nil){
    _descLabel.hidden=YES;
  }else{
    _descLabel.hidden=NO;
    _descLabel.text=desc;
  }
}

- (void)resetPositon:(MPAudioViewPosition)position{
  switch (position) {
    case MPAudioViewPosition_Up:
    {
      self.frame=CGRectMake(SCREEN_WIDTH/ 2 - 75, SCREEN_HEIGHT/ 3 - 75, 150, 150);
    }
      break;
      
    default:{
      self.frame=CGRectMake(SCREEN_WIDTH/ 2 - 75, SCREEN_HEIGHT/ 2 - 75, 150, 150);
    }
      break;
  }
}

- (void)hideTimeLabel {

  _intervalLbl.hidden = YES;
}

- (void)subView {

  if (!_overlayWindow) {
    _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _overlayWindow.backgroundColor = [UIColor clearColor];
    _overlayWindow.userInteractionEnabled = NO;

  }

  [_overlayWindow addSubview:self];
  _overlayWindow.hidden = NO;
  [_overlayWindow makeKeyAndVisible];
  [_overlayWindow bringSubviewToFront:self];
  [self setNeedsDisplay];
}


- (void)setAq:(AudioQueueRef)v {

  [_lvlMeter_in setAq:v];
}

- (void)setAq:(AudioQueueRef)v withCenterPoint:(CGPoint)center {

  self.center = center;
  [self setAq:v];

}

- (void)setStartTime:(NSTimeInterval)startTime {

  _startTime = startTime;
}

+ (void)dismiss:(AudioQueueRef)v {

  MPAudioView *audioView = [MPAudioView sharedView];
  [audioView setAq:v];
  [audioView reset];
  // SAFECHECK_RELEASE(audioView);
}

- (void)reset {

  self.hidden = YES;
  SAFECHECK_RELEASE(_overlayWindow);
  _startTime = 0;
  _intervalLbl.text = @"";
  _seconds = 0;
  SAFECHECK_RELEASE(_resetBlock);
  SAFECHECK_RELEASE(_timeLimitBlock);

}

- (void)dealloc {

  [_overlayWindow release];
  [_lvlMeter_in release];
  [_intervalLbl release];

  [_resetBlock release];
  [_timeLimitBlock release];
  [_descLabel release];

  [super dealloc];
}

@end
