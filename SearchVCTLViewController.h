//
//  SearchVCTLViewController.h
//  CollectiveView
//
//  Created by user on 16/1/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVCTLViewController : UIViewController<UISearchBarDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *ibSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *ibTableView;

@end
