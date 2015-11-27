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
#import "YANServerProtocol.h"
#import "YANBaseUIViewController.h"

@implementation YANYandexMoneyServer {

    //Token
    NSString *_accessToken;

    //Auth session
    YMAAPISession *_session;
    
    NSMutableArray *_observers;
}

//My client id.
static NSString *const _clientId = @"CBE42B5C0151CE4F2AC277F5A037A45DF265B83F21EB4FF9D61A559D2A73DBF6";
//URI that the OAuth server sends the authorization result to.
static NSString *const _redirectUri = @"http://ya.ru";
//A list of requested permissions.
static NSString *const _permissions = @"account-info operation-history";


+(void)checkAccessToken:(nonnull NSString *)accessToken forObserver:(id<YANYandexServerObserver>)observer {
    //POSRX_CHECK_EX(accessToken != nil, @"missing access token");

    YMAAPISession *session = [[YMAAPISession alloc] init];
    YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];

    [session performRequest:request
                      token:accessToken
                 completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {

                     if (error == nil) {
                         [observer onTokenAccepted];
                     } else {
                         [observer onNeedToRefreshToken];
                     }

                 }];
}


- (instancetype)initWithAccessToken:(nonnull NSString *)accessToken {

    POSRX_CHECK_EX(accessToken != nil, @"missing access token");
    
    if (self = [super init]) {
        _accessToken = [accessToken copy];
        _session = [[YMAAPISession alloc] init];
        _observers  = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) subscribeOnEvents:(id<YANYandexServerObserver>) observer {
    [_observers addObject:observer];
}

-(void) unSubscribeOnEvents:(id<YANYandexServerObserver>) observer {
    [_observers removeObject:observer];
}


- (void)performAccountInfoRequest {
    
    YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];
    
    NSLog(@"perfoming account info request");
    
    if(_session == nil) {
        NSLog(@"session is nill");
    }
    
    if(_accessToken == nil) {
        NSLog(@"access token is nill");
    }
    
    [_session performRequest:request
                       token:_accessToken
                  completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {
                      
                      if (error == nil) {
                          YMAAccountInfoResponse *accauntInfoResponse = (YMAAccountInfoResponse *) response;
                          
                          YMAAccountInfoModel *accountInfo = accauntInfoResponse.accountInfo;
                          
                          [self updateAccountInfoData: accountInfo];
                          
                      } else {
                          [self handleError:error.code];
                      }
                      
                  }];
    

}

- (void)performOperationHistoryRequest {

}

POSRX_DEADLY_INITIALIZER(init);

#pragma mark - Private methods

-(void) updateAccountInfoData:(YMAAccountInfoModel *) accountInfo {
    for(id<YANYandexServerObserver> observer in _observers) {
        [observer onReceiveAccountInfo:accountInfo];
    }
}

-(void) handleError:(int) error {
    if(error == errors.INTERNET_CONNECTION_TIMEOUT) {
        [self onConnectionTimeout];
    } else if (error == errors.NO_INTERNET_CONNECTION) {
        [self onConnectionLost];
    } else if (error == errors.INVALID_TOKEN) {
        [self onBadToken];
    } else {
        [self onUnexpectedError];
    }
}

-(void) onConnectionTimeout {
    NSLog(@"Connection timeout");
    for(id<YANYandexServerObserver> observer in _observers) {
        [observer onInternetConnectionLost];
    }
}

-(void) onConnectionLost {
    NSLog(@"Connection lost");
    for(id<YANYandexServerObserver> observer in _observers) {
        [observer onInternetConnectionLost];
    }
}

-(void) onConfirmToken:(NSString*) accessToken {
    NSLog(@"Access token is confirmed");
    for(id<YANYandexServerObserver> observer in _observers) {
        [observer onReceiveToken:accessToken];
    }
}

-(void) onTokenAccepted {
    NSLog(@"Access token is accepted");
    for(id<YANYandexServerObserver> observer in _observers) {
        [observer onTokenAccepted];
    }
}

-(void) onBadToken {
    NSLog(@"Need to refresh token");
    for(id<YANYandexServerObserver> observer in _observers) {
        [observer onNeedToRefreshToken];
    }
}

-(void) onUnexpectedError {
    NSLog(@"Unexpected error");
}



@end
