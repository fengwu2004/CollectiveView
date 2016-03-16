//
//  BadWordFilter.h
//  CollectiveView
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyData;

@interface BadWordFilter : NSObject

@property (nonatomic, retain) MyData *myData;

+ (BadWordFilter*)sharedInstance;

- (void)test;

- (void)log;

@end
