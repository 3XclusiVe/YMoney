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

@interface HomeWork1Tests : XCTestCase

@end

@implementation HomeWork1Tests

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
    
    XCTAssertThrows([YANCash new]);
    
    
    float badValue = -1;
    XCTAssertThrows([[YANCash alloc] initWithCashCount:badValue Currency:@"Р"]);

    NSString * badName = nil;
    XCTAssertThrows([[YANCash alloc] initWithCashCount:5 Currency:badName]);
}

-(void) testImpossibleToCreateNullBalance {
    YANCash *badCash = nil;
    XCTAssertThrows([[YANBalance alloc] initWithCash:badCash]);
}

-(void) testImpossibleToCreateNullCashOperation {
    
    XCTAssertThrows([[YANCashOperation alloc] initOperationWithDate:nil Description:nil Cash:nil Direction:nil]);
    XCTAssertThrows([YANCashOperation new]);
}

-(void) testImpossibleToAddNUllOperation {
    
    YANOperationHistory *history = [YANOperationHistory new];
    YANCashOperation *badoperation = nil;
    
    XCTAssertThrows([history addOperation:badoperation]);

}
-(void) testImpossibleToChangeCurrencyAfterInitialization {
    
    NSMutableString *evilName = [NSMutableString stringWithString:@"Р"];
    YANCash *cash = [[YANCash alloc] initWithCashCount:100 Currency:evilName];
    [evilName setString:@"$"];
    XCTAssertEqualObjects(cash.currency, @"Р");
    
}
@end
