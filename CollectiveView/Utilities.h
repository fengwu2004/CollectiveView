//
//  Utilities.h
//
//  Created by Chen Jianfei on 2/11/11.
//  Copyright 2011 Fakastudio. All rights reserved.
//	Last Update: Oct 13, 2011

#import <Foundation/Foundation.h>
//#import <CommonCrypto/CommonDigest.h>

#import "NSDate+TomAddition.h"
#import "NSString+TomAddition.h"
#import "NSString+MD5Addition.h"
#import "Macros.h"
#import "CommonTypes.h"

///// 屏幕大小
#define SCREEN_ORIGIN_Y 0
#define SCREEN_HEIGHT   [Utilities deviceHeight]
#define SCREEN_HEIGHT_WITHOUT_STATUS_BAR  [Utilities deviceHeightWithoutStatusBar]
#define SCREEN_WIDTH   [Utilities deviceWidth]

typedef NS_ENUM(NSInteger, GCAlipayHandleType) {
  GCAlipayHandleType_Success,
  GCAlipayHandleType_WrongSign,
  GCAlipayHandleType_Fail
};

@interface Utilities : NSObject

//generates md5 hash from a string
+ (NSString *)returnMD5Hash:(NSString *)concat;

+ (NSString *)returnMD5Hash:(NSString *)oneStr withString:(NSString *)twoStr;

+ (NSString *)returnMD5Base64:(NSString *)str;


+ (void)playSystemSound:(NSString *)fileName withType:(NSString *)type;

+ (void)playSystemSoundMessageSent;

+ (void)playSystemSoundEmpty;

+ (void)playSystemSoundNewMessageComing;

+ (void)duckOtherAudios:(BOOL)active;

+ (NSString *)encodingString:(NSString *)sourceString;

+ (NSString *)encoding:(NSString *)par1 with:(NSString *)par2;

+ (NSString *)deviceIMEIStr;

+ (NSString *)simIMSIStr;

+ (BOOL)checkNeedsUpdateDeviceUDID;
+ (NSString *)macGenerateUDID;

+ (NSString *)deviceUDID;

+ (NSString*)adidGenerateUDID;

+ (void)saveDeviceUDID:(NSString*)udid;

+ (NSString *)deviceName;

+ (CGFloat)deviceVersion;

+ (NSString *)deviceVersionString;

+ (NSString *)appVersion;

+ (CGFloat)deviceWidth;
+ (CGFloat)deviceHeight;
+ (CGFloat)deviceHeightWithoutStatusBar;

+ (NSString *)appVersionAndBuildString;

+ (NSString *)appBundleDisplyName;

+ (NSString *)appBundle;

+ (NSString *)appChannel;

+ (NSString *)appBuildString;

+ (void)alertInstant:(NSString *)message isError:(BOOL)isError;

+ (void)alertInstant:(NSString *)message image:(UIImage *)image;

+ (void)errorAlert:(NSString *)message;

+ (NSString *)fileName2docFilePath:(NSString *)fileName;
+ (NSString *)filename2tmpFilePath:(NSString *)fileName;

+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledToSize:(CGSize)targetSize;

+ (BOOL)isMobileNumber:(NSString *)mobileNumStr;

+ (NSUInteger)keyboardHeight:(NSNotification *)n inWindow:(UIWindow *)window;

+ (UIDeviceOrientation)deviceOrientationByInterfaceOrientation:(UIInterfaceOrientation)orientation;

+ (BOOL)validateMobileNumber:(NSString *)candidate;

+ (BOOL)validateEmail:(NSString *)candidate;

// 获得颜色数组
+ (NSArray *)getRGBAsFromImage:(UIImage *)image atX:(int)xx andY:(int)yy count:(int)count;

// 获得在某个区域颜色深浅，返回black或white颜色，从而可以显示清晰字体
+ (UIColor *)fontColorFromImage:(UIImage *)image inRect:(CGRect)rect;

+ (UITableViewCell *)cellByClassName:(NSString *)className inNib:(NSString *)nibName forTableView:(UITableView *)tableView;

+ (UIView *)viewByClassName:(NSString *)className inNib:(NSString *)nibName;

/* 功能：获取设备类型 */
+ (NSString *)getDeviceVersion;

+ (BOOL)isIphone4S;
+ (BOOL)isRetina4;
+ (BOOL)isRetina;
+ (BOOL)isIphone6;
+ (BOOL)isIphone6P;
+ (BOOL)isSimulator;
+ (BOOL)isIphone5OrLater;
+ (BOOL)isRetina35;

/** 判断当前设备是否ipad */
+ (BOOL)isIpad;

//获取文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath;

+ (CGSize)deviceSize;

// 判断一个浮点数是否是整数
+ (BOOL)isInt:(double)a;

+ (NSString *)double2string:(double)doubleValue;

+ (void)runOnMainQueueWithoutDeadlocking:(VoidBlockType)block;

+ (void)runAsynchronize:(VoidBlockType)block;

+ (BOOL)hasWifiAvailable;

// 把一组array根据seperator拼成一个string
+ (NSString *)stringByStringArray:(NSArray *)array withSeperator:(NSString *)seperator;

// 画扇形
#define RAD(x) ((x)*M_PI/180.0)
+ (void)drawArcInView:(UIView *)view startAngle:(float) angle_start endAngle:(float)angle_end color:(UIColor*) color clockwise:(BOOL)isClockwise;
+ (void)drawArcInView:(UIView *)view startAngle:(float) angle_start endAngle:(float)angle_end radiu:(NSUInteger)radius color:(UIColor*) color clockwise:(BOOL)isClockwise;

//如果小于10,在前面增加0
+ (NSString *)stringWithZero:(int)count;

// 10进制数变成16进制字符串
+ (NSString *)dec2hexString:(int)dec length:(int)length;

//DES 加密解密
+ (NSString *)desEncryption:(NSString *)sTextIn key:(NSString *)sKey isEncryption:(BOOL)isEncryption;

// 给view增加闪烁的动画
+ (void)blinkAnimationForView:(UIView *)view withDuration:(float)duration andRepeatCount:(float)repeatCount;

// 给view增加放大缩小的动画
+ (void)expandAnimationForViews:(NSArray *)views withDuration:(float)duration andRepearCount:(float)repeatCount dx:(float)dx dy:(float)dy;

+ (NSString*)sortDictionaryByKey:(NSDictionary*)dic;
+ (NSString*)sortDictionaryByKey:(NSDictionary*)dic andAddSeperator:(NSString*)seperator;

// 数字转带千位分号的字符串
+ (NSString *)stringWithDigitGrouping:(NSUInteger)number;

+ (void)writeQiniuFailedReasonToFile:(NSError*)error FilePath:(NSString*)fileURL isImage:(BOOL)isImage isDownload:(BOOL)isDownload;

+ (CGFloat)fontSizeByFrame:(CGRect)frame text:(NSString *)text;
+ (CGFloat)fontSizeByFrame:(CGRect)frame text:(NSString *)text heightRate:(CGFloat)heightRate widthRate:(CGFloat)widthRate;
+ (CGFloat)boldFontSizeByFrame:(CGRect)frame text:(NSString *)text;
+ (CGFloat)boldFontSizeByFrame:(CGRect)frame text:(NSString *)text heightRate:(CGFloat)heightRate widthRate:(CGFloat)widthRate;

// 解析支付宝返回参数
+ (NSString*)getAlipayResultString:(NSString*)result;
+ (NSString*)getAlipaySignString:(NSString*)result;
+ (GCAlipayHandleType)handleAlipayResult:(NSDictionary*)resultDic;


+ (CGSize)labelSizeByText:(NSString *)text fontSize:(CGFloat)fontSize maxWidth:(CGFloat)width;

+ (CGSize)labelSizeByText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width;

+ (void)setBtnDefaultStyle:(UIButton*)button;

@end
