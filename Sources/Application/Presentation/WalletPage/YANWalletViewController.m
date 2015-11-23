//
//  YANWalletViewController.m
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANWalletViewController.h"
#import "YANKeyStorage.h"
#import "YMAAPISession.h"
#import "YMAAccountInfoResponse.h"
#import "YMAAccountInfoRequest.h"

#import "YMAHistoryOperationsResponse.h"
#import "YMAHistoryOperationsRequest.h"

@interface YANWalletViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *balance;

@property (weak, nonatomic) IBOutlet UITabBarItem *walletButton;

@end

@implementation YANWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear: (BOOL) clause {
    [super viewWillAppear:clause];
    YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];
    YMAAPISession* session =  [[YMAAPISession alloc] init];
    
    [session performRequest:request
                                 token:self.keyStorage.accessToken
                            completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {
                                
                                NSLog(error.description);
                                
                                YMAAccountInfoResponse *accauntInfoResponse = (YMAAccountInfoResponse *) response;
                                
                                YMAAccountInfoModel *info = accauntInfoResponse.accountInfo;
                                
                                self.balance.text = info.balance;
                                
                                NSLog(info.account);
                                
                            }];
    
    
    self.userNameLabel.text = [self getTitle];
    NSLog(@"BBBBB");


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString*) getTitle {
    
    YMAAPISession* session =  [[YMAAPISession alloc] init];
    __block NSString *title;
    
    YMAHistoryOperationsRequest *opHistRequest = [YMAHistoryOperationsRequest operationHistoryWithFilter:YMAHistoryOperationFilterUnknown label:nil from:nil till:nil startRecord:nil records:@"2"];
    
    [session performRequest:opHistRequest token:self.keyStorage.accessToken completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {
        
        YMAHistoryOperationsResponse *accauntInfoResponse = (YMAHistoryOperationsResponse *) response;
        
        
        for(YMAHistoryOperationModel *operation in accauntInfoResponse.operations) {
            NSLog(@"AAAAAA");
            title = operation.title;
        }
        
    }];
    
    
    
    return title;
}

@end
