//
//  PopUpBoxItem.m
//  CollectiveView
//
//  Created by user on 16/1/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "PopUpBoxItem.h"

@implementation PopUpBoxItem

+ (PopUpBoxItem*)makePopItem:(NSString*)iconName title:(NSString*)title block:(popUpItemBlock)block {
	
	PopUpBoxItem *item = [[PopUpBoxItem alloc] init];
	
	item.block = block;
	
	item.iconName = iconName;
	
	item.title = title;
	
	return item;
}

@end
