//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import "YANBalance.h"
#import "YANCash.h"
#import "NSException+POSRx.h"


@implementation YANBalance {

}
- (instancetype)initWithCash:(YANCash *)startCash {
    
    POSRX_CHECK_EX(startCash != nil, @"отсутствует значение баланса");
    
    if (self = [super init]) {
        _currentBalance = startCash;
    }
    return self;
}

POSRX_DEADLY_INITIALIZER(init);

@end