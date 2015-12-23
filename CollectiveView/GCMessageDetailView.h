//
//  GCMessageDetailView.h
//  GameChat
//
//  Created by user on 15/12/22.
//  Copyright © 2015年 Ruoogle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCMessageDetailView : UIView

@property (nonatomic, retain) NSLayoutConstraint *leading;

- (void)setMessage:(NSString*)message;

@end
