//
//  GCFileUploadManager.h
//  GameChat
//
//  Created by hyice on 14-10-31.
//  Copyright (c) 2014年 Ruoogle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GCFileType) {
  
  GCFileType_Image,
  GCFileType_Audio,
  GCFileType_Video,
  GCFileType_QRCode
};

@interface GCFileUploadManager : NSObject

+ (GCFileUploadManager *)sharedManager;

/**
 * get formatted server file name for specified file type
 *
 * @param fileType type of file need to upload to server
 * @param extra an Array contains infos need to append to file name
 */
+ (NSString *)serverFileNameForFileType:(GCFileType)fileType extra:(NSArray *)extra;

- (void)uploadImageArray:(NSMutableArray *)imageArray
         lastResultArray:(NSMutableArray *)lastKeyArray
                   extra:(NSArray *)extraFileNameInfos
                 success:(void (^)(NSArray *))arraySuccess
                 failure:(BOOL (^)(NSError *))arrayFailure
                progress:(void (^)(CGFloat))arrayProgress;

- (void)uploadImage:(UIImage *)image
              extra:(NSArray *)extraFileNameInfos
            success:(void (^)(NSString *shortUrl))success
            failure:(BOOL (^)(NSError *error))failure
           progress:(void (^)(CGFloat percent))progress;

- (void)uploadFile:(NSString *)filePath
              type:(GCFileType)fileType
             extra:(NSArray *)extraFileNameInfos
           success:(void (^)(NSString *shortUrl))success
           failure:(BOOL (^)(NSError *error))failure
          progress:(void (^)(CGFloat percent))progress;
@end
