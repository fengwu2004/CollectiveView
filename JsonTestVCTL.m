//
//  JsonTestVCTL.m
//  CollectiveView
//
//  Created by ky on 8/13/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "JsonTestVCTL.h"
#import "IDRTimestamp.h"

@implementation JsonTestVCTL

- (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *basePath = paths.firstObject;
    
    return basePath;
}

- (void)test1 {
    
    NSData *data = [_regionTestData toJSONData];
    
    NSString *filePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"timestamp.data"];
    
    [NSKeyedArchiver archiveRootObject:data toFile:filePath];
}

- (void)saveTimestamp {
    
    NSString *str = [_regionTestData toJSONString];
    
    NSLog(@"%@", str);
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *timestamp = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"timestamp.data"];
    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:timestamp]) {
//        
//        
//    }
//    else
    {
        
        _regionTestData = [[IDRRegionTimestamp alloc] init];
        
        _regionTestData.offlineDataTimestamp = 100;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self saveTimestamp];
}


@end
