//
//  TNode.h
//  CollectiveView
//
//  Created by ky on 16/3/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNode : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign) NSInteger nIndex;
@property (nonatomic, retain) NSMutableArray<__kindof TNode*> *subNodes;

- (void)addWord:(NSString*)word;

@end
