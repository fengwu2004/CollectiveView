//
//  DrawViewController.m
//  CollectiveView
//
//  Created by ky on 16/5/24.
//  Copyright © 2016年 user. All rights reserved.
//

#import "DrawViewController.h"
#import "YFDrawView.h"

@interface DrawViewController ()

@property (nonatomic, retain) IBOutlet YFDrawView *drawView;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_drawView setNumber:2];
}

@end
