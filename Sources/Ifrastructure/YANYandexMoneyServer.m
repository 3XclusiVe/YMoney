//
//  YANYandexMoneyServer.m
//  YMoney
//
//  Created by Дмитрий on 24.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANYandexMoneyServer.h"
#import "NSException+POSRx.h"
#import "YMAAPISession.h"
#import "YMAAccountInfoRequest.h"

@implementation YANYandexMoneyServer {

    //Token
    NSString *_accessToken;

    //Auth session
    YMAAPISession *_session;
}

//My client id.
static NSString *const _clientId = @"CBE42B5C0151CE4F2AC277F5A037A45DF265B83F21EB4FF9D61A559D2A73DBF6";
//URI that the OAuth server sends the authorization result to.
static NSString *const _redirectUri = @"http://ya.ru";
//A list of requested permissions.
static NSString *const _permissions = @"account-info operation-history";


+ (void)checkAccessToken:(nonnull NSString *)accessToken {
    //POSRX_CHECK_EX(accessToken != nil, @"missing access token");

    YMAAPISession *session = [[YMAAPISession alloc] init];
    YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];

    [session performRequest:request
                      token:accessToken
                 completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {

                     if (error == nil) {
                         NSLog(@"access token proved");
                     } else {
                         NSLog(@"neeed to refresh access token");
                     }

                 }];
}


- (instancetype)initWithAccessToken:(nonnull NSString *)accessToken {

    POSRX_CHECK_EX(accessToken != nil, @"missing access token");


    _session = [[YMAAPISession alloc] init];

    YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];

    [_session performRequest:request
                       token:accessToken
                  completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {

                      if (error == nil) {

                      }

                  }];
    if (self = [super init]) {
        _accessToken = [accessToken copy];
    }
    return self;
}

- (void)performAccountInfoRequest {

}

- (void)performOperationHistoryRequest {

}

POSRX_DEADLY_INITIALIZER(init);

@end
