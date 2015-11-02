//
//  AuthorizationViewController.m
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "AuthorizationViewController.h"
#import "YMAConstants.h"
#import "YMAExternalPaymentSession.h"
#import "YMAAPISession.h"

@interface AuthorizationViewController ()

- (IBAction)autorizationSuccess:(id)sender;

@property(weak, nonatomic) IBOutlet UIWebView *authorizationWebView;


- (IBAction)authorizationFailed:(id)sender;

@end

@implementation AuthorizationViewController

//My client id.
NSString *_clientId = @"CBE42B5C0151CE4F2AC277F5A037A45DF265B83F21EB4FF9D61A559D2A73DBF6";
//URI that the OAuth server sends the authorization result to.
NSString *_redirectUri = @"http://ya.ru";
//A list of requested permissions.
NSString *_permissions = @"account-info operation-history";

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary * additionalParameters = @{
            YMAParameterResponseType : YMAValueParameterResponseType, //Constant parameter
            YMAParameterRedirectUri : _redirectUri,
            YMAParameterScope : _permissions,
    };

    YMAAPISession *session = [[YMAAPISession alloc] init];
    NSURLRequest *authorizationRequest = [session authorizationRequestWithClientId:_clientId
                                                              additionalParameters:additionalParameters];
    [_authorizationWebView loadRequest:authorizationRequest];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)autorizationSuccess:(id)sender {
    NSLog(@"authorization success");
}

// Тестовое использование делегата.
- (IBAction)authorizationFailed:(id)sender {
    id <ChildViewControllerDelegate> strongDelegate = self.delegate;

    if ([strongDelegate respondsToSelector:@selector(childViewController:didChooseValue:)]) {
        [strongDelegate childViewController:self didChooseValue:5];
    }
}
@end
