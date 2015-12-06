//
//  YANBaseUIViewController.m
//  YMoney
//
//  Created by Дмитрий on 26.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANBaseUIViewController.h"
#import "YMAAccountInfoModel.h"
#import "YANYandexMoneyServer.h"
#import "YANKeyStorage.h"

@interface YANBaseUIViewController ()

@end

@implementation YANBaseUIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString* token = [self loadTokenFromStorage];
    self.yandexMoneyServer = [[YANYandexMoneyServer alloc] initWithAccessToken:token];
    [self.yandexMoneyServer subscribeOnEvents:self];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.yandexMoneyServer unSubscribeOnEvents:self];
}

- (void)onInternetConnectionLost {

}

- (void)onReceiveAccountInfo:(YMAAccountInfoModel *)accountInfo {

}

- (void)onNeedToRefreshToken {
    
}

-(void) onTokenAccepted {
    
}

-(void) onReceiveToken:(NSString *)accessToken {
    
}

# pragma mark - private methods

-(NSString *)loadTokenFromStorage {
    YANKeyStorage* keyStorage = [[YANKeyStorage alloc] initForTest];
    NSString* token = [keyStorage loadData:@"Token"];
    return token;
}


@end
