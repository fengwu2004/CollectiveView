//
//  GCAudioDownLoader.m
//  GameChat
//
//  Created by zys on 12-11-28.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import "GCAudioDownLoader.h"
#import "GCAudio.h"

@implementation GCAudioDownLoader

+ (NSData*)syncSaveAudioInUrl:(NSString *)urlStr toPath:(NSString *)path{
  
  NSData *data = [NSData dataWithContentsOfFile:path];
  if (data) {
    return data;
  }
  data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
  if (!data) {
    return nil;
  }
  [data writeToFile:path atomically:YES];
  return data;
}

+ (NSString *)audioWavPathByUrlString:(NSString *)url withChatUser:(long long)userId andType:(GCChatGroupType)type {
  
  url = [url stringByReplacingOccurrencesOfString:@"/" withString:@""];
  long long random = arc4random() % 10000000;
  NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  NSString *filePath = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld_%d_receivedAudio_%lld.wav", userId, type, random]];
  
  return filePath;
}


@end
