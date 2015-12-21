//
//  GCGiftView.h
//  CollectiveView
//
//  Created by user on 15/12/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCGiftView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UICollectionView *ibCollectionGift;
@property (nonatomic, retain) IBOutlet UIPageControl *ibPage;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *ibBtnWidth;
@property (nonatomic, retain) IBOutlet UIButton *ibBtnSend;
@property (nonatomic, retain) IBOutlet UILabel *ibBtnRecharge;


@end
