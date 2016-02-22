//
//  TrieNode.h
//  CollectiveView
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrieNode : NSObject

@property (nonatomic, assign) BOOL m_bEnd;
@property (nonatomic, retain) NSMutableDictionary *m_values;

- (TrieNode*)TryGetValue:(NSString*)key;

- (TrieNode*)Add:(NSString*)key;

@end
