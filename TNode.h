//
//  TNode.h
//  CollectiveView
//
//  Created by ky on 16/3/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNode : NSObject

@property (nonatomic, assign) char key;
@property (nonatomic, assign) NSInteger nIndex;
@property (nonatomic, retain) NSArray *children;

@end
