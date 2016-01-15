//
//  PopUpTestVCTL.m
//  CollectiveView
//
//  Created by user on 16/1/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "PopUpTestVCTL.h"
#import "PopUpBoxItem.h"
#import "PopUpBox.h"

@interface PopUpTestVCTL ()

@end

@implementation PopUpTestVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onPopUpBox:(id)sender {
	
	PopUpBoxItem *item0 = [PopUpBoxItem makePopItem:@"giftn11" title:@"秀场的成员管理" block:nil];
	
	PopUpBoxItem *item1 = [PopUpBoxItem makePopItem:@"giftn12" title:@"秀场名称" block:nil];
	
	PopUpBoxItem *item2 = [PopUpBoxItem makePopItem:@"giftn101" title:@"背景音乐" block:nil];
	
	PopUpBoxItem *item3 = [PopUpBoxItem makePopItem:@"giftn102" title:@"进入限制" block:nil];
	
	PopUpBoxItem *item4 = [PopUpBoxItem makePopItem:@"giftn103" title:@"关于聊吧" block:nil];
	
	PopUpBoxItem *item5 = [PopUpBoxItem makePopItem:@"giftn104" title:@"谁是卧底" block:nil];
	
	NSArray *array = @[item0, item1, item2, item3, item4, item5];
	
	UIButton *button = (UIButton*)sender;
	
	CGPoint point = button.frame.origin;
	
	PopUpBox *box = [[PopUpBox alloc] initWithFrame:CGRectMake(point.x, point.y + 50, 120, 30 * 6) with:array];
	
	[self.view addSubview:box];
}

@end
