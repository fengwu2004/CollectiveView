//
//  GCGift.h
//  GameChat
//
//  Created by Tom on 7/10/13.
//  Copyright (c) 2013 Ruoogle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GCGiftType) {
  
  GCGiftType_Normal = 1,
  GCGiftType_SpecialOnSale = 0,
  GCGiftType_SpecialOffSale = -1,
	GCGiftType_RedPaper		= 2,
};

typedef NS_ENUM(NSInteger, GCGiftSendedFromPlace) {
  
  GCGiftSendedFromPlace_Unknown = 0,
  GCGiftSendedFromPlace_GameChat = 1,
  GCGiftSendedFromPlace_HostRoom = 2,
  GCGiftSendedFromPlace_WaitingRoom = 3,
  GCGiftSendedFromPlace_OfflineChat = 4,
  GCGiftSendedFromPlace_WhispersTalk = 5,
};

@interface GCGift : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic) int giftID;

@property (nonatomic) int charming;
@property (nonatomic) int coin;

- (int)cost;

@end
