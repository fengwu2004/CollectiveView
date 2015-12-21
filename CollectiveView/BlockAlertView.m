//
//  BlockAlertView.m
//
//

#import "BlockAlertView.h"
#import "BlockBackground.h"
#import "BlockUI.h"
#import "BlockUI_nova.h"
#import "Macros.h"

#define kTextViewMaxHeight  200

@implementation BlockAlertView {
  
  UITapGestureRecognizer *_dismissTap;
  NSString *_titleString;
  NSString *_messageString;
}

@synthesize view = _view;
@synthesize backgroundImage = _backgroundImage;
@synthesize vignetteBackground = _vignetteBackground;

static UIImage *background = nil;
static UIFont *titleFont = nil;
static UIFont *messageFont = nil;
static UIFont *buttonFont = nil;

#pragma mark - init

+ (void)initialize
{
    if (self == [BlockAlertView class])
    {
        background = [background stretchableImageWithLeftCapWidth:background.size.width/2 topCapHeight:background.size.height/2];
			
        titleFont = kAlertViewTitleFont;
			
        messageFont = kAlertViewMessageFont;
			
        buttonFont = kAlertViewButtonFont;
    }
}

+ (BlockAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message
{
    return [[BlockAlertView alloc] initWithTitle:title message:message];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject
- (id)initWithTitleAttributed:(NSAttributedString *)attributeTitle messageAttributed:(NSAttributedString *)messageAttributed {
  
  if ((self = [super init]))
  {
    UIWindow *parentView = [BlockBackground sharedInstance];
    CGRect frame = parentView.bounds;
    frame.origin.x = floorf((frame.size.width - kAlertViewWidth) * 0.5);
    frame.size.width = kAlertViewWidth;
    
    _view = [[UIView alloc] initWithFrame:frame];
    _view.backgroundColor=[UIColor whiteColor];
    _blocks = [[NSMutableArray alloc] init];
    _height = kAlertViewBorder + kAlertViewYPadding;
    
    if (attributeTitle && attributeTitle.length!=0)
    {
      
      CGSize size = [attributeTitle boundingRectWithSize:CGSizeMake(kAlertViewContentWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
      
      UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewContentStartX, _height, kAlertViewContentWidth, size.height)];
      labelView.font = titleFont;
      labelView.numberOfLines = 0;
      labelView.lineBreakMode = NSLineBreakByWordWrapping;
      labelView.textColor = kAlertViewTitleTextColor;
      labelView.backgroundColor = [UIColor clearColor];
      labelView.textAlignment = NSTextAlignmentCenter;
      labelView.font = kAlertViewTitleFont;
      labelView.attributedText = attributeTitle;
      [_view addSubview:labelView];
      _height += size.height + kAlertViewYPadding;
    }
    
    if (messageAttributed && messageAttributed.length!=0)
    {
      
      CGSize size = [messageAttributed boundingRectWithSize:CGSizeMake(kAlertViewContentWidth - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
      
      CGFloat textViewHeight;
      if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        textViewHeight = size.height;
        
      }else {
        
        textViewHeight = size.height+12;
        
      }
      
      UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(kAlertViewContentStartX, _height, kAlertViewContentWidth, textViewHeight)];
      textView.font = messageFont;
      if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        textView.textContainerInset = UIEdgeInsetsZero;
        
      }else {
        
        textView.contentInset = UIEdgeInsetsMake(-8, -6, 0, 0);
        
      }
      textView.textColor = kAlertViewMessageTextColor;
      textView.backgroundColor = [UIColor clearColor];
      textView.textAlignment = NSTextAlignmentCenter;
      textView.attributedText = messageAttributed;
      textView.editable = NO;
      
      if (textViewHeight < kTextViewMaxHeight) {
        
        textView.scrollEnabled=NO;
        
        
      }else {
        
        textView.scrollEnabled = YES;
        textViewHeight = kTextViewMaxHeight;
        
      }
      
      CGRectSet(textView, -1, -1, -1, textViewHeight);
      
      [_view addSubview:textView];
      _height += textViewHeight + kAlertViewYPadding;
    }
    
    
    _vignetteBackground = NO;
    
    _titleString = [[attributeTitle string] copy];
    _messageString = [[messageAttributed string] copy];
  }
  
  return self;

}

- (id)initWithTitleAttributed:(NSAttributedString *)attributeTitle messageAttributed:(NSAttributedString *)messageAttributed showDismissButton:(BOOL)show {
	
	_showDismissButton = show;
	
	return [self initWithTitleAttributed:attributeTitle messageAttributed:messageAttributed];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message showDismissButton:(BOOL)show
{
    _showDismissButton = show;
    return [self initWithTitle:title message:message];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message notReport:(BOOL)notReportToZhuge{
  
  if ((self = [super init]))
  {
    _notReportToZhuge = notReportToZhuge;
    
    UIWindow *parentView = [BlockBackground sharedInstance];
    CGRect frame = parentView.bounds;
    frame.origin.x = floorf((frame.size.width - kAlertViewWidth) * 0.5);
    frame.size.width = kAlertViewWidth;
    
    _view = [[UIView alloc] initWithFrame:frame];
    _view.backgroundColor=[UIColor whiteColor];
    _blocks = [[NSMutableArray alloc] init];
    _height = kAlertViewBorder + kAlertViewYPadding;
    
    if (title && title.length!=0)
    {
      
      CGSize size = [title boundingRectWithSize:CGSizeMake(kAlertViewContentWidth, 1000)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:titleFont}
                                        context:nil].size;
      
      UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewContentStartX, _height, kAlertViewContentWidth, size.height)];
      labelView.font = titleFont;
      labelView.numberOfLines = 0;
      labelView.lineBreakMode = NSLineBreakByWordWrapping;
      labelView.textColor = kAlertViewTitleTextColor;
      labelView.backgroundColor = [UIColor clearColor];
      labelView.textAlignment = NSTextAlignmentCenter;
      labelView.font = kAlertViewTitleFont;
      labelView.text = title;
      [_view addSubview:labelView];
      _height += size.height + kAlertViewYPadding;
      
    }
    
    if (message && message.length!=0)
    {
      
      CGSize size = [message boundingRectWithSize:CGSizeMake(kAlertViewContentWidth - 16, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:messageFont}
                                          context:nil].size;
      
      CGFloat textViewHeight;
      if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        textViewHeight = size.height;
        
      }else {
        
        textViewHeight = size.height+12;
        
      }
      
      UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(kAlertViewContentStartX, _height, kAlertViewContentWidth, textViewHeight)];
      textView.font = messageFont;
      if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        textView.textContainerInset = UIEdgeInsetsZero;
        
      }else {
        
        textView.contentInset = UIEdgeInsetsMake(-8, -6, 0, 0);
        
      }
      textView.textColor = kAlertViewMessageTextColor;
      textView.backgroundColor = [UIColor clearColor];
      textView.textAlignment = NSTextAlignmentCenter;
      textView.text = message;
      textView.editable = NO;
      
      if (textViewHeight < kTextViewMaxHeight) {
        
        textView.scrollEnabled=NO;
        
        
      }else {
        
        textView.scrollEnabled = YES;
        textViewHeight = kTextViewMaxHeight;
        
      }
      
      CGRectSet(textView, -1, -1, -1, textViewHeight);
      
      [_view addSubview:textView];

      _height += textViewHeight + kAlertViewYPadding;
    }
    
    _vignetteBackground = NO;
    
    _titleString = [title copy];
    _messageString = [message copy];
  }
  
  return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message 
{
  return [self initWithTitle:title message:message notReport:NO];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public
- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block 
{
  [_blocks addObject:[NSArray arrayWithObjects:
                      block ? [block copy] : [NSNull null],
                      title,
                      @"yellow",
                      nil]];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block
{
  [_blocks insertObject:[NSArray arrayWithObjects:
                      block ? [block copy] : [NSNull null],
                      title,
                      @"gray",
                      nil] atIndex:0];
}

- (NSString *)buttonTitleOfIndex:(NSInteger)buttonIndex {
  
  if (buttonIndex <0) {
    return @"dismissButton";
  }
  
  if ([[_blocks objectAtIndex:buttonIndex] count] < 2) {
    return @"";
  }
  
  return (NSString *)[[_blocks objectAtIndex:buttonIndex] objectAtIndex:1];
}

#pragma mark - 
- (UIButton *)buttonWithTitle:(NSString *)title backgroudColor:(NSString *)color frame:(CGRect)frame {

  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = frame;
  button.titleLabel.font = buttonFont;
  
  if (IOS_LESS_THAN_6) {
#pragma clan diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    button.titleLabel.minimumFontSize = 10;
#pragma clan diagnostic pop
  }
  else {
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleLabel.adjustsLetterSpacingToFitWidth = YES;
    button.titleLabel.minimumScaleFactor = 0.1;
  }
  
  button.titleLabel.textAlignment = NSTextAlignmentCenter;
  button.backgroundColor = [UIColor clearColor];
  
  UIColor *btnTitleColor;
  if ([color isEqualToString:@"gray"]) {
    
    btnTitleColor = UIColorFromRGB(0x929292);
  }else {
    
    btnTitleColor = [UIColor orangeColor];
    
  }
  
  [button setTitleColor:btnTitleColor forState:UIControlStateNormal];
  [button setTitle:title forState:UIControlStateNormal];
  button.accessibilityLabel = title;
  
  [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
  
  return button;
}

- (void)show
{
  for (UIView *BlockView in [BlockBackground sharedInstance].subviews) {
    
    for (UIView *subview in BlockView.subviews) {
      
      CLog(@"%@", subview);
			
      if ([subview isKindOfClass:[UITextField class]]) {
        
        [subview resignFirstResponder];
      }
    }
  }
  
  if (_blocks.count == 0) {

    // 没有按钮，增加点击按钮关闭和点击背景关闭功能
    [self setCancelButtonWithTitle:@"知道了" block:nil];
    UIView *seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, _height+kAlertViewYPadding, kAlertViewWidth, kAlertViewSeperateLineHeight)];
    seperateLine.backgroundColor = kAlertViewSeperateLineColor;
    [_view addSubview:seperateLine];
    
    NSArray *block = [_blocks objectAtIndex:0];
    NSString *title = [block objectAtIndex:1];
    NSString *color =@"yellow";
    
    UIButton *btn = [self buttonWithTitle:title backgroudColor:color frame:CGRectMake(kAlertViewContentStartX - kAlertViewButtonShadowX, _height+kAlertViewYPadding, kAlertViewContentWidth+2*kAlertViewButtonShadowX, kAlertButtonHeight)];
    [_view addSubview:btn];
    
    _height += kAlertButtonHeight;
    _height += kAlertViewYPadding;
  
  }else if (_blocks.count==2) {
    
    // 分割线
    UIView *XseperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, _height+kAlertViewYPadding, kAlertViewWidth, kAlertViewSeperateLineHeight)];
    XseperateLine.backgroundColor = kAlertViewSeperateLineColor;
    [_view addSubview:XseperateLine];
    
    UIView *YseperateLine = [[UIView alloc]initWithFrame:CGRectMake(130, _height+kAlertViewYPadding, kAlertViewSeperateLineHeight, 50)];
    YseperateLine.backgroundColor = kAlertViewSeperateLineColor;
    [_view addSubview:YseperateLine];
    
    if (_showDismissButton) {
      
      [self addDismissButton];
    }
      
    // 两个按钮的情况下，灰白按钮按1：2分享一行空间
    CGFloat startX = 0;
		
    for (int i = 0; i < 2; i++) {
      
			NSArray *block = [_blocks objectAtIndex:i];
			
			NSString *title = [block objectAtIndex:1];
			
			NSString *color = [block objectAtIndex:2];

      CGFloat width = (kAlertViewWidth - kAlertViewBorder)/2;
			
      UIButton *btn = [self buttonWithTitle:title backgroudColor:color frame:CGRectMake(startX, _height+kAlertViewYPadding, width, kAlertButtonHeight)];
			
      btn.tag = i+1;
      
      [_view addSubview:btn];
      
      startX += width + kAlertViewButtonPadding;
    }
		
    _height += kAlertButtonHeight + kAlertViewYPadding;
    
  }
  if (_height < background.size.height)
  {
      CGFloat offset = background.size.height - _height;
      _height = background.size.height;
      CGRect frame;
      for (NSUInteger i = 0; i < _blocks.count; i++)
      {
          UIButton *btn = (UIButton *)[_view viewWithTag:i+1];
          frame = btn.frame;
          frame.origin.y += offset;
          btn.frame = frame;
      }
  }

  CGRect frame = _view.frame;
  frame.origin.y = - _height;
  frame.size.height = _height;
  _view.frame = frame;
  _view.layer.cornerRadius = 3;
  
  UIImageView *modalBackground = [[UIImageView alloc] initWithFrame:_view.bounds];
  modalBackground.image = background;
  modalBackground.contentMode = UIViewContentModeScaleToFill;
  [_view insertSubview:modalBackground atIndex:0];
  
  if (_backgroundImage)
  {
      [BlockBackground sharedInstance].backgroundImage = _backgroundImage;
      _backgroundImage = nil;
  }
  [BlockBackground sharedInstance].vignetteBackground = _vignetteBackground;
  [[BlockBackground sharedInstance] addToMainWindow:_view];
  [[BlockBackground sharedInstance] makeKeyWindow];

  __block CGPoint center = _view.center;
  center.y = floorf([BlockBackground sharedInstance].bounds.size.height * 0.5) - kAlertViewBounce;
  _view.center = center;
  [UIView animateWithDuration:0.3
                        delay:0.0
                      options:UIViewAnimationCurveEaseOut
                   animations:^{
                       [BlockBackground sharedInstance].alpha = 1.0f;

                   } 
                   completion:^(BOOL finished) {
                       [UIView animateWithDuration:0.15
                                             delay:0.0
                                           options:0
                                        animations:^{
                                            center.y += kAlertViewBounce;
                                            _view.center = center;
                                        } 
                                        completion:^(BOOL finished) {
                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlertViewFinishedAnimations" object:nil];
                                        }];
                   }];
	
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated 
{
    if (animated)
    {
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options:UIViewAnimationCurveEaseIn
                         animations:^{

                              [[BlockBackground sharedInstance] reduceAlphaIfEmpty];
                         }
                          completion:^(BOOL finished) {
                            
                              [[BlockBackground sharedInstance] removeView:_view];
													
														_view = nil;
                            
                              if (buttonIndex >= 0 && buttonIndex < [_blocks count])
                              {
                                id obj = [[_blocks objectAtIndex: buttonIndex] objectAtIndex:0];
                                if (![obj isEqual:[NSNull null]])
                                {
                                  ((void (^)())obj)();
                                }
                              }
                         }
         ];
    }
    else
    {
        [[BlockBackground sharedInstance] removeView:_view];
			
				_view = nil;
      
        if (buttonIndex >= 0 && buttonIndex < [_blocks count])
        {
          id obj = [[_blocks objectAtIndex: buttonIndex] objectAtIndex:0];
          if (![obj isEqual:[NSNull null]])
          {
            ((void (^)())obj)();
          }
        }
    }
}

- (void)addDismissButton
{
  
    UIWindow *parentView = [BlockBackground sharedInstance];
    CGRect frame = parentView.bounds;
    frame.origin.x = floorf((frame.size.width - kAlertViewWidth) * 0.5);
    frame.size.width = kAlertViewWidth;
  
    _dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [[BlockBackground sharedInstance] addGestureRecognizer:_dismissTap];
  
    UIImage *closeBtnImage = [UIImage imageNamed:@"gy_Newcloseicon"];
    UIImageView *closeBtnView = [[UIImageView alloc]initWithFrame:CGRectMake(12,12,closeBtnImage.size.width, closeBtnImage.size.height)];
    UIImageView *closeBigBtnView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,closeBtnImage.size.width+24, closeBtnImage.size.height+24)];
    [closeBtnView setImage:closeBtnImage];
    closeBtnView.backgroundColor = [UIColor clearColor];
    [_view addSubview:closeBigBtnView];
    [_view addSubview:closeBtnView];
    _view.clipsToBounds = NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Action

- (void)buttonClicked:(id)sender 
{
  NSUInteger buttonIndex = [sender tag] - 1;

  
  [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (void)tapped:(UITapGestureRecognizer *)tap {

  [[BlockBackground sharedInstance] removeGestureRecognizer:tap];
  [self dismissWithClickedButtonIndex:-1 animated:YES];
}

#pragma mark - 
- (void)dealloc {
  
  if (_dismissTap) {
    
    [[BlockBackground sharedInstance]removeGestureRecognizer:_dismissTap];
    _dismissTap = nil;
  }
}
@end
