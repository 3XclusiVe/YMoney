//
//  YANKeyStorage.m
//  YMoney
//
//  Created by Дмитрий on 04.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANKeyStorage.h"
#import "NSException+POSRx.h"

@implementation YANKeyStorage

- (nonnull instancetype)initWithAccessToken:(nonnull NSString *)accessToken {

    POSRX_CHECK_EX(accessToken.length > 0, @"отсутствует  токен");

    if (self = [super init]) {
        _accessToken = [accessToken copy];
    }

    return self;
}

POSRX_DEADLY_INITIALIZER(init);

@end