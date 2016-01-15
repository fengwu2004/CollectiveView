//
//  GCQiniuUtils.h
//  GameChat
//
//  Created by Tom on 7/26/13.
//  Copyright (c) 2013 Ruoogle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum QiniuImageContentType_ {
  
  //表示限定目标缩略图的宽度和高度，放大并从缩略图中央处裁剪为指定
  QINIU_IMAGE_CONTENT_NORMAL          = 0,
  
  //指定 <Width> 和 <Height>，表示限定目标缩略图的长边，短边等比缩略自适应，将缩略图的大小限定在指定的宽高矩形内。
  //指定 <Width> 但不指定 <Height>，表示限定目标缩略图的宽度，高度等比缩略自适应。
  //指定 <Height> 但不指定 <Width>，表示限定目标缩略图的高度，宽度等比缩略自适应。
  QINIU_IMAGE_CONTENT_SHORT           = 1,
  
} QiniuImageContentType;

@interface GCQiniuUtils : NSObject

+ (NSString *)staticResourceURL;

+ (NSURL *) urlBySize:(CGSize)size urlStr:(NSString*)url contentType:(QiniuImageContentType)type;
+ (NSURL *) urlByMediaType:(NSString*)url toType:(NSString*)toType;
@end
