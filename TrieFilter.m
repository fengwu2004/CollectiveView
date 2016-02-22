//
//  TrieFilter.m
//  CollectiveView
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TrieFilter.h"

@implementation TrieFilter

+ (TrieFilter*)sharedInstance {
	
	static TrieFilter *_instance = nil;
	
	static dispatch_once_t predicate;
	
	dispatch_once(&predicate, ^{
		
		_instance = [[TrieFilter alloc] init];
	});
	
	return _instance;
}

- (void)AddKey:(NSString*)key {
	
	if (!key || key.length == 0) {
		
		return;
	}
	
	TrieNode *node = self;
	
	for (int i = 0; i < key.length; ++i) {
		
		NSString *c = [key substringWithRange:NSMakeRange(i, 1)];
		
		TrieNode *subNode = [self TryGetValue:c];
		
		if (!subNode) {
			
			subNode = [[TrieNode alloc] init];
			
			[self.m_values setObject:subNode forKey:c];
		}
		
		node = subNode;
	}
	
	node.m_bEnd = YES;
}


- (BOOL)HasBadWord:(NSString*)text {
	
	for (NSInteger i = 0; i < text.length; ++i) {
		
		NSInteger index = 0;
		
		NSString *c = [text substringWithRange:NSMakeRange(index, 1)];
		
		TrieNode *node = [self TryGetValue:c];
		
		while (node) {
			
			if (node.m_bEnd) {
    
				return YES;
			}
			
			if (text.length == ++index) {
    
				break;
			}
			
			NSString *c = [text substringWithRange:NSMakeRange(index, 1)];
			
			node = [self TryGetValue:c];
		}
	}
	
	return NO;
}

@end
