//
//  GCSectionHeaderView.m
//  GameChat
//
//  Created by hyice on 14-9-23.
//  Copyright (c) 2014年 Ruoogle. All rights reserved.
//

#import "GCSectionHeaderView.h"
#import "Utilities.h"
#import "GCDefines.h"

#define kDefaultViewHeight 34

#define kDefaultUnselectedTitleColorRedValue    80
#define kDefaultUnselectedTitleColorGreenValue  80
#define kDefaultUnselectedTitleColorBlueValue   80


#define kDefaultSelectedTitleColorRedValue 0
#define kDefaultSelectedTitleColorGreenValue 0
#define kDefaultSelectedTitleColorBlueValue 0

#define kDefaultSelectedLineHeight 3
#define kDefaultSelectedLineColor (UIColorFromRGB(0xff9501))

#define kSeperateLineHeight 0.2

#define kMaxBtnFontSize 20
#define kMinBtnFontSize 10

#define kSelectedFontSize 15
#define kUnSelectedFontSize 12

#define kSectionCount ([self.titles count])
#define kSectionWidth (self.frame.size.width * 1.0 / kSectionCount)

@interface GCSectionHeaderView ()

@property (nonatomic, retain) NSArray *titles;
@property (nonatomic, retain) NSArray *btns;

@property (nonatomic, retain) UIView *selectedLine;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, assign) NSInteger currentSelectedIndex;

@end

@implementation GCSectionHeaderView

- (void)setStyle:(GCSectionHeaderViewStyle)style {
  
  _style = style;
  
  if (style == GCSectionHeaderViewStyle_simple) {
    [_selectedLine setHidden:YES];
  }else {
    [_selectedLine setHidden:NO];
  }
}


- (instancetype)initWithFrame:(CGRect)frame {
  
  _selectable = YES;
  
  return [self initWithFrame:frame sectionTitles:@[]];
}

- (instancetype)initWithSectionTitles:(NSArray *)titles style:(GCSectionHeaderViewStyle)style {
  
  return [self initWithSectionTitles:titles defaultSelectedIndex:0 style:style];
}

- (instancetype)initWithSectionTitles:(NSArray *)titles {
  
  return [self initWithSectionTitles:titles defaultSelectedIndex:0 style:GCSectionHeaderViewStyle_normal];
}

- (instancetype)initWithSectionTitles:(NSArray *)titles defaultSelectedIndex:(NSInteger)selectedIndex {
  
  if (_style == GCSectionHeaderViewStyle_higher) {
    
    return [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDefaultViewHeight+8) sectionTitles:titles defaultSelectIndex:selectedIndex];
    
  }else {
    return [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDefaultViewHeight) sectionTitles:titles defaultSelectIndex:selectedIndex];
  }
}

- (instancetype)initWithSectionTitles:(NSArray *)titles defaultSelectedIndex:(NSInteger)selectedIndex style:(GCSectionHeaderViewStyle)style {
  
  [self setStyle:style];
  return [self initWithSectionTitles:titles defaultSelectedIndex:selectedIndex];
}

- (instancetype)initWithFrame:(CGRect)frame sectionTitles:(NSArray *)titles {
  
  return [self initWithFrame:frame sectionTitles:titles defaultSelectIndex:0];
}

- (instancetype)initWithFrame:(CGRect)frame sectionTitles:(NSArray *)titles defaultSelectIndex:(NSInteger)selectedIndex {
  
  self = [super initWithFrame:frame];
  
  if (self) {
    
    _selectable = YES;
    self.backgroundColor = UIColorFromRGB(0xf9f9f9);
    _titles = [titles retain];
    _currentSelectedIndex = selectedIndex;
    [self initViews];
  }
  
  return self;
}

#pragma mark - 更新section标题
- (void)updateSectionTitle:(NSString *)title atIndex:(NSInteger)index {
  
  if (index > (self.titles.count - 1)) {
    
    return;
  }
  
  NSMutableArray *tmpTitles = [[NSMutableArray alloc]initWithArray:_titles];
  
  [tmpTitles replaceObjectAtIndex:index withObject:title];
  
  self.titles = [NSArray arrayWithArray:tmpTitles];
  
  [tmpTitles release];
  
  UIButton *btn = [self.btns objectAtIndex:index];
  [btn setTitle:title forState:UIControlStateNormal];
  [btn setTitle:title forState:UIControlStateHighlighted];
}

#pragma mark - scroll view scrolls
- (void)sectionHeaderViewScrollViewDidScroll:(UIScrollView *)scrollView {
  
  if ((!scrollView.dragging || scrollView.isDecelerating)) {
    
    CLog(@"offsetx:%f", scrollView.contentOffset.x);
    
    CGFloat originOffset = scrollView.frame.size.width * _currentSelectedIndex;
    
    CGFloat offset = scrollView.contentOffset.x - originOffset;
    CGFloat minNeedOffset = scrollView.frame.size.width/4.0;
    
    NSInteger index;
    if (offset > minNeedOffset) {
      
      index = _currentSelectedIndex + 1;
    }else if(offset < -minNeedOffset) {
      
      index = _currentSelectedIndex - 1;
    }else {
      
      index = _currentSelectedIndex;
    }
    
    [self changeToSectionByIndex:index];
  }else {
    
    NSInteger sectionCount = scrollView.contentOffset.x/scrollView.frame.size.width;
    CGFloat offsetX = kSectionWidth * ((scrollView.contentOffset.x - scrollView.frame.size.width*sectionCount)*1.0/scrollView.frame.size.width);
    
    [self moveSelectedLineToStartX:kSectionWidth*sectionCount + offsetX];
    
    [self changeTitleColorInSection:sectionCount withSelectedLineInRate:(kSectionWidth - offsetX)/kSectionWidth];
    
    if (offsetX >=0 && (sectionCount+1)<kSectionCount) {
      
      [self changeTitleColorInSection:sectionCount+1 withSelectedLineInRate:offsetX/kSectionWidth];
    }
  }
}

- (void)moveSelectedLineToStartX:(CGFloat)x {
  
  CGFloat realX = x;
  CGFloat width = self.frame.size.width * 1.0 / self.titles.count;
  
  if (realX < 0) {
    
    width += realX;
    realX = 0;
  }
  
  CGRectSet(self.selectedLine, realX, -1, width, -1);
}

- (void)changeTitleColorInSection:(NSInteger)section withSelectedLineInRate:(CGFloat)inRate {
  
  UIButton *btn = [self.btns objectAtIndex:section];

  [btn setTitleColor:[UIColor colorWithRed:[self redColorValueByInRate:inRate]/255.0
                                    green:[self greenColorValueByInRate:inRate]/255.0
                                     blue:[self blueColorValueByInRate:inRate]/255.0
                                     alpha:1.0] forState:UIControlStateNormal];
}

- (CGFloat)redColorValueByInRate:(CGFloat)inRate {
  
  return kDefaultUnselectedTitleColorRedValue + (kDefaultSelectedTitleColorRedValue - kDefaultUnselectedTitleColorRedValue)*inRate;
}

- (CGFloat)greenColorValueByInRate:(CGFloat)inRate {
  
  return kDefaultUnselectedTitleColorGreenValue + (kDefaultSelectedTitleColorGreenValue - kDefaultUnselectedTitleColorGreenValue)*inRate;
}

- (CGFloat)blueColorValueByInRate:(CGFloat)inRate {
  
  return kDefaultUnselectedTitleColorBlueValue + (kDefaultSelectedTitleColorBlueValue - kDefaultUnselectedTitleColorBlueValue)*inRate;
}

#pragma mark - section 切换
- (void)changetoSelectedIndex {
  
  [self changeToSectionByIndex:_currentSelectedIndex];
}

- (void)changeToSectionByIndex:(NSInteger)index {

  if (!_selectable) {
    
    return;
  }
  
  if (index < 0) {
    
    index = 0;
  }
  
  // 注意， btns.count 返回的是 NSUInteger, 如果不先比较小于0，这里的比较会出错
  if (index >= _btns.count) {
    
    index = _btns.count - 1;
  }
  
  [UIView animateWithDuration:0.3f animations:^{

    for (UIButton *btn in self.btns) {
      
      [btn setTitleColor:[UIColor colorWithRed:kDefaultUnselectedTitleColorRedValue/255.0
                                                    green:kDefaultUnselectedTitleColorGreenValue/255.0
                                                     blue:kDefaultUnselectedTitleColorBlueValue/255.0
                                                    alpha:1.0] forState:UIControlStateNormal];
      [btn.titleLabel setFont:[UIFont systemFontOfSize:kUnSelectedFontSize]];
    }

    UIButton *newSelectedBtn = [self.btns objectAtIndex:index];
    if (_style == GCSectionHeaderViewStyle_simple) {

      [newSelectedBtn setTitleColor:kAppOrangeColor forState:UIControlStateNormal];
      
    }else {
      
      [newSelectedBtn setTitleColor:[UIColor colorWithRed:kDefaultSelectedTitleColorRedValue/255.0
                                         green:kDefaultSelectedTitleColorGreenValue/255.0
                                          blue:kDefaultSelectedTitleColorBlueValue/255.0
                                         alpha:1.0] forState:UIControlStateNormal];
    }
    
    [newSelectedBtn.titleLabel setFont:[UIFont systemFontOfSize:kSelectedFontSize]];
    
    self.selectedLine.frame = [self selectedLineFrameBySelectedIndex:index];

    self.currentSelectedIndex = index;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionHeaderView:sectionTappedWithIndex:title:)]) {
      
      [self.delegate sectionHeaderView:self sectionTappedWithIndex:index title:[self.titles objectAtIndex:index]];
    }
    
  } completion:^(BOOL finished) {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionChangeAnimationFinished:)]) {
      
      [self.delegate sectionChangeAnimationFinished:self];
    }
  }];
}

- (void)changeToSectionByTitle:(NSString *)title {
  
  for (int i=0; i<self.titles.count; i++) {
    
    NSString *tmpTitle = [self.titles objectAtIndex:i];
    if ([tmpTitle isEqualToString:title]) {
      
      [self changeToSectionByIndex:i];
      
      break;
    }
  }
}

#pragma mark - 按钮点击
- (void)btnPressed:(UIButton *)btn {
  
  [self changeToSectionByIndex:btn.tag];
}

#pragma mark draw UI
- (void)initViews {
  
  [self initAndAddBtns];
  [self initAndAddSelectedLine];
  [self initAndAddSeperateLine];
}

- (void)initAndAddBtns{
  
  if (self.btns) {
    
    return;
  }
  
  NSMutableArray *tmpBtns = [[NSMutableArray alloc]initWithCapacity:kSectionCount];
  
  for (int i=0; i<kSectionCount; i++) {
    
    CGFloat startX = 0 + kSectionWidth * i;

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(startX, 0, kSectionWidth, self.frame.size.height);
    [btn setTitle:[self.titles objectAtIndex:i] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:[self fontSizeByBtn:btn]]];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = i;
    [tmpBtns addObject:btn];
    [self addSubview:btn];
    
    if (i==self.currentSelectedIndex) {
      
      
      if (_style == GCSectionHeaderViewStyle_simple) {
        [btn setTitleColor:kAppOrangeColor forState:UIControlStateNormal];
      }else {
        [btn setTitleColor:[UIColor colorWithRed:kDefaultSelectedTitleColorRedValue/255.0
                                           green:kDefaultSelectedTitleColorGreenValue/255.0
                                            blue:kDefaultSelectedTitleColorBlueValue/255.0
                                           alpha:1.0] forState:UIControlStateNormal];
      }
      
      [btn.titleLabel setFont:[UIFont systemFontOfSize:kSelectedFontSize]];
    }else {
      
      [btn setTitleColor:[UIColor colorWithRed:kDefaultUnselectedTitleColorRedValue/255.0
                                         green:kDefaultUnselectedTitleColorGreenValue/255.0
                                          blue:kDefaultUnselectedTitleColorBlueValue/255.0
                                         alpha:1.0] forState:UIControlStateNormal];
      
      [btn.titleLabel setFont:[UIFont systemFontOfSize:kUnSelectedFontSize]];
    }
  }
  
  _btns = [[NSArray alloc]initWithArray:tmpBtns];
  [tmpBtns release];
}

- (CGFloat)fontSizeByBtn:(UIButton *)btn {
  
  NSString *text = btn.titleLabel.text;
  
  for (int i=kMaxBtnFontSize; i>=kMinBtnFontSize; i--) {
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(btn.frame.size.width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:i] }
                                     context:nil
                   ].size;
    
    if (size.height <= btn.frame.size.height*0.4) {
      
      return i;
    }
  }
  
  return kMinBtnFontSize;
}

- (void)initAndAddSelectedLine {
  
  if (!_selectedLine) {
    
    _selectedLine = [[UIView alloc]initWithFrame:[self selectedLineFrameBySelectedIndex:self.currentSelectedIndex]];
    _selectedLine.backgroundColor = kDefaultSelectedLineColor;
    [self addSubview:_selectedLine];
  }
}

- (CGRect)selectedLineFrameBySelectedIndex:(NSInteger)index {
  
  CGFloat width = self.frame.size.width * 1.0 / self.titles.count;
  CGFloat startIndex = 0 + index*width;
  return CGRectMake(startIndex, self.frame.size.height - kDefaultSelectedLineHeight, width, kDefaultSelectedLineHeight);
}

- (void)initAndAddSeperateLine {
  
  UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - kSeperateLineHeight, self.frame.size.width, kSeperateLineHeight)];
  line.backgroundColor = UIColorFromRGB(0xbfbfbf);
  [self addSubview:line];
  [line release];
}

- (void)setImage:(UIImage *)image atIndex:(NSInteger)index {
  
  if (!image) {
    [_iconView setHidden:YES];
    return;
  }
  
  CGFloat startX = kSectionWidth * index;
  if (!_iconView) {
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(startX+63*SCREEN_WIDTH/320, (self.frame.size.height-10)/2.0-5, 15, 15)];
    [self addSubview:_iconView];
  }
  
  CGRectSet(_iconView, startX+63*SCREEN_WIDTH/320, (self.frame.size.height-10)/2.0-5, 15,15);
  [_iconView setHidden: _currentSelectedIndex!=index];
  [_iconView setImage:image];
}

#pragma mark -
- (void)dealloc {
  
  [_selectedLine release];
  [_btns release];
  [_titles release];
  [_iconView release];
  
  [super dealloc];
}

@end
