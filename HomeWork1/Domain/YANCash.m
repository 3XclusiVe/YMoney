//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import "YANCash.h"


@implementation YANCash {

}
- (instancetype)initWithCashCount:(float)count andCurrency:(NSString *)currency {

    /// Обязательно должно присутствовать название валюты.
    if (!(currency.length > 0)) {
        @throw [NSException
                exceptionWithName:NSInternalInconsistencyException
                           reason:@"precondition failed"
                         userInfo:nil];
    }

    /// Количесвто валюты не может быть отрицательным.
    if (count < 0) {
        @throw [NSException
                exceptionWithName:NSInternalInconsistencyException
                           reason:@"precondition failed"
                         userInfo:nil];
    }
    if (self = [super init]) {
        _count = count;
        _currency = [currency copy];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException
            exceptionWithName:NSInternalInconsistencyException
            reason:@"deadly init"
            userInfo:nil];
    return nil;
}

@end