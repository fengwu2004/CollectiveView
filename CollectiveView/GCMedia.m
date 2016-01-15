//
//  MPFile.m
//  Phamily
//
//  Created by zys on 12-11-21.
//  Copyright (c) 2012年 儒果网络. All rights reserved.
//

#import "GCMedia.h"

#define kRemoteKey            @"remote_key"
#define kMimeType             @"mime_type"
#define kSizeInBytes          @"size_in_bytes"
#define kMediaType            @"media_Type"
#define kLocalCachePath       @"local_path"

@implementation GCMedia

- (void)setValuesWithDictionary:(NSDictionary *)dictionary {

  [super setValuesWithDictionary:dictionary];
  _mimeType = [[dictionary objectForKey:kMimeType] copy];
  _sizeInBytes = [[dictionary objectForKey:kSizeInBytes] intValue];
  _mediaType = [[dictionary objectForKey:kMediaType] intValue];
  _localCachePath = [[dictionary objectForKey:kLocalCachePath] copy];
  _remoteStorageKey = [[dictionary objectForKey:kRemoteKey] copy];
  _finishedLoad = FALSE;

}

- (id)proxyForJson {

  NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  [dic setDictionary:[super proxyForJson]];

  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, _mimeType, kMimeType);
  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, _remoteStorageKey, kRemoteKey);
  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, _localCachePath, kLocalCachePath);
  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, INT2NUM(_sizeInBytes), kSizeInBytes);
  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, INT2NUM(_mediaType), kMediaType);

  return dic;
}

- (id)proxyForJsonToChatMessage {

  NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  [dic setDictionary:[super proxyForJson]];

  SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, _remoteStorageKey, kRemoteKey);

  return dic;

}

- (void)encodeWithCoder:(NSCoder *)aCoder {

  [aCoder encodeObject:_mimeType forKey:kMimeType];
  [aCoder encodeObject:_remoteStorageKey forKey:kRemoteKey];
  [aCoder encodeObject:_localCachePath forKey:kLocalCachePath];
  [aCoder encodeInt:_mediaType forKey:kMediaType];
  [aCoder encodeInt:(int)_sizeInBytes forKey:kSizeInBytes];
}

- (id)initWithCoder:(NSCoder *)aDecoder {

  self = [super init];

  if (self) {
    _mimeType = [[aDecoder decodeObjectForKey:kMimeType] copy];
    _remoteStorageKey = [[aDecoder decodeObjectForKey:kRemoteKey] copy];
    _localCachePath = [[aDecoder decodeObjectForKey:kLocalCachePath] copy];
    _mediaType = [aDecoder decodeIntForKey:kMediaType];
    _sizeInBytes = [aDecoder decodeIntForKey:kSizeInBytes];
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {


  GCMedia *copy = [[[self class] allocWithZone:zone] init];

  copy.remoteStorageKey = [_remoteStorageKey copyWithZone:zone];
  copy.mimeType = [_mimeType copyWithZone:zone];
  copy.localCachePath = [_localCachePath copyWithZone:zone];
  copy.mediaType = _mediaType;
  copy.sizeInBytes = _sizeInBytes;

  return copy;
}

+ (NSString *)jsonKey {

  return @"media";
}


@end
