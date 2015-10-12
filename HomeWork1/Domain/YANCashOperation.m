//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import "YANCashOperation.h"
#import "YANCash.h"

@implementation YANCashOperation {

}

- (instancetype)initOperationWithDate:(nonnull NSDate *)operationDate
                      WithDescription:(nonnull NSString *)operationDescription
                             WithCash:(nonnull YANCash *)operationSum
                        WithDirection:(int)operationDirection {

    if ((operationDate == nil) || (operationDescription == nil) ||
            (operationSum == nil) || (operationDirection == nil)) {
        @throw [NSException
                exceptionWithName:NSInternalInconsistencyException
                           reason:@"precondition failed"
                         userInfo:nil];
    }
    if (self = [super init]) {
        _operationDate = [operationDate copy];
        _operationDescription = [operationDescription copy];
        _operationSum = operationSum;
        _operationDirection = operationDirection;
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