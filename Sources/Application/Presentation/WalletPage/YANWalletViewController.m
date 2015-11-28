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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property(weak, nonatomic) IBOutlet UILabel *balance;

@property(weak, nonatomic) IBOutlet UITabBarItem *walletButton;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@end

@implementation YANWalletViewController {
    UIRefreshControl *_refreshControl;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRefreshController:@selector(responceAccountInfo)];
}

- (void)viewDidAppear:(BOOL)clause {
    [super viewDidAppear:clause];
    [self responceAccountInfo];
    [self makeAvatarRounded];
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

#pragma mark - Logic methods

- (void)updateAccountInfoPresentation:(YMAAccountInfoModel *)accountInfo {
    self.userNameLabel.text = accountInfo.account;
    self.balance.text = accountInfo.balance;
}

- (void)onReceiveAccountInfo:(YMAAccountInfoModel *)accountInfo {
    [_refreshControl endRefreshing];
    [self updateAccountInfoPresentation:accountInfo];
}

- (void)responceAccountInfo {
    [self.yandexMoneyServer performAccountInfoRequest];
}

- (void)onInternetConnectionLost {
    YMAAccountInfoModel *accountInfo = [self loadDataFromStorage];
    [self updateAccountInfoPresentation:accountInfo];
    [_refreshControl endRefreshing];
}

- (YMAAccountInfoModel *)loadDataFromStorage {
    YANKeyStorage *keyStorage = [[YANKeyStorage alloc] initForTest];
    YMAAccountInfoModel *accountInfo = [keyStorage loadData:@"Account"];

    return accountInfo;
}

#pragma mark - Presentation methods

-(void) makeAvatarRounded {
    _avatar.layer.cornerRadius = _avatar.frame.size.width / 2;
    _avatar.layer.masksToBounds = YES;
}

-(void) addRefreshController:(SEL)selector {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:_refreshControl];
}

@end
