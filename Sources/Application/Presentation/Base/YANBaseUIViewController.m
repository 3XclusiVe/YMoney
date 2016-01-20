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
#import "YANHashStorage.h"

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
    NSString* token = [[YANHashStorage sharedInstance] loadAccessToken];
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
    NSString * storyboardName = @"Main";
    NSString * viewControllerID = @"Auth";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    YANBaseUIViewController * controller = (YANBaseUIViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void) onTokenAccepted {
    
}

-(void) onReceiveToken:(NSString *)accessToken {
    
}

-(void) onReceiveLastOperations:(NSArray *)operations {
    
}

-(void) onReceiveNextOperations:(NSArray *)operations {
    
}

# pragma mark - private methods

-(NSString *)loadTokenFromStorage {
    YANKeyStorage* keyStorage = [[YANKeyStorage alloc] initForTest];
    NSString* token = [keyStorage loadData:@"Token"];
    return token;
}


@end
