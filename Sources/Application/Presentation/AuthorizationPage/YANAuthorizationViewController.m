//
//  YANAuthorizationViewController.m
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANAuthorizationViewController.h"
#import "YMAConstants.h"
#import "YMAExternalPaymentSession.h"
#import "YMAAPISession.h"
#import "YMAAccountInfoResponse.h"
#import "YMAAccountInfoRequest.h"

@interface YANAuthorizationViewController ()

- (IBAction)autorizationSuccess:(id)sender;

@property(weak, nonatomic) IBOutlet UIWebView *authorizationWebView;


- (IBAction)authorizationFailed:(id)sender;

@end

@implementation YANAuthorizationViewController

//My client id.
static const NSString *_clientId = @"CBE42B5C0151CE4F2AC277F5A037A45DF265B83F21EB4FF9D61A559D2A73DBF6";
//URI that the OAuth server sends the authorization result to.
NSString *_redirectUri = @"http://ya.ru";
//A list of requested permissions.
NSString *_permissions = @"account-info operation-history";

//Token
NSString *_accessToken = nil;

//Auth session
YMAAPISession *_session = nil;

- (void)viewDidLoad {
    [super viewDidLoad];

    _authorizationWebView.delegate = self;

    NSDictionary * additionalParameters = @{
            YMAParameterResponseType : YMAValueParameterResponseType, //Constant parameter
            YMAParameterRedirectUri : _redirectUri,
            YMAParameterScope : _permissions,
    };

    _session = [[YMAAPISession alloc] init];
    NSURLRequest *authorizationRequest = [_session authorizationRequestWithClientId:_clientId
                                                               additionalParameters:additionalParameters];
    [_authorizationWebView loadRequest:authorizationRequest];

    NSLog(@"Loaded");

}


// MARK: UIWebViewDelegate protocol
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    BOOL shouldLoadPage = YES;
    NSMutableDictionary *authInfo = nil;
    NSError * error = nil;

    if ([_session isRequest:request
              toRedirectUrl:_redirectUri
          authorizationInfo:&authInfo
                      error:&error]) {
        shouldLoadPage = NO;

        if (error == nil) {
            NSString * authCode = authInfo[@"code"];
            [self getAccessTokenFor:authCode];
        } else {
            [self authorizationFailed:error];
        }
    }
    return shouldLoadPage;

}

- (void)getAccessTokenFor:(NSString *)authCode {
    
    NSDictionary * additionalParameters = @{
                                            @"grant_type" : @"authorization_code", // Constant parameter
                                            YMAParameterRedirectUri : _redirectUri
                                            };
    
    [_session receiveTokenWithCode:authCode
                          clientId:_clientId
              additionalParameters:additionalParameters
                        completion:^(NSString *instanceId, NSError *error) {
                            if (error == nil && instanceId != nil && instanceId.length > 0) {
                                _accessToken = instanceId;
                                [self performSegueWithIdentifier:@"LoginSuccess" sender:instanceId];
                            } else {
                                [self authorizationFailed:error];
                                NSLog(@"error");
                            }
                        }];

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
// MARK: UIWebViewDelegate protocol


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)autorizationSuccess:(id)sender {
    NSLog(@"authorization success");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"LoginSuccess"])
    {
        NSLog(_accessToken);
        
        YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];
        
        [_session performRequest:request
                           token:_accessToken
                      completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {
                          
                          YMAAccountInfoResponse *accauntInfoResponse = (YMAAccountInfoResponse *) response;
                          
                          YMAAccountInfoModel *info = accauntInfoResponse.accountInfo;
                          
                          NSLog(info.balance);
                      }];
    } else {

    }
}


// Тестовое использование делегата.
- (IBAction)authorizationFailed:(id)sender {
    id <AuthorizationViewControllerDelegate> strongDelegate = self.delegate;
    
    [strongDelegate authorizationViewController:self
                                 didChooseValue:5];
}
@end
