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
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    /*YANBalance *balance = [[YANBalance alloc] init];

    YANCash *cash = [[YANCash alloc] initWithCashCount:100
                                              Currency:@"P"];

    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    [components setHour:10];
    NSDate *today10am = [calendar dateFromComponents:components];

    OperationDirection operationDirection = IN;
    OperationDirection *op = &operationDirection;

    YANCashOperation *operation = [[YANCashOperation alloc]
            initOperationWithDate:now
                      Description:@"steam"
                             Cash:cash
                        Direction:nil];

    NSLog(@"%i", operationDirection == NULL);   */
}