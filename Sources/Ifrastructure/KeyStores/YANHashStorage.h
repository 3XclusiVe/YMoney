//
//  YANHashStorage.h
//  YMoney
//
//  Created by Дмитрий on 09.12.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YMAHistoryOperationModel;
@class YMAAccountInfoModel;
@interface YANHashStorage : NSObject

+(instancetype) sharedInstance;
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

-(void) saveAccessToken:(NSString*) token;
-(NSString *)loadAccessToken;

-(void) saveOperationHistory:(NSArray<YMAHistoryOperationModel*> *) operations;
-(NSArray<YMAHistoryOperationModel*> *) loadOperationHistory;

-(YMAAccountInfoModel *) loadAccountInfo;
-(void) saveAccountInfo:(YMAAccountInfoModel*) accountInfo;

-(void) cleanStorage;
-(BOOL) isEmpty;

@end
