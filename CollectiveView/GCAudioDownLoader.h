//
//  GCAudioDownLoader.h
//  GameChat
//
//  Created by zys on 12-11-28.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum GCChatGroupType{
  
  GCChatGroupType_Offline = 0,
  GCChatGroupType_Online = 1,
} GCChatGroupType;

@interface GCAudioDownLoader : NSObject

+ (NSData*)syncSaveAudioInUrl:(NSString *)urlStr toPath:(NSString *)path;

+ (NSString *)audioWavPathByUrlString:(NSString *)url withChatUser:(long long)userId andType:(GCChatGroupType)type;

@end
