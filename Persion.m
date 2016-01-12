//
//  Persion.m
//  CollectiveView
//
//  Created by user on 16/1/11.
//  Copyright © 2016年 user. All rights reserved.
//

#import "Persion.h"

@implementation Persion

- (id)copyWithZone:(nullable NSZone *)zone {
	
	Persion *p = [[self class] allocWithZone:zone];
	
	p.apples = [_apples mutableCopy];
	
	p.age = _age;
	
	return p;
}

@end
