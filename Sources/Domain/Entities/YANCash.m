//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import "YANCash.h"
#import "NSException+POSRx.h"


@implementation YANCash {

}
- (instancetype)initWithCashCount:(float)count
                         currency:(nonnull NSString *)currency {

    POSRX_CHECK_EX(currency.length > 0, @"отсутствует название валюты");

    POSRX_CHECK(count >= 0);
    
    if (self = [super init]) {
        _count = count;
        _currency = [currency copy];
    }
    return self;
}

POSRX_DEADLY_INITIALIZER(init);

@end