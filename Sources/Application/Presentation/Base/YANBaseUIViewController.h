//
//  YANBaseUIViewController.h
//  YMoney
//
//  Created by Дмитрий on 26.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMAAccountInfoModel;
@class YANYandexMoneyServer;

@protocol YANYandexServerObserver <NSObject>

-(void) onInternetConnectionLost;

-(void) onReceiveAccountInfo:(YMAAccountInfoModel *)accountInfo;

-(void) onNeedToRefreshToken;

-(void) onReceiveToken:(NSString *)accessToken;

-(void) onTokenAccepted;

@end

@interface YANBaseUIViewController : UIViewController <YANYandexServerObserver>

@property (strong, nonatomic) YANYandexMoneyServer* yandexMoneyServer;

@end

