//
//  DrawViewController.m
//  CollectiveView
//
//  Created by ky on 16/5/24.
//  Copyright © 2016年 user. All rights reserved.
//

#import "DrawViewController.h"
#import "IDRTimestamp.h"

@interface DrawViewController ()

@property (nonatomic, retain) NSMutableDictionary *regionTimestamp;

@end

@implementation DrawViewController

- (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *basePath = paths.firstObject;
    
    return basePath;
}

- (void)saveTimestamp {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.regionTimestamp options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *filePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"timestamp.data"];
    
    [NSKeyedArchiver archiveRootObject:jsonData toFile:filePath];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *timestamp = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"timestamp.data"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:timestamp]) {
        
        NSData *json = [NSKeyedUnarchiver unarchiveObjectWithFile:timestamp];
        
        _regionTimestamp = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    }
    else {
        
        _regionTimestamp = [[NSMutableDictionary alloc] init];
        
        IDRRegionTimestamp *t = [[IDRRegionTimestamp alloc] init];
        
        [_regionTimestamp setObject:t forKey:@"1001"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self saveTimestamp];
}

@end
