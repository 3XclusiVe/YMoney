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

static NSString *const _defaultToken = @"41001773456006.96C072AA077C049B77CD8D8CC8325166E53CEB931647653CBCFD99712769E087BB2342CBE68649CFE08D65A7F9DD1DA6C979C3DD0DB964C2FA263E461D5FB5EEED1A21C8ECD5FD2E768FAB6116A1ED03BB9404C64775C483E9E7DA7B051425C970839CDEDEA9A5E97DDF0FDB83F30716EA0E16640661C9519D666F39B9199ACB";

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