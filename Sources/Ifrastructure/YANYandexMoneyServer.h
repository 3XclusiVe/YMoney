//
//  YANYandexMoneyServer.h
//  YMoney
//
//  Created by Дмитрий on 24.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YANYandexMoneyServer : NSObject

+ (void)checkAccessToken:(nonnull NSString *)accessToken;

- (nonnull instancetype)initWithAccessToken:(nonnull NSString *)accessToken;

- (void)performAccountInfoRequest;

- (void)performOperationHistoryRequest;

@end
