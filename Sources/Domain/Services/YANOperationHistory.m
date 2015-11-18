//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import "YANOperationHistory.h"


@implementation YANOperationHistory {
    NSMutableArray *_operations;
}
- (instancetype)init {
    if (self = [super init]) {
        _operations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addOperation:(YANCashOperation *)Operation {

    if (Operation == nil) {
        @throw [NSException
                exceptionWithName:NSInternalInconsistencyException
                           reason:@"precondition failed"
                         userInfo:nil];
    }
    [_operations addObject:Operation];
}

@end