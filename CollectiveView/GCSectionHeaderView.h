//
//  GCSectionHeaderView.h
//  GameChat
//
//  Created by hyice on 14-9-23.
//  Copyright (c) 2014年 Ruoogle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum GCSectionHeaderViewStyle_{
  
  GCSectionHeaderViewStyle_normal,
  GCSectionHeaderViewStyle_simple,
  GCSectionHeaderViewStyle_higher,
  
} GCSectionHeaderViewStyle;

@class GCSectionHeaderView;

@protocol GCSectionHeaderViewDelegate <NSObject>

- (void)sectionHeaderView:(GCSectionHeaderView *)view sectionTappedWithIndex:(NSInteger)index title:(NSString *)title;

@optional
- (void)sectionChangeAnimationFinished:(GCSectionHeaderView *)view;

@end

@interface GCSectionHeaderView : UIView

@property (nonatomic, assign) id<GCSectionHeaderViewDelegate> delegate;
@property (nonatomic, assign) GCSectionHeaderViewStyle  style;
@property (nonatomic, assign) BOOL selectable;

- (instancetype)initWithSectionTitles:(NSArray *)titles;
- (instancetype)initWithSectionTitles:(NSArray *)titles defaultSelectedIndex:(NSInteger)selectedIndex;
- (instancetype)initWithSectionTitles:(NSArray *)titles defaultSelectedIndex:(NSInteger)selectedIndex style:(GCSectionHeaderViewStyle)style;
- (instancetype)initWithFrame:(CGRect)frame sectionTitles:(NSArray *)titles;
- (instancetype)initWithSectionTitles:(NSArray *)titles style:(GCSectionHeaderViewStyle)style;
- (instancetype)initWithFrame:(CGRect)frame sectionTitles:(NSArray *)titles defaultSelectIndex:(NSInteger)selectedIndex;

- (void)changeToSectionByIndex:(NSInteger)index;
- (void)changeToSectionByTitle:(NSString *)title;
- (void)changetoSelectedIndex;

- (void)sectionHeaderViewScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)updateSectionTitle:(NSString *)title atIndex:(NSInteger)index;

- (void)setImage:(UIImage *)image atIndex:(NSInteger)index;

@end
