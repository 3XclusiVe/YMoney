//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import "YANBalance.h"
#import "YANCash.h"


@implementation YANBalance {

}
- (instancetype)initWithCash:(YANCash *)startCash {
    if (startCash == nil) {
        @throw [NSException
                exceptionWithName:NSInternalInconsistencyException
                           reason:@"precondition failed"
                         userInfo:nil];
    }
    if (self = [super init]) {
        _currentBalance = startCash;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _currentBalance = [[YANCash alloc] initWithCashCount:0
                                                 andCurrency:@"P"];
    }
    return self;
}

@end