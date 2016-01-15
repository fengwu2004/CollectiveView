//
//  GCQiniuUtils.m
//  GameChat
//
//  Created by Tom on 7/26/13.
//  Copyright (c) 2013 Ruoogle. All rights reserved.
//

#import "GCQiniuUtils.h"
#import "NSString+TomAddition.h"

@implementation GCQiniuUtils

+ (NSString *)staticResourceURL {
  
  return @"www.qiniudn.com";
}

+ (NSString *) urlStringBySize:(CGSize)size urlStr:(NSString*)url contentType:(QiniuImageContentType)type{
  
  if (!url) {
    return nil;
  }
  
  if (![url pd_findSubstring:[self staticResourceURL]] && ![url pd_findSubstring:@"qiniu"]) {
    
    return url;
  }
  
  return [NSString stringWithFormat:@"%@/w/%0.0f/h/%0.0f",[self getUrlByType:url type:type],size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale]];
}

+ (NSURL *) urlBySize:(CGSize)size urlStr:(NSString*)url contentType:(QiniuImageContentType)type {
  
  return [NSURL URLWithString:[self urlStringBySize:size urlStr:url contentType:type]];
}

+ (NSString*) getUrlByType:(NSString*)url type:(QiniuImageContentType)type{
  
  if (![url pd_findSubstring:[self staticResourceURL]] && ![url pd_findSubstring:@"qiniu"]) {
    return url;
  }
  
  switch (type) {
    case QINIU_IMAGE_CONTENT_SHORT:
      return [NSString stringWithFormat:@"%@?imageView/2",url];
    default:
      return [NSString stringWithFormat:@"%@?imageView/1",url];
  }
}

+ (NSURL *) urlByMediaType:(NSString*)url toType:(NSString*)toType{
  return [NSURL URLWithString:[NSString stringWithFormat:@"%@?avthumb/%@",url,toType]];
}
@end
