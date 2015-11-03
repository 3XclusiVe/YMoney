//
//  KeyStorage.m
//  YMoney
//
//  Created by Дмитрий on 04.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "KeyStorage.h"

@implementation KeyStorage

- (instancetype)initWithAccessToken:(nonnull NSString *) accessToken {
    
    if (!(accessToken.length > 0)) {
        @throw [NSException
                exceptionWithName:NSInternalInconsistencyException
                reason:@"precondition failed"
                userInfo:nil];
    }
    if (self = [super init]) {
        _accessToken = [accessToken copy];
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