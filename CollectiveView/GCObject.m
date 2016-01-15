//
//  GCBasicObject.m
//  GameChat
//
//  Created by zys on 13-1-17.
//  Copyright (c) 2013年 Ruoogle. All rights reserved.
//

#import "GCObject.h"
//#import "GCAppSharedData.h"

@implementation GCObject

//+ (GCDatabase *)sharedDB {
//
//  return [[GCAppSharedData sharedInstance] sqlDB];
//}

- (id)initWithJSONDic:(NSDictionary *)jsonDic {

  self = [self init];
  if (self) {
    [self setValuesWithDictionary:jsonDic];
  }
  return self;
}

- (void)setValuesWithDictionary:(NSDictionary *)dictionary {

  // overridden by subclass
}

- (id)proxyClientACKForJson {
  
  return [NSDictionary dictionary];
}

- (id)proxyForJson {

  return [NSDictionary dictionary];
}

- (void)dealloc {

  [super dealloc];
}

+ (NSString *)jsonKey {

  return @"object";
}

- (void)saveToDB {

}
@end
