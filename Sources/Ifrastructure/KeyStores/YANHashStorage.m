//
//  YANHashStorage.m
//  YMoney
//
//  Created by Дмитрий on 09.12.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANHashStorage.h"
#import "YANKeyStorage.h"
#import "YMAAccountInfoModel.h"
#import "YMAHistoryOperationModel.h"


@implementation YANHashStorage {
    YANKeyStorage * _keyStorage;
}

NSString const *accountInfoKey = @"accountInfo";
NSString const *operationHistoryKey = @"operationHistory";

+(instancetype) sharedInstance {
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

-(instancetype) initUniqueInstance {
    if(self = [super init]) {
        _keyStorage = [[YANKeyStorage alloc] init];
    }
    return self;
}

-(void) saveAccountInfo:(YMAAccountInfoModel*) accountInfo {
    [_keyStorage saveData:accountInfo withKey:accountInfoKey];
}

-(YMAAccountInfoModel *) loadAccountInfo {
    return [_keyStorage loadData:accountInfoKey];
}

-(void) saveOperationHistory:(NSArray<YMAHistoryOperationModel*> *) operations {
    [_keyStorage saveData:operations withKey:operationHistoryKey];
}

-(NSArray<YMAHistoryOperationModel*> *) loadOperationHistory {
    return [_keyStorage loadData:operationHistoryKey];
}

-(void) cleanStorage {
    [_keyStorage cleanKeyStorage];
}

@end
