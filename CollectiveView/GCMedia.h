//
//  GCMedia.h
//  GameChat
//
//  Created by zys on 12-11-21.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCObject.h"

typedef enum GCMediaType {

  GC_MEDIA_AVATAR = 0,
  GC_MEDIA_PHOTO = 1,
  GC_MEDIA_AUDIO = 2,
  GC_MEDIA_VIDEO = 3

} GCMediaType;

typedef enum GCMediaGenerateFrom {
  GCMediaGenerateFrom_Game = 0,
  GCMediaGenerateFrom_ShowRoom = 1,
  GCMediaGenerateFrom_Offline_Private = 2,
  GCMediaGenerateFrom_Offline_Greeting = 3,
  GCMediaGenerateFrom_Offline_Friend = 4,
  GCMediaGenerateFrom_WaitingRoom = 5,
  GCMediaGenerateFrom_Feedback = 6,
  GCMediaGenerateFrom_UserAvatar = 7,
  GCMediaGenerateFrom_Others = 8,
  GCMediaGenerateFrom_QRCode = 9
} GCMediaGenerateFrom;

@interface GCMedia : GCObject <NSCoding, NSCopying>

@property (nonatomic, copy) NSString *remoteStorageKey;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic) NSUInteger sizeInBytes;
@property (nonatomic) int mediaType;
@property (nonatomic, copy) NSString *localCachePath;
@property (nonatomic, copy) VoidBlockType uploadProcessBlock;
@property (nonatomic, copy) VoidBlockType failedUploadBlock;
@property (nonatomic) BOOL finishedLoad;

- (id)proxyForJsonToChatMessage;


@end
