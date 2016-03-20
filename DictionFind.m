//
//  DictionFind.m
//  CollectiveView
//
//  Created by ky on 16/3/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "DictionFind.h"
#import "TNode.h"

#define str1 @"virtualcalbald"
#define str2 @"heading"
#define str3 @"mechanical"

@interface DictionFind()

@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) NSMutableDictionary *dic;

@end

@implementation DictionFind

- (NSArray*)findKeyIndexs:(char)key inStr:(NSString*)str {

    return @[@1, @3];
}

- (void)buildTreeWithRoot:(char)key {

    _array = [[NSMutableArray alloc] initWithArray:@[str1, str2, str3]];

    for (int i = 0; i < _array.count; ++i) {

        NSString *str = _array[i];

        NSArray *indexs = [self findKeyIndexs:key inStr:str];

        TNode *node = [[TNode alloc] init];

        node.key = key;

        
    }
}

@end
