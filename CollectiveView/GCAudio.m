//
//  GCAudio.m
//  GameChat
//
//  Created by zys on 12-11-20.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import "GCAudio.h"
#import "GCAudioDownLoader.h"
#import "VoiceConverter.h"
#import "GCQiniuUtils.h"
//#import "GCUtilties.h"
#import "GCFileUploadManager.h"
//#import "GCDebugConfiguration.h"

#define kaudioInfo_audiokey         @"audio_key"
#define kaudioInfo_audioUrl         @"audio_url"
#define kaudioInfo_audioLength      @"audio_length"
#define kaudioInfo_audioType        @"audio_type"
#define kaudioInfo_audioSize        @"audio_size"
#define kaudioInfo_audioName        @"audio_name"
#define kaudioInfo_audioPlayStatus  @"audioPlayStatus"
#define kaudioInfo_localAmrPath    @"local_amr_path"

@implementation GCAudio

- (void)setValuesWithDictionary:(NSDictionary *)dictionary {

  [super setValuesWithDictionary:dictionary];
  _lengthInSeconds = [[dictionary objectForKey:kaudioInfo_audioLength] intValue];

  _audioType = [[dictionary objectForKey:kaudioInfo_audioType] copy];

  _audioUrl = [[dictionary objectForKey:kaudioInfo_audioUrl] copy];
	
  _localAmrPath=[[dictionary objectForKey:kaudioInfo_localAmrPath] copy];
	
  _audioName=[[dictionary objectForKey:kaudioInfo_audioName] copy];
}

- (id)proxyForJson {


  NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  [dic setDictionary:[super proxyForJson]];

  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, INT2NUM(_lengthInSeconds), kaudioInfo_audioLength);
  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, _audioType, kaudioInfo_audioType);
  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, _audioUrl, kaudioInfo_audioUrl);
  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, _localAmrPath, kaudioInfo_localAmrPath);
  
  return dic;
}


- (id)proxyForJsonToChatMessage {

  NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  [dic setDictionary:[super proxyForJsonToChatMessage]];

  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, INT2NUM(_lengthInSeconds), kaudioInfo_audioLength);
  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, _audioType, kaudioInfo_audioType);

  return dic;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

  [super encodeWithCoder:aCoder];

  [aCoder encodeObject:_audioUrl forKey:kaudioInfo_audioUrl];
  [aCoder encodeInt:(int)_lengthInSeconds forKey:kaudioInfo_audioLength];
  [aCoder encodeObject:_audioType forKey:kaudioInfo_audioType];
  [aCoder encodeObject:_localAmrPath forKey:kaudioInfo_localAmrPath];
  [aCoder encodeObject:_audioName forKey:kaudioInfo_audioName];
  [aCoder encodeInt:_audioPlayStatus forKey:kaudioInfo_audioPlayStatus];
  
}


- (id)initWithCoder:(NSCoder *)aDecoder {

  self = [super initWithCoder:aDecoder];

  if (self) {

    _lengthInSeconds = [aDecoder decodeIntForKey:kaudioInfo_audioLength];
    _audioType = [[aDecoder decodeObjectForKey:kaudioInfo_audioType] copy];
    _audioUrl = [[aDecoder decodeObjectForKey:kaudioInfo_audioUrl] copy];
    _localAmrPath = [[aDecoder decodeObjectForKey:kaudioInfo_localAmrPath] copy];
    _audioName = [[aDecoder decodeObjectForKey:kaudioInfo_audioName] copy];
    _audioPlayStatus = [aDecoder decodeIntForKey:kaudioInfo_audioPlayStatus];

  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {

  GCAudio *copy = [super copyWithZone:zone];

  copy.lengthInSeconds = self.lengthInSeconds;
  copy.audioType = [_audioType copyWithZone:zone];
  copy.audioUrl = [_audioUrl copyWithZone:zone];
  copy.audioName = [_audioName copyWithZone:zone];
  copy.localAmrPath = [_localAmrPath copyWithZone:zone];
  copy.audioPlayStatus = _audioPlayStatus;

  return copy;
}

- (void)uploadAudioFrom:(GCMediaGenerateFrom)from extra:(NSDictionary*)extraDic {

  self.mediaType = GC_MEDIA_AUDIO;
  self.audioType = AUDIOAMRTYPE;
  dispatch_async(dispatch_queue_create("uploadAudio", NULL), ^{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:_localAmrPath]||[VoiceConverter wavToAmr:self.localCachePath compressFilePath:_localAmrPath]) {
      
      NSData *data = [NSData dataWithContentsOfFile:_localAmrPath];
      self.sizeInBytes = [data length];
      
      NSMutableArray *tmpExtraArray = [NSMutableArray array];
      [extraDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [tmpExtraArray addObject:key];
        [tmpExtraArray addObject:obj];
      }];
      
      [[GCFileUploadManager sharedManager] uploadFile:_localAmrPath type:GCFileType_Audio extra:tmpExtraArray success:^(NSString *shortUrl) {
        
        self.remoteStorageKey = shortUrl;
        SAFECHECK_RELEASE(_audioUrl);
        _audioUrl = [[self audioUrlFromKey] copy];
        
        if (self.uploadProcessBlock) {
          self.uploadProcessBlock();
        }
        
      } failure:^BOOL(NSError *error) {
        
        if (self.failedUploadBlock) {
          self.failedUploadBlock();
        }
        
        return NO;
      } progress:nil];

    }else {
      
      if (self.failedUploadBlock) {
        self.failedUploadBlock();
      }
    }
  });
}

- (id)initWithGCMediaGenerateFrom:(GCMediaGenerateFrom)from withExtraInfo:(NSDictionary*)extraDic isInTempFolder:(BOOL)isInTemp {
  self = [super init];
  if (self) {
    long long random = arc4random() % 10000000;
    NSString *directory;
    if (isInTemp) {
      directory =  NSTemporaryDirectory();
    }else {
      directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    _audioName = [[NSString stringWithFormat:@"%@/recordedAudio_%lld.wav", [GCUtilties fromMediaGenerateFromCreateLocalFolder:from extra:extraDic inTempForlder:isInTemp], random] copy];
    self.localCachePath = [directory stringByAppendingPathComponent:_audioName];
    SAFECHECK_RELEASE(_localAmrPath);
    _localAmrPath = [[directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/recordedAudio_%lld.amr", [GCUtilties fromMediaGenerateFromCreateLocalFolder:from extra:extraDic inTempForlder:isInTemp], random]] copy];
  }
  return self;
}

- (id)initWithChatGroupId:(long long)chatGroupId andUserId:(long long)userId {
  
  self = [super init];
  if (self) {
    long long random = arc4random() % 10000000;
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    _audioName = [[NSString stringWithFormat:@"%lld_%d_recordedAudio_%lld.wav", userId, (chatGroupId<0)?(int)chatGroupId:1,random] copy];
    self.localCachePath = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:_audioName];
    SAFECHECK_RELEASE(_localAmrPath);
    _localAmrPath = [[[searchPaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld_%d_recordedAudio_%lld.amr", userId, (chatGroupId<0)?(int)chatGroupId:1,random]] copy];
  }
  return self;
}

- (BOOL)saveAudioFile {

  NSURL *url = [GCQiniuUtils urlByMediaType:_audioUrl toType:AUDIOWAVTYPE];
  
#if RESOURCE_DOWNLOAD_SWTICH_ON
  
  int random = 100 * RESOURCE_DOWNLOAD_SUCCESS_RATE;
  
  int result = arc4random() % 100;
  
  if ( result > random) {
    
    url = nil;
  }
#endif
  
  NSData* data = [GCAudioDownLoader syncSaveAudioInUrl:[url absoluteString] toPath:self.localCachePath];
  if(data){
    
    self.finishedLoad = GC_MEDIA_LOAD_SUCCESS;

    return YES;
  }
  
  self.finishedLoad = GC_MEDIA_LOAD_FAILED;
  return NO;
}

- (BOOL)saveAudioFileByGCMediaGenerateFrom:(GCMediaGenerateFrom)from andExtraInfo:(NSDictionary*)extraDic isInTempFolder:(BOOL)isInTemp {
  
  NSURL *url = [GCQiniuUtils urlByMediaType:_audioUrl toType:AUDIOWAVTYPE];
  
#if RESOURCE_DOWNLOAD_SWTICH_ON
  
  int random = 100 * RESOURCE_DOWNLOAD_SUCCESS_RATE;
  
  int result = arc4random() % 100;
  
  if ( result > random) {
    
    url = nil;
  }
#endif
  
  NSString *directory;
  if (isInTemp) {
    directory =  NSTemporaryDirectory();
  }else {
    directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  }
  
  NSString *path = [NSString stringWithFormat:@"%@/%@", [GCUtilties fromMediaGenerateFromCreateLocalFolder:from extra:extraDic inTempForlder:isInTemp], [_audioUrl lastPathComponent]];
  self.localCachePath = [directory stringByAppendingPathComponent:path];
  NSData *data = [GCAudioDownLoader syncSaveAudioInUrl:[url absoluteString] toPath:self.localCachePath];
  if (data) {
    
    return YES;
  }else {
    
    return NO;
  }
  
}

- (NSString *)audioUrlFromKey {

  return [NSString stringWithFormat:@"%@%@", [GCPlistOnlineConfiguration stringForConfigurateionType:GCPlistOnlineConfigurationType_UrlString_QiniuResourcePrefix], self.remoteStorageKey];
}

- (BOOL)downloadAudioImmediately{
  
  return [self saveAudioFile];
}


+ (NSString *)jsonKey {

  return @"audio";
}

#pragma mark -
- (NSString *)description {
  
  return [NSString stringWithFormat:@"[语音: %ld秒]", (unsigned long)_lengthInSeconds];
}

@end
