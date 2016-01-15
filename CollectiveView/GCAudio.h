//
//  GCAudio.h
//  Phamily
//
//  Created by zys on 12-11-20.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCMedia.h"
#import "CommonTypes.h"

#define AUDIOWAVTYPE @"wav"
#define AUDIOAMRTYPE @"amr"

typedef enum GCAudioPlayStatus_ {

  GCAudioPlayStatus_neverplay,
  GCAudioPlayStatus_playing,
  GCAudioPlayStatus_paused,
  GCAudioPlayStatus_stopped

} GCAudioPlayStatus;

@interface GCAudio : GCMedia <NSCoding, NSCopying>

@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic) NSUInteger lengthInSeconds;
@property (nonatomic, copy) NSString *audioType;


//保存在本地的文件名
@property (nonatomic, copy) NSString *audioName;
//声音压缩后的路径
@property (nonatomic, copy) NSString *localAmrPath;

@property (nonatomic) GCAudioPlayStatus audioPlayStatus;

- (void)uploadAudioFrom:(GCMediaGenerateFrom)from extra:(NSDictionary*)extraDic;

- (id)initWithGCMediaGenerateFrom:(GCMediaGenerateFrom)from withExtraInfo:(NSDictionary*)extraDic isInTempFolder:(BOOL)isInTemp;

- (id)initWithChatGroupId:(long long)chatGroupId andUserId:(long long)userId;

- (BOOL)saveAudioFileByChatGroupId:(long long)chatGroupId andUserId:(long long)userId;

- (BOOL)saveAudioFileByGCMediaGenerateFrom:(GCMediaGenerateFrom)from andExtraInfo:(NSDictionary*)extraDic isInTempFolder:(BOOL)isInTem;

- (void)downloadAudioImmediately;
@end
