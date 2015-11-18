//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import "YANOperationHistory.h"
#import "NSException+POSRx.h"


@implementation YANOperationHistory {
    NSMutableArray *_operations;
}
- (instancetype)init {
    if (self = [super init]) {
        _operations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addOperation:(YANCashOperation *)operation {

    POSRX_CHECK_EX(operation != nil, @"отсутствует платежная операция");

    [_operations addObject:operation];
}

@end