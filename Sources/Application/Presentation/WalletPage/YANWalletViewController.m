//
//  YANWalletViewController.m
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANWalletViewController.h"

#import "YANHashStorage.h"
#import "YMAAccountInfoModel.h"
#import "YANYandexMoneyServer.h"
#import "UIKit+AFNetworking.h"
#import "YANUICircleImageView.h"

@interface YANWalletViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property(weak, nonatomic) IBOutlet UILabel *balance;

@property(weak, nonatomic) IBOutlet UITabBarItem *walletButton;

@property (weak, nonatomic) IBOutlet YANUICircleImageView *avatar;

@property (weak, nonatomic) IBOutlet UILabel *currency;

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
    self.currency.text = [self convertCurrencyCodeToSymbol:accountInfo.currency];
    [self.avatar setImageWithURL:accountInfo.avatar.url];
    [_refreshControl endRefreshing];
}

- (void)onReceiveAccountInfo:(YMAAccountInfoModel *)accountInfo {
    [self updateAccountInfoPresentation:accountInfo];
    [self saveDataToStorage:accountInfo];
}

- (void)responceAccountInfo {
    [self onInternetConnectionLost];
    [self.yandexMoneyServer performAccountInfoRequest];
}

- (void)onInternetConnectionLost {
    YMAAccountInfoModel *accountInfo = [self loadDataFromStorage];
    [self updateAccountInfoPresentation:accountInfo];
    
}
-(void) saveDataToStorage:(YMAAccountInfoModel *) account {
    [[YANHashStorage sharedInstance] saveAccountInfo:account];
}

- (YMAAccountInfoModel *)loadDataFromStorage {
    return [[YANHashStorage sharedInstance] loadAccountInfo];
}

#pragma mark - Presentation methods

-(void) addRefreshController:(SEL)selector {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:_refreshControl];
}

-(NSString*) convertCurrencyCodeToSymbol:(NSString *)currencyCode {
    
    NSLocale *locale = [NSLocale currentLocale];
    for (NSString *code in [NSLocale ISOCurrencyCodes]) {
        NSLog(@"%@ : %@", code, [locale displayNameForKey:NSLocaleCurrencyCode value:code]);
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:locale];
    
    NSString *currencySymbol = [NSString stringWithFormat:@"%@",[locale displayNameForKey:NSLocaleCurrencySymbol value:currencyCode]];
    NSLog(@"Currency Symbol : %@", currencySymbol);
    
    return currencySymbol;
}


@end













