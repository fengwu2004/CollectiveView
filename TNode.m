//
//  TNode.m
//  CollectiveView
//
//  Created by ky on 16/3/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TNode.h"
#import "TNodeCreate.h"

#define str1 @"virtualcalbald"
#define str2 @"heading"
#define str3 @"mechanical"

@implementation TNode

- (id)init {
	
	self = [super init];
	
	_subNodes = [[NSMutableArray alloc] init];
	
	return self;
}

- (id)initWithKey:(NSString*)key {
	
	self = [super init];
	
	_subNodes = [[NSMutableArray alloc] init];
	
	self.key = key;
	
	return self;
}

- (TNode*)findChildForKey:(NSString*)key {
	
	for (TNode *node in _subNodes) {
		
		if ([node.key isEqualToString:key]) {
			
			return node;
		}
	}
	
	return nil;
}

- (void)addWord:(NSString*)word {
	
	if (!word || word.length == 0) {
		
		return;
	}
	
	NSString * key = [word substringWithRange:NSMakeRange(0, 1)];
	
	NSString *sub = [word substringWithRange:NSMakeRange(1, [word length] - 1)];
	
	TNode *subNode = [self findChildForKey:key];
	
	if (subNode) {
		
		[subNode addWord:sub];
	}
	else {
		
		subNode = [[TNode alloc] initWithKey:key];
		
		[subNode addWord:sub];
		
		[_subNodes addObject:subNode];
	}
	
	NSMutableDictionary *alphabetMap = [TNodeTreeCreater sharedInstance].alphabetMap;
	
	NSMutableArray *array = [alphabetMap objectForKey:key];
	
	if (array) {
		
		[array addObject:subNode];
	}
	else {
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		
		[array addObject:subNode];
		
		[alphabetMap setObject:array forKey:key];
	}
}

@end
