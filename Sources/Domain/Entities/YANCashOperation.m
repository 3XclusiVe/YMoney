//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import "YANCashOperation.h"
#import "YANCash.h"
#import "NSException+POSRx.h"


@implementation YANCashOperation {

}

- (instancetype)initOperationWithDate:(nonnull NSDate *)operationDate
                          description:(nonnull NSString *)operationDescription
                                 cash:(nonnull YANCash *)operationSum
                            direction:(OperationDirection)operationDirection {
    
    POSRX_CHECK_EX(operationDate != nil, @"отсутствует дата операции");
    
    POSRX_CHECK_EX(operationDescription != nil, @"отсутствует описание операции");
    
    POSRX_CHECK_EX(operationSum != nil, @"отсутствует сумма операции");
    
    if (self = [super init]) {
        _operationDate = [operationDate copy];
        _operationDescription = [operationDescription copy];
        _operationSum = operationSum;
        _operationDirection = operationDirection;
    }

    return self;
}

POSRX_DEADLY_INITIALIZER(init);

@end