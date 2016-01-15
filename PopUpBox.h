//
//  PopUpBox.h
//  CollectiveView
//
//  Created by user on 16/1/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopUpBoxItem;

@interface PopUpBox : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSArray<__kindof PopUpBoxItem*> *dataSource;

- (id)initWithFrame:(CGRect)frame with:(NSArray*)array;

@end
