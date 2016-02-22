//
//  TrieFilter.h
//  CollectiveView
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TrieNode.h"

@interface TrieFilter : TrieNode

- (BOOL)HasBadWord:(NSString*)text;

- (void)AddKey:(NSString*)key;

+ (TrieFilter*)sharedInstance;

@end
