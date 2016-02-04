//
//  GCProgressBar.h
//  GameChat
//
//  Created by user on 15/8/6.
//  Copyright (c) 2015年 Ruoogle. All rights reserved.
//

#ifndef GameChat_GCProgressBar_h
#define GameChat_GCProgressBar_h

#import <UIKit/UIKit.h>

@interface GCProgressBar : UIView

@property (nonatomic, retain) UIView* progressBarBg;
@property (nonatomic, retain) UIView* progressBar;

@property (nonatomic, assign) CGFloat maxValue;

- (id)initWithSize:(CGSize)size;

- (void)setPercent:(CGFloat)value;

@end

#endif
