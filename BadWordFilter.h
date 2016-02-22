//
//  BadWordFilter.h
//  CollectiveView
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BadWordFilter : NSObject

+ (BadWordFilter*)sharedInstance;

- (void)test;

@end
