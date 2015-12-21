#ifndef BlockUI_nova_h
#define BlockUI_nova_h

// Action Sheet constants

#define kActionSheetBounce         20
#define kActionSheetBorder         22
#define kActionSheetButtonHeight   45
#define kActionSheetTopMargin      22

#define kActionSheetNormalButtonPadding 8
#define kActionSheetCancelButtonPadding 22

#define kActionSheetTitleFont           [UIFont systemFontOfSize:18]
#define kActionSheetTitleTextColor      [UIColor blackColor]


// Alert View constants

#define kAlertViewBounce         20
#define kAlertViewBorder         3
#define kAlertViewTitleMargin    20
#define kAlertButtonHeight       50
#define kAlertViewButtonPadding  0
#define kAlertViewButtonShadowX  5

#define kAlertViewWidth                 260
#define kAlertViewXPadding 22
#define kAlertViewYPadding 18
#define kAlertViewContentWidth (kAlertViewWidth - 2*kAlertViewBorder - 2*kAlertViewXPadding)
#define kAlertViewContentStartX (kAlertViewBorder + kAlertViewXPadding)

#define kAlertViewSeperateLineColor UIColorFromRGB(0xc5c5c5)
#define kAlertViewSeperateLineHeight 0.5

#define kAlertViewTitleFont             [UIFont boldSystemFontOfSize:22]
#define kAlertViewTitleTextColor        [UIColor blackColor]
#define kAlertViewTitleShadowColor      [UIColor blackColor]
#define kAlertViewTitleShadowOffset     CGSizeMake(0, -1)

#define kAlertViewMessageFont           [UIFont systemFontOfSize:15]
#define kAlertViewMessageTextColor      [UIColor blackColor]
#define kAlertViewMessageShadowColor    [UIColor blackColor]
#define kAlertViewMessageShadowOffset   CGSizeMake(0, 0)

#define kAlertViewButtonFont            [UIFont boldSystemFontOfSize:16]
#define kAlertViewButtonTextColor       [UIColor whiteColor]
#define kAlertViewButtonShadowColor     [UIColor blackColor]
#define kAlertViewButtonShadowOffset    CGSizeMake(0, -1)

#define kAlertViewBackground            @"tc_deepgraybg.png"
#define kAlertButtonPrefix              @"tc_"

#define kHintPopUpViewBackground        @"tc_deepgraybg.png"
#define kHintPopButtonPrefix            @"tc_"
#define kHintPopUpViewBackgroundCap     10
#define kHintPopUpViewWidth             280
#define kHintPopUpViewDefaultHeight     230
#define kHintPopUpViewTitleTextColor    [UIColor colorWithWhite:163/255.0 alpha:1.0]


#endif
