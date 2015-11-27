//
//  YANWalletViewController.m
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANWalletViewController.h"

#import "YANKeyStorage.h"
#import "YMAAccountInfoModel.h"
#import "YANYandexMoneyServer.h"


@interface YANWalletViewController ()

@property(weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property(weak, nonatomic) IBOutlet NSLayoutConstraint *balanceLabel;
@property(weak, nonatomic) IBOutlet UILabel *balance;

@property(weak, nonatomic) IBOutlet UITabBarItem *walletButton;

@end

@implementation YANWalletViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)clause {
    [super viewDidAppear:clause];
    [self responceAccountInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private methods

- (void)updateAccountInfoPresentation:(YMAAccountInfoModel *)accountInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.userNameLabel.text = accountInfo.account;
        self.balance.text = accountInfo.balance;
    });
}

- (void)onReceiveAccountInfo:(YMAAccountInfoModel *)accountInfo {
    [self updateAccountInfoPresentation:accountInfo];
}

- (void)responceAccountInfo {
    [self.yandexMoneyServer performAccountInfoRequest];
}

- (void)onInternetConnectionLost {
    YMAAccountInfoModel *accountInfo = [self loadDataFromStorage];
    [self updateAccountInfoPresentation:accountInfo];
}

- (YMAAccountInfoModel *)loadDataFromStorage {
    YANKeyStorage *keyStorage = [[YANKeyStorage alloc] initForTest];
    YMAAccountInfoModel *accountInfo = [keyStorage loadData:@"Account"];

    return accountInfo;
}


@end
