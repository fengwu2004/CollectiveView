//
//  GCGift.m
//  GameChat
//
//  Created by Tom on 7/10/13.
//  Copyright (c) 2013 Ruoogle. All rights reserved.
//

#import "GCGift.h"

#define kGiftName     @"name"
#define kID       @"gift_id"
#define kImageURL @"image_url"
#define kCoin      @"coin"
#define kCharming @"charming"
#define kQty      @"amount"
#define kSendAmount   @"sendAmount"
#define kOriginalCoin   @"origin_coin"
#define kDescription @"description"
#define kDisplayType @"display"
#define kVipCoin @"vip_coin"

@implementation GCGift

- (void)setValuesWithDictionary:(NSDictionary *)dictionary {
	
  _name = [[dictionary objectForKey:kGiftName] copy];
  
  _giftID = [[dictionary objectForKey:kID] intValue];

  _imageurl= [[dictionary objectForKey:kImageURL] copy];
  
  _coin = [[dictionary objectForKey:kCoin] intValue];
  
  _charming = [[dictionary objectForKey:kCharming] intValue];
}

+ (NSString *)jsonKey {
  
  return @"gift";
}

#pragma mark - Public
- (int)cost {
  
  return _coin;
}

@end
