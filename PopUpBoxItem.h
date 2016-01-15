//
//  PopUpBoxItem.h
//  CollectiveView
//
//  Created by user on 16/1/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^popUpItemBlock)();

@interface PopUpBoxItem : NSObject

@property (nonatomic, copy) popUpItemBlock block;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;

+ (PopUpBoxItem*)makePopItem:(NSString*)iconName title:(NSString*)title block:(popUpItemBlock)block;

@end
