//
//  HomeWork1Tests.m
//  HomeWork1Tests
//
//  Created by Дмитрий on 12.10.15.
//  Copyright (c) 2015 DMA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YANCash.h"
#import "YANBalance.h"
#import "YANCashOperation.h"
#import "YANOperationHistory.h"
#import "YANKeyStorage.h"

@interface YANYMoneyTests : XCTestCase

@end

@implementation YANYMoneyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testImpossibleToCreateNUllCash {

    XCTAssertThrows([YANCash init]);


    float badValue = -1;
    XCTAssertThrows([[YANCash alloc] initWithCashCount:badValue currency:@"Р"]);

    NSString * badName = nil;
    XCTAssertThrows([[YANCash alloc] initWithCashCount:5 currency:badName]);
}

- (void)testImpossibleToCreateNullBalance {
    YANCash *badCash = nil;
    XCTAssertThrows([[YANBalance alloc] initWithCash:badCash]);
    XCTAssertThrows([[YANBalance alloc] init]);
}

- (void)testImpossibleToCreateNullCashOperation {

    XCTAssertThrows([[YANCashOperation alloc] initOperationWithDate:nil description:nil cash:nil direction:nil]);
    XCTAssertThrows([YANCashOperation new]);
}

- (void)testImpossibleToAddNUllOperation {

    YANOperationHistory *history = [YANOperationHistory new];
    YANCashOperation *badoperation = nil;

    XCTAssertThrows([history addOperation:badoperation]);

}

- (void)testImpossibleToChangeCurrencyAfterInitialization {

    NSMutableString *evilName = [NSMutableString stringWithString:@"Р"];
    YANCash *cash = [[YANCash alloc] initWithCashCount:100 currency:evilName];
    [evilName setString:@"$"];
    XCTAssertEqualObjects(cash.currency, @"Р");

}

/**
 * KEY Storage Test
 */

- (void)unnableToCreateNullKeyStorage {

    NSMutableString *evilName = [NSMutableString stringWithString:@"Р"];

    XCTAssertThrows([[YANKeyStorage alloc] init]);
    XCTAssertThrows([[YANKeyStorage alloc] initWithAccessToken:nil]);
    YANKeyStorage *yanKeyStorage = [[YANKeyStorage alloc]
            initWithAccessToken:evilName];
    [evilName setString:@"$"];
    XCTAssertEqualObjects(yanKeyStorage.accessToken, @"Р");

}
@end
