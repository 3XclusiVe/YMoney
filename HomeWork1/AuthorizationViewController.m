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
#import "YMAAccountInfoResponse.h"
#import "YMAAccountInfoRequest.h"

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

}


// MARK: UIWebViewDelegate protocol
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    BOOL shouldStartLoad = YES;
    NSMutableDictionary *authInfo = nil;
    NSError *error = nil;
    // session - instance of YMAAPISession class
    if ([_session isRequest:request
                  toRedirectUrl:_redirectUri
              authorizationInfo:&authInfo
                          error:&error]) {
        shouldStartLoad = NO;
        if (error == nil) {
            NSString *authCode = authInfo[@"code"];
            //Process temporary authorization code
            //NSLog(authCode);
            
            NSDictionary *additionalParameters = @{
                                                   @"grant_type"           : @"authorization_code", // Constant parameter
                                                   YMAParameterRedirectUri : _redirectUri
                                                   };
            
            // session  - instance of YMAAPISession class
            // authCode - temporary authorization code
            [_session receiveTokenWithCode:authCode
                                 clientId: _clientId
                     additionalParameters:additionalParameters
                               completion:^(NSString *instanceId, NSError *error) {
                                   if (error == nil && instanceId != nil && instanceId.length > 0) {
                                       NSString *accessToken = instanceId; // Do NOT request access_token every time, when you need to call API method.
                                       // Obtain it once and reuse it.
                                       // Process access_token
                                       //NSLog(accessToken);
                                       
                                       
                                       //NSDictionary *paymentParameters = ... // depends on your implementation
                                      // NSString *patternId = ... // depends on your implementation
                                       //YMAPaymentRequest *request = [YMAPaymentRequest paymentWithPatternId:patternId paymentParameters:paymentParameters];
                                       
                                       YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];
                                       
                                       // session  - instance of YMAAPISession class
                                       // token    - access token
                                       [_session performRequest:request token:accessToken completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {
                                           
                                           //YMAPaymentResponse *paymentResponse = (YMAPaymentResponse *)response;
                                           YMAAccountInfoResponse *accauntInfoResponse = (YMAAccountInfoResponse *)response;
                                           
                                           YMAAccountInfoModel *info = accauntInfoResponse.accountInfo;
                                           
                                           NSLog(info.balance);
                                       }];
                                       
                                       
                                       
                                       
                                       
                                       
                                   }
                                   else {
                                       // Process error
                                   }
                               }];
            
        }
    }
    return shouldStartLoad;
    
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

// Тестовое использование делегата.
- (IBAction)authorizationFailed:(id)sender {
    id <ChildViewControllerDelegate> strongDelegate = self.delegate;

    if ([strongDelegate respondsToSelector:@selector(childViewController:didChooseValue:)]) {
        [strongDelegate childViewController:self didChooseValue:5];
    }
}
@end
