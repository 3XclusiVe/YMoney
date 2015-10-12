//
//  main.m
//  HomeWork1
//
//  Created by Дмитрий on 12.10.15.
//  Copyright (c) 2015 DMA. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "YANCash.h"
#import "YANBalance.h"
#import "YANCashOperation.h"
#import "YANOperationHistory.h"


int main(int argc, char *argv[]) {
    /**@autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    } **/

    /**
    YANCash *cash = [[YANCash alloc] initWithCashCount:100.0
                                           andCurrency:@"P"];

    YANBalance *balance = [[YANBalance alloc] initWithCash:cash];

    NSString * dateString = @"03-Sep-11";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MMM-yy";
    NSDate *date = [dateFormatter dateFromString:dateString];

    YANCashOperation *cashOperation = [[YANCashOperation alloc]
            initOperationWithDate:date WithDescription:@"pok" WithCash:cash
                    WithDirection:1];

    NSLog(@"%f", cashOperation.operationSum.count);
    NSLog(balance.currentBalance.currency);
    NSLog(@"Todays date is %@", [dateFormatter stringFromDate:cashOperation.operationDate]);
    NSLog(cashOperation.operationSum.currency);
    cash = [[YANCash alloc] initWithCashCount:60.0
                                  andCurrency:@"$"];
    NSLog(@"%f", cashOperation.operationSum.count);
    NSLog(cashOperation.operationDescription);
    NSLog(@"%i", cashOperation.operationDirection);

    YANOperationHistory *ophistory = [[YANOperationHistory alloc] init];
    [ophistory addOperation:cashOperation];
    **/


}