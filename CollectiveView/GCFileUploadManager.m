//
//  GCFileUploadManager.m
//  GameChat
//
//  Created by hyice on 14-10-31.
//  Copyright (c) 2014年 Ruoogle. All rights reserved.
//

#import "GCFileUploadManager.h"
//#import <QiniuSDK.h>
#import "NSDate+TomAddition.h"
//#import "GCAppSharedData.h"
//#import "GCHttpRequestManager.h"
//#import "MediaServerUploadToken.h"
//#import "GCPlistOnlineConfiguration.h"

static GCFileUploadManager *sharedManager = nil;

@implementation GCFileUploadManager {
  
  QNUploadManager *_qiniuUploadManager;
}

+ (GCFileUploadManager *)sharedManager {
  
  if (!sharedManager) {
    
    sharedManager = [[GCFileUploadManager alloc]init];
  }
  
  return sharedManager;
}

- (instancetype)init {
  
  self = [super init];
  
  if (self) {
    
    _qiniuUploadManager = [[QNUploadManager alloc]init];
  }
  
  return self;
}

#pragma mark - token
- (NSString *)qiniuUploadToken {

  return [[GCAppSharedData sharedInstance]uploadToken].upload_token;
}

- (BOOL)isQiniuTokenExpired {
  
  return [[[GCAppSharedData sharedInstance]uploadToken]isTokenExpired];
}

- (BOOL)needToRefreshQiniuTokenAsyncly {
  
  return [[[GCAppSharedData sharedInstance]uploadToken]needToRefreshToken];
}

- (void)refreshQiniuTokenWithBlock:(void (^)())successBlock {
  
  [[[GCAppSharedData sharedInstance]uploadToken]refreshToken:successBlock];
}

#pragma mark - upload file
- (void)uploadImage:(UIImage *)image
              extra:(NSArray *)extraFileNameInfos
            success:(void (^)(NSString *))success
            failure:(BOOL (^)(NSError *))failure
           progress:(void (^)(CGFloat))progress {
  
  NSString *filePath = [[self class]saveImageAsTmpUploadingFile:image];
  
  [self uploadFile:filePath
              type:GCFileType_Image
             extra:extraFileNameInfos
           success:success failure:failure
          progress:progress];
}

- (void)uploadFile:(NSString *)filePath
              type:(GCFileType)fileType
             extra:(NSArray *)extraFileNameInfos
           success:(void (^)(NSString *))success
           failure:(BOOL (^)(NSError *))failure
          progress:(void (^)(CGFloat))progress {
  
  if ([self isQiniuTokenExpired]) {
    
    [self refreshQiniuTokenWithBlock:^{
      
      [self startUploadWithFilePath:filePath
                               type:fileType
                              extra:extraFileNameInfos
                            success:success
                            failure:failure
                           progress:progress];
    }];
  }else {
    
    [self startUploadWithFilePath:filePath
                             type:fileType
                            extra:extraFileNameInfos
                          success:success
                          failure:failure
                         progress:progress];
    
    if([self needToRefreshQiniuTokenAsyncly]) {
      
      [self refreshQiniuTokenWithBlock:nil];
      
    }
  }
  
}

- (void)startUploadWithFilePath:(NSString *)filePath
                           type:(GCFileType)fileType
                          extra:(NSArray *)extra
                        success:(void (^)(NSString *))success
                        failure:(BOOL (^)(NSError *))failure
                       progress:(void (^)(CGFloat))progress{
  
  QNUploadOption *option = nil;
  if (progress) {
    
    option = [[QNUploadOption alloc]initWithProgessHandler:^(NSString *key, float percent) {
      
      progress(percent);
    }];
  }
  
  [_qiniuUploadManager putFile:filePath key:[[self class] serverFileNameForFileType:fileType extra:extra] token:[self qiniuUploadToken] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      if (info.error) {
        
        if (!failure || !failure(info.error)) {
          
          NSString *localizedFailureReason = [info.error localizedFailureReason];
          NSString *localizedRecoverySuggestion = [info.error localizedRecoverySuggestion];
          
          NSMutableString *alerString = [NSMutableString stringWithString:[info.error localizedDescription]];
          
          if (localizedFailureReason) {
            
            [alerString appendFormat:@", %@", localizedFailureReason];
          }
          
          if (localizedRecoverySuggestion) {
            
            [alerString appendFormat:@", %@", localizedRecoverySuggestion];
          }
          
          [GCUtilties simpleOkAlert:alerString];
        }
        
      }else {
        
        if (success) {
          
          success(key);
        }
      }
    });


  } option:option];
}

#pragma mark - file name generator
+ (NSString *)serverFileNameForFileType:(GCFileType)fileType extra:(NSArray *)extra{
  
  NSString *typeStr;
  NSString *fileFormatStr;
  
  switch (fileType) {
      
    case GCFileType_Image:
      typeStr = @"image";
      fileFormatStr = @"jpg";
      break;
      
    case GCFileType_Audio:
      typeStr = @"audio";
      fileFormatStr = @"amr";
      break;
      
    case GCFileType_Video:
      typeStr = @"video";
      fileFormatStr = @"mp4";
      break;
    
    case GCFileType_QRCode:
      typeStr = @"qrcode";
      fileFormatStr = @"jpg";
      break;
      
    default:
      typeStr = @"unknow";
      fileFormatStr = @"other";
      break;
  }

  NSString *userIdStr = LONGLONG2STR([GCAppSharedData myself].userID);
  NSString *dateStr = [[NSDate date]pd_shortDateString];
  NSTimeInterval timeInterval = [[NSDate date]timeIntervalSinceReferenceDate]*1000*1000;    // 精确到微秒
  
  NSMutableString *result;
  if (fileType == GCFileType_QRCode) {
    result = [NSMutableString stringWithFormat:@"image/%@/%@", typeStr, userIdStr];

  }else {
    result = [NSMutableString stringWithFormat:@"%@/%@/%@/%.0f", typeStr, userIdStr, dateStr, timeInterval];
  
    for (NSString *extraStr in extra) {
      
      [result appendFormat:@"_%@", extraStr];
    }
  }
  [result appendFormat:@".%@", fileFormatStr];
  
  return result;
}

#pragma mark - save date as tmp uploading file
+ (NSString *)saveImageAsTmpUploadingFile:(UIImage *)image {
  
  NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"uploadingImage.jpg"];
  
  [UIImageJPEGRepresentation(image, 1.0) writeToFile:filePath atomically:YES];
  
  return filePath;
}
@end
