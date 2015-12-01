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

NSThread* _connectionTimeoutThread;

const NSTimeInterval kConnectionTimeout = 5.0f;

//My client id.
static NSString *const _clientId = @"CBE42B5C0151CE4F2AC277F5A037A45DF265B83F21EB4FF9D61A559D2A73DBF6";
//URI that the OAuth server sends the authorization result to.
static NSString *const _redirectUri = @"http://ya.ru";
//A list of requested permissions.
static NSString *const _permissions = @"account-info operation-history";


+(void)checkAccessToken:(nonnull NSString *)accessToken forObserver:(id<YANYandexServerObserver>)observer {

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

-(void)checkAccessToken {
    
    [self startTimeout];
    
    YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];
    
    [_session performRequest:request
                      token:_accessToken
                 completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {
                     
                     [self stopTimeout];
                     
                     if (error == nil) {
                         [self onTokenAccepted];
                     } else {
                         [self handleError:error.code];
                     }
                     
                 }];
}


- (void)performAccountInfoRequest {
    
    [self startTimeout];
    
    YMAAccountInfoRequest *request = [YMAAccountInfoRequest accountInfoRequest];
    
    NSLog(@"perfoming account info request");
    
    [_session performRequest:request
                       token:_accessToken
                  completion:^(YMABaseRequest *request, YMABaseResponse *response, NSError *error) {
                      
                      [self stopTimeout];
                      
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
    dispatch_async(dispatch_get_main_queue(), ^{
        for(id<YANYandexServerObserver> observer in _observers) {
            [observer onReceiveAccountInfo:accountInfo];
        }
    });
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
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Connection timeout");
        for(id<YANYandexServerObserver> observer in _observers) {
            [observer onInternetConnectionLost];
        }
    });
}

-(void) onConnectionLost {
    dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"Connection lost");
        for(id<YANYandexServerObserver> observer in _observers) {
            [observer onInternetConnectionLost];
        }
    });
}

-(void) onConfirmToken:(NSString*) accessToken {
    dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"Access token is confirmed");
        for(id<YANYandexServerObserver> observer in _observers) {
            [observer onReceiveToken:accessToken];
        }
    });
}

-(void) onTokenAccepted {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Access token is accepted");
        for(id<YANYandexServerObserver> observer in _observers) {
            [observer onTokenAccepted];
        }
    });
}

-(void) onBadToken {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Need to refresh token");
        for(id<YANYandexServerObserver> observer in _observers) {
            [observer onNeedToRefreshToken];
        }
    });
}

-(void) onUnexpectedError {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Unexpected error");
    });
}

#pragma mark - TimeOut

-(void) startTimeout {
    [_connectionTimeoutThread cancel];
    _connectionTimeoutThread = [[NSThread alloc] initWithTarget:self selector:@selector(timeoutThread) object:nil];
    [_connectionTimeoutThread start];
}

-(void) timeoutThread {
    NSTimeInterval timeStamp = 0.1f;
    NSTimeInterval currentTime = 0.0f;
    while(currentTime < kConnectionTimeout) {
        if([NSThread currentThread].isCancelled) {
            return;
        }
        [NSThread sleepForTimeInterval:timeStamp];
        currentTime += timeStamp;
    }
    
    [self onConnectionTimeout];
}

-(void) stopTimeout {
    [_connectionTimeoutThread cancel];
}


@end
