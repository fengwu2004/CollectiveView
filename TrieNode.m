//
//  TrieNode.m
//  CollectiveView
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TrieNode.h"

@implementation TrieNode

- (id)init {
	
	self = [super init];
	
	_m_values = [[NSMutableDictionary alloc] init];
	
	return self;
}

- (TrieNode*)TryGetValue:(NSString*)key {
	
	return [_m_values objectForKey:key];
}

- (TrieNode*)Add:(NSString *)key {

	TrieNode *node = [_m_values objectForKey:key];
	
	if (!node) {
		
		node = [[TrieNode alloc] init];
		
		[_m_values setObject:node forKey:key];
	}
	
	return node;
}


@end
