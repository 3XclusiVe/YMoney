//
//  YANKeyStorage.m
//  YMoney
//
//  Created by Дмитрий on 04.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANKeyStorage.h"
#import "NSException+POSRx.h"

#import "YMAAccountInfoModel.h"

@implementation YANKeyStorage {
    NSMutableDictionary *store;
}

-(instancetype) init {
    if(self = [super init]) {
        store = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)loadData:(NSString *)key {
    POSRX_CHECK(key);
    if (!store) {
        store = [[NSMutableDictionary alloc] init];
    }
    id data = [store objectForKey:key];
    
    if(data == nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        data = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:key]];
    }
    
    return data;
}

- (BOOL)saveData:(id)data withKey:(NSString *)key {

    POSRX_CHECK(key);
    POSRX_CHECK(data);

    [store setObject:data forKey:key];
    NSData* archivedData = [NSKeyedArchiver archivedDataWithRootObject:data];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:archivedData forKey:key];
    [defaults synchronize];

    return YES;
}

- (BOOL)deleteDataWithKey:(NSString *)key {

    POSRX_CHECK(key);

    [store removeObjectForKey:key];

    return YES;
}

- (BOOL)cleanKeyStorage {

    [store removeAllObjects];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];

    return YES;
};


#pragma mark - Debug functions

static NSString *const _defaultToken = @"41001773456006.C561C4B1E9545B58E724FFA6DE0D6CF8B73482A87D90D0BE94010E1BB301E88074D262E51CC801177388E8C6B4FE4A3905EB97341F3266B3BB0ECEE5123A01B3734DC89F6E9416872B637A0A39EE823EFE39A1D5770DAB9B8E0998ED6937D2346F05C1876A223349E133CC20DF49D864965DE5807F23327E7C19964B51F09BAA";

- (instancetype)initForTest {
    
    if (self = [super init]) {
        store = [[NSMutableDictionary alloc] init];
        [store setObject:_defaultToken forKey:@"Token"];
        
        YMAAccountInfoModel *account = [YMAAccountInfoModel accountInfoWithAccount:@"105043"
                                                                           balance:@"109"
                                                                          currency:@"P"
                                                                     accountStatus:0
                                                                       accountType:0
                                                                            avatar:nil
                                                                    balanceDetails:nil
                                                                       cardsLinked:nil
                                                                servicesAdditional:nil
                                                                      yamoneyCards:nil];
        
        [store setObject:account forKey:@"Account"];
        
        return self;
    }
    return self;
}

@end