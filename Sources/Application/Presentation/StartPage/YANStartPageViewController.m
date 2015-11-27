//
//  YANStartPageViewController.m
//  HomeWork1
//
//  Created by Дмитрий on 12.10.15.
//  Copyright (c) 2015 DMA. All rights reserved.
//


#import "YANStartPageViewController.h"
#import "YANAuthorizationViewController.h"

#import "YANYandexMoneyServer.h"
#import "YANKeyStorage.h"


@interface YANStartPageViewController ()  <AuthorizationViewControllerDelegate>

- (void)authorizationViewController:(YANAuthorizationViewController *)viewController didChooseValue:(CGFloat)value;

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (weak, nonatomic) IBOutlet UIButton *createWalletButton;

- (IBAction)enterButtonTouch:(id)sender;

- (IBAction)createWalletButtonTouch:(id)sender;

@end

@implementation YANStartPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* accessToken = [self loadTokenFromStorage];
    [YANYandexMoneyServer checkAccessToken:accessToken forObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)enterButtonTouch:(id)sender {
    NSLog(@"enter button touched");
}


- (IBAction)createWalletButtonTouch:(id)sender {
    NSLog(@"create wallet button touched");
}

- (void)onInternetConnectionLost {
    [self performSegueWithIdentifier:@"goToWalletPage" sender:self];
}

- (void)onReceiveAccountInfo:(YMAAccountInfoModel *)accountInfo {

}

- (void)onNeedToRefreshToken {

}

- (void)onReceiveToken:(NSString *)accessToken {

}

-(void) onTokenAccepted {
    [self performSegueWithIdentifier:@"goToWalletPage" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"shwAuthorizationView"]){
    
        YANAuthorizationViewController *controller = segue.destinationViewController;
        
        controller.delegate = self;

    }
    
}

// Implement the delegate methods for AuthorizationViewControllerDelegate
- (void)authorizationViewController:(YANAuthorizationViewController *)viewController didChooseValue:(CGFloat)value {
    
    [self.enterButton setTitle:@"Попробовать войти еще раз" forState:UIControlStateNormal];
    
    // ...then dismiss the child view controller
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)loadTokenFromStorage {
    YANKeyStorage* keyStorage = [[YANKeyStorage alloc] initForTest];
    NSString* token = [keyStorage loadData:@"Token"];
    return token;
}

@end