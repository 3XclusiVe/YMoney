//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YANCashOperation;


@interface YANOperationHistory : NSObject

- (void)addOperation:(YANCashOperation *)Operation;
@end