//
//  GCDefines.h
//  GameChat
//
//  Created by Tom on 1/20/13.
//  Copyright (c) 2013 Ruoogle. All rights reserved.
//
#ifndef GAMECHAT_GCDEFINES_H
#define GAMECHAT_GCDEFINES_H

#pragma mark - App ID

#define kAppStoreID           @"637378147"
#define kAppStoreReviewLink [NSString stringWithFormat:@"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?id=%@&type=Purple+Software", kAppStoreID]

#pragma mark - SERVER SETTINGS

#ifdef DEBUG

  #define DEBUG_TEST_USER_SERVER_CALL_NAME  @""
  #define DEBUG_TEST_USER_ID                @""

#endif

//#define DAJI    1
//#define XIAOJI_1  1
//#define XIAOJI_2  1
//#define XIAOJI_3  1
//#define XIAOJI_4  1
#define XIAOJI_DEV  1

#define kFBEncryptKeyString           @"whatawonderfulda"
#define kXMPPHostPostfix              @"@ruoogle"
#define kXMPPChatRoomPostfix          @"@conference.ruoogle"
#define kXMPPCharmRoomPostfix         @"@charm.ruoogle"

#pragma mark - Audio
#define kRecordLength        60
#define kRecordLimitLength   1

#pragma mark - UI

#define kAppAnimationDuration 0.3f

#define kAppCornerRadius 1.5
#define kAppChatCornerRadius 4
#define kInputTextAreaCornerRadius 6

#define kAppSeperateLineSize 0.5
#define kAppSeperateLineColor (UIColorFromRGB(0xc5c5c5))

#define kAppToolbarTopPadding ((([[UIDevice currentDevice].systemVersion floatValue]) >= 7.0)?20:0)
#define kAppToolbarHeight                 (44+SCREEN_ORIGIN_Y + kAppToolbarTopPadding)
#define kTabBarHeight (49)
#define kAppToolbarHeightDiscardShadow    (kAppToolbarHeight)

#define kBigAvatarImageSize_Width         64
#define kBigAvatarImageSize_Height        64

#define kSmallAvatarImageSize_Width       44
#define kSmallAvatarImageSize_Height      44

#define kMiniAvatarImageSize_Width        24
#define kMiniAvatarImageSize_Height       24

#define kMyAvatarImageSize_Width          49
#define kMyAvatarIamgeSize_Height         49

#pragma mark - COLOR

#define kAppWhiteBackgroundColor  (UIColorFromRGB(0xefeff4))
#define kAppBackgroundColor       (UIColorFromRGB(0x2d2d2d))

#define kAppOrangeColor (UIColorFromRGB(0xfba81a))
#define kAppGrayColor (UIColorFromRGB(0x929292))
#define kAppBlackColor (UIColorFromRGB(0x373737))
#define kAppPinkColor (UIColorFromRGB(0xf77070))
#define kAppBlueColor (UIColorFromRGB(0x00aeef))

#define kAppNavigationBarItemColor [UIColor whiteColor]

#define kAppMessageUnreadColor  [UIColor colorWithWhite:0 alpha:0.1]
#define kAppMessageReadedColor  (UIColorFromRGB(0xa8d137))
#define kAppMessageUnreadRadius 3

#pragma mark - USER DEFAULT

#define kUDF_XmppServerHostName                     @"UDF_XMPP_Host_Name"         // xmpp 服务器的地址
#define kUDF_InstallDate                            @"UDF_InstallDate"            // 第一次运行的时间
#define kUDF_ReviewAsked                            @"UDF_ReviewAsked"            // 已经问过是不是要去app store review
#define kUDF_ServerDefaultAddress                   @"UDF_SERVER_ADDRESS_DEFAULT" // 用来作为调试
#define kUDF_SlotMachineDaily                       @"UDF_SlotMachine_Daily"      // 每日的老虎机是否第一次
#define kUDF_SlotMachineDailyCount                  @"UDF_SlotMachine_DailyCount" // 每日的老虎机玩的次数
#define kUDF_DeviceToken                            @"UDF_DeviceToken"            // 设备pushID
#define kUDF_ScoreViewShow                          @"UDF_ScoreViewShow"          // 分数显示的次数
#define kUDF_localNotifyUpgrade                     @"UDF_localNotifyUpgrade"     // 本地提示升级通知
#define kUDF_localVersionAndBuildInstalled          @"UDF_localVersionInstalled"  // 以前安装的版本号
#define kUDF_freeStyleMessageSnapTime               @"UDF_snapTime"               // 自由发显示图片的时间
#define kUDF_chatBGPath                             @"UDF_chatBGPath"             // 聊天室背景path
#define kUDF_bindingQQ_Or_Sina                      @"UDF_qqOrSina_binding"       // 绑定过新浪或者QQ
#define kUDF_timesForUnderFiveRoundAlert            @"UDF_timesForUnderFiveRoundAlert" // 少于五轮断开的当前提醒次数
#define kUDF_askForBinding                          @"UDF_askForBinding"          // 询问过绑定
#define kUDF_medalCount                             @"UDF_medalCount"             // 徽章数量 此版本临时使用
#define kUDF_gestureLockKey                         @"UDF_gestureLockKey"         // 手势锁定的密钥
#define kUDF_gestureLockIsOn                        @"UDF_gestureLockIsOn"        // 手势锁定是否开启
#define kUDF_gestureLockMail                        @"UDF_gestureLockMail"        // 手势锁找回邮箱
#define kUDF_gestureLockFakeKey                     @"UDF_gestureLockFakeKey"     // 手势锁定假密钥
#define kUDF_gestureFakeLockIsOn                    @"UDF_gestureFakeLockIsOn"    // 手势锁定假手势是否开启
#define kUDF_dontAlertSendGiftFunc                  @"UDF_dontAlertSendGiftFunc"  // 不提示聊天界面送礼物功能
#define kUDF_VCOPAuthData                           @"UDF_VCOPAuthData"           // 爱奇艺SDK授权信息
#define kUDF_hasShowNewMatchRule                    @"UDF_hasShowNewMatchRule"    // 是否显示过新的匹配规则

// 提醒设置
#define kUDF_hasVibrateForMatch                     @"UDF_hasVibrateForMatch"     // 被匹配到时是否振动提示
#define kUDF_hasSoundForMatch                       @"UDF_hasSoundForMatch"       // 被匹配到时是否响铃提示
#define kUDF_hasSoundForSending                     @"UDF_hasSoundForSending"     // 被匹配到时是否振动提示
#define kUDF_hasSoundForReceiving                   @"UDF_hasSoundForReceiving"   // 被匹配到时是否响铃提示
#define kUDF_hasSoundForNotifcation                 @"UDF_hasSoundForNotification"  // 下拉通知条是否有声音提示
#define kUDF_newFeatureAddRoom                      @"UDF_newFeatureAddRoom"          // 设置中增加游戏房间新功能
#define kUDF_newFeatureCollectQuestion              @"UDF_newFeatureCollectQuestion"  // 设置中征集真心话大冒险新功能
#define kUDF_newFeaturePushSetting                  @"UDF_newFeaturePushSetting"      // 设置中提醒设置新功能
#define kUDF_canShowGiftBroadcast                   @"UDF_canShowGiftBroadcast"       // 是否显示礼物广播条 added 1.6.2
#define kUDF_pushAlertSoundAllday                   @"UDF_pushAlertSoundAllday"       // 是否全天提醒 added 1.8.5


// 等待大厅背景音乐
#define kUDF_BGMusicInWaitingRoom                   @"UDF_BGMusicInWaitingRoom"     // 等待大厅背景音乐开关

//意见反馈部分
#define kUDF_userContactInfo                        @"UDF_userContactInfo"          // 记录用户输入过的联系方式
#define kUDF_lastFeedBackContent                    @"UDF_lastFeedBackContent"      // 记录用户上次反馈的内容，用于过滤重复内容

// 视频清晰度
#define kUDF_videoDefinitionType                    @"UDF_videoDefinitionType"      // 视频清晰度

#define kUDF_GetCheckInRewardsDate                  @"UDF_GetCheckInRewardsDate"    // 成功领取每日签到奖励的日期

// 记录秀场的一些数据 int 类型 32位从低位到高位依次记录如下数据 (1表示是，0表示否)
// 曾经开启过秀场(1<<0)，不再提醒计时器的作用(1<<1)，不再提示踢出用户的后果(1<<2)，不再提示拉黑用户的后果(1<<3)，不再提示离开秀场的后果(1<<4)
// 未使用(1<<5), 秀场faq页面不需要有开秀场按钮(1<<6)
#define kUDF_HostRoomPromptsShowOrNotShow                 @"UDF_HostRoomPromptsShowOrNotShow"

// 记录新手教程的一些数据 int类型 32位从低位到高位依次记录如下数据 (1表示显示过，0表示为显示）
// (1<<具体类型的教程(定义见GCCourse.h))  表示相应的教程是否显示过
#define kUDF_NewRegisterCourseFlags                       @"UDF_NewRegisterCourseFlags"

// 关于上传内容的警告提示框
#define kUDF_ALert_avatarReview                     @"UDF_ALert_avatarReview"    // 关于投降审核制度的提示框  

// 主持人创建秀场的时间
#define kUDF_CreateHostRoomDate                     @"UDF_CreateHostRoomDate"

// QRCode 上传到七牛的URL
#define kUDF_QRCode_QiNiuURL                          @"UDF_QRCode_QiNiuURL"

#define kUDF_RejectInviteMeDate                       @"UDF_RejectInviteMeDate"            // 第一次拒绝金币邀请的时间
#define kUDF_RejectInviteMeCount                      @"UDF_RejectInviteMeCount"           // 拒绝金币邀请的次数

// Match浮层的次数纪录
#define kUDF_MatchPopUpCount                          @"UDF_MatchPopUpCount"
#define kUDF_countForQueueReminderLocalNotify         @"UDF_countForQueueReminderLocalNotify"          // 询问过绑定

#define kUDF_countForQueueReminderHasUse @"UDF_countForQueueReminderHasUse"
#define kUDF_countForQueueReminderHasnotUse @"UDF_countForQueueReminderHasnotUse"
#define kUDF_countForQueueReminderHasnotUseAndCannotUse @"UDF_countForQueueReminderHasnotUseAndCannotUse"

// 新首页“发现”菜单中的提示 int类型 32位从低位到高位依次记录如下数据 (1表示显示过，0表示未显示）
#define kUDF_NewMainPageDiscoveryMenuIntro                      @"UDF_NewMainPageDiscoveryMenuIntro"

#define kUDF_alertOfLocationServiceDisabled           @"UDF_alertOfLocationServiceDisabled"

// 用户曾经和用户打过招呼
#define kUDF_sayHi                                    @"UDF_sayHi"

// login后记录用户UserID，以便判断是否是Apple review 人员的ID，正常从GCAppSharedData中去，会出现死循环
#define kUDF_UserID                                   @"UDF_UseID"

// 是否隐藏按兴趣匹配提示框
#define kUDF_HideInterestMatchPromptDialog            @"UDF_HideInterestMatchPromptDialog"

// 选排队频道是否需要滑动到尾再划回提示
#define kUDF_ChannelToMatchScrollHint            @"UDF_ChannelToMatchScrollHint"

// 微信参数记录
#define kUDF_WXParamDic                              @"UDF_WXParamDic"

#define kUDF_HasShowAnonymousCallTipsInOfflineChat   @"UDF_HasShowAnonymousCallTipsInOfflineChat"        // 是否已经在离线中显示了匿名通话的提示

/* 3.0.0 */
#define kUDF_sexChangeCount                         [NSString stringWithFormat:@"UDF_sexChangeCount_%lld", [[GCAppSharedData myself] userID]]
#define kUDF_isNotFirstUseDiscoveryFilter           [NSString stringWithFormat:@"UDF_isNotFirstUseDiscoveryFilter"]

/* 4.0.0 */
#define kUDF_hasShownRandomMatchHint                @"UDF_hasShownRandomMatchHint"
#define kUDF_hasShownAppIntro                       @"UDF_hasShownAppIntro"
#define kUDF_hasShownRandomNickAlert                @"UDF_hasShownRandomNickAlert"
#define kUDF_hasShownMallRedPointAlert              @"UDF_hasShownMallRedPointAlert"

/* 4.1.0 */
#define kUDF_showShakeAlert                         @"kUDF_showShakeAlert"
#define kUDF_showShakeDialogQty                     @"kUDF_showShakeDialogQty"

/* 4.1.1 */
#define kUDF_showOfflineNotif                       @"kUDF_showOfflineNotif"
#define kUDF_dontReceiveAutoGuiquanPost             @"kUDF_dontReceiveAutoGuiquanPost"

/* 4.1.2 */
#define kUDF_basicViewControllers                   @"kUDF_basicViewControllers"
#define kUDF_locationServiceAsk                     @"kUDF_locationServiceAsk"
#define kUDF_guiquanPostType                        @"kUDF_guiquanPostType"
#define kUDF_guiquanSimpleMode                      @"kUDF_guiquanSimpleMode"

/* 4.3.0 */
#define kUDF_pressRandomGiftButtonAlready           @"UDF_pressRandomGiftButtonAlready"
#define kUDF_hasClickGanLiaoMall                    @"UDF_hasClickGanLiaoMall"

/*4.4.1 */
#define kUDF_PlayGame_FirstFriend                    @"UDF_PlayGame_FirstFriend"
#define kUDF_Gold_Pay_Default												 @"UDF_Gold_Pay_Default"
#define kUDF_Gold_Pay_Not_LevelUp										 @"UDF_Gold_Pay_Not_LevelUp_New" //二次购买优化，是否不默认提高一档

/* 4.5 (5.0)*/
#define kUDF_PlayGame_WarningAboutSuperVipPlayer      @"UDF_PlayGame_WarningAboutSuperVipPlayer"
#define kUDF_PlayGame_WarningAboutNormalPlayer        @"UDF_PlayGame_WarningAboutNormalPlayer"
#define kUDF_DailyChatTipDay                          @"UDF_DailyChatTip_Date"                //女用户每天提醒聊真心话的日期
#define kUDF_Chat_FirstChatWarning										@"UDF_Chat_FirstChatWarning"
#define kUDF_Chat_StrickSetSuperVipBg                 @"UDF_Chat_StrickSetSuperVipBg"
#define kUDF_UserProfile_FirstIn_4_5_Tip              @"UDF_UserProfile_FirstIn_4_5_Tip"      // 真心话和私信合并提示
#define kUDF_ShowRoom_FirstIn_4_5_Tip                 @"UDF_ShowRoom_FirstIn_4_5_Tip"
#define kUDF_ModifyAvatarInSystemNotification         @"UDF_ModifyAvatarInSystemNotification" //系统消息设置头像的点击纪录
#define kUDF_SendGiftUnlockInGameChat									@"kUDF_SendGiftUnlockInGameChat"
#define kUDF_hasClickCharmMall                        @"UDF_hasClickCharmMall"  //女用户点击过魅力商城
#define kUDF_ChangeChatBackGroundBySVIP               @"UDF_ChangeChatBackGroundBySVIP" //更换聊天背景
#define kUDF_addSuperVipTip														@"UDF_addSuperVipTip"     //是否可以加上提示
#define kUDF_updateChatDatabase                       @"updateChatDatabase"     //是否需要更新4.5数据库
#define kUDF_requestAllGameChats                      @"kUDF_requestAllGameChats" // 是否可以进行清除服务器端所有的游戏的操作

/* 5.5 */
#define kUDF_FreeCoinShareList_5_5_Tip                @"UDF_FreeCoinShareList_5_5_Tip"
#define kUDF_BigUpdatePopMessage_5_5									@"kUDF_BigUpdatePopMessage_5_5"//5.5重大更行提示框
#define kUDF_UserProlileDetail_Click									@"kUDF_UserProlileDetail_Click"
#define kUDF_New_LoginUser_ChatGuide									@"kUDF_New_LoginUser_ChatGuide"
#define kUDF_FreeCoinTask_ChatBGChange                @"UDF_FreeCoinTask_ChatBGChange"  //更换背景任务  -1未完成，1完成
#define kUDF_FreeCoinTask_QuestionPageCheck           @"UDF_FreeCoinTask_QuestionPageCheck"   //查看常见问题任务



#endif
