//
//  YANYandexMoneyServer.h
//  YMoney
//
//  Created by Дмитрий on 24.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YANYandexServerObserver;

@interface YANYandexMoneyServer : NSObject

-(void) subscribeOnEvents:(_Nonnull id<YANYandexServerObserver>) observer;

-(void) unSubscribeOnEvents:(_Nonnull id<YANYandexServerObserver>) observer;

-(nonnull instancetype)initWithAccessToken:(nonnull NSString *)accessToken;

-(void)performAccountInfoRequest;

-(void)performOperationHistoryRequest;

-(void)checkAccessToken;

+(void)checkAccessToken:(nonnull NSString *)accessToken forObserver:(_Nonnull id<YANYandexServerObserver>) observer;

@end
