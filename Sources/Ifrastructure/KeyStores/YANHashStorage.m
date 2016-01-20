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

static NSString *const accountInfoKey = @"accountInfo";
static NSString *const operationHistoryKey = @"operationHistory";
static NSString *const accessTokenKey = @"Token";

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

-(void) saveAccessToken:(NSString *)token {
    [_keyStorage saveData:token withKey:accessTokenKey];
}

-(NSString*) loadAccessToken {
    return [_keyStorage loadData:accessTokenKey];
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

-(BOOL) isEmpty {
    YMAAccountInfoModel* accountInfo = [_keyStorage loadData:accountInfoKey];
    if(accountInfo == nil) {
        return YES;
    } else {
        return NO;
    }
}

@end
