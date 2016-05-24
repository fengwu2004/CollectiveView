//
//  StoreMgr.m
//  Lottery
//
//  Created by user on 16/2/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import "YFLogManager.h"

@interface YFLogManager()

@property (nonatomic, copy) NSString *logFilePath;
@property (nonatomic, retain) NSMutableArray *logs;

@end

@implementation YFLogManager

+ (YFLogManager*)sharedInstance {
    
    static YFLogManager *_instance = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        _instance = [[YFLogManager alloc] init];
    });
    
    return _instance;
}

- (id)init {
    
    self = [super init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"logfile.log"];
    
    _logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    _logs = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)clear {
    
    [_logs removeAllObjects];
    
    if (_logFilePath) {
        
        [[NSFileManager defaultManager] removeItemAtPath:_logFilePath error:nil];
    }
}

- (void)flush {
    
    if (_logs.count <= 0) {
        
        return;
    }
    
    NSString *logTexts = _logs[0];
    
    for (int i = 1; i < _logs.count; ++i) {
        
        logTexts = [logTexts stringByAppendingString:_logs[i]];
    }
    
    FILE *fp = fopen(_logFilePath.UTF8String, "a+");
    
    fprintf(fp, "%s", logTexts.UTF8String);
    
    fclose(fp);
    
    [_logs removeAllObjects];
}

- (void)log:(NSString*)text {
    
    if (_stopSave) {
        
        return;
    }
    
    [_logs addObject:text];
    
    if (_logs.count > 1000) {
        
        [self flush];
    }
}

@end
