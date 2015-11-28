//
//  CustomSpinner.m
//  YMoney
//
//  Created by Дмитрий on 28.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "CustomSpinner.h"
#import "YMoney-Swift.h"

static volatile BOOL isShowing;

@implementation CustomSpinner

+(void) showWithLabel:(NSString *)label
              timeout:(NSTimeInterval)timeout
    labelAfterTimeout:(NSString *)labelAfterTimeout
             animated:(BOOL)animated {
    
    isShowing = YES;
    
    [SwiftSpinner show:label animated:animated];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        [NSThread sleepForTimeInterval:timeout];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(isShowing) {
                [[SwiftSpinner show:label animated:YES] addTapHandler:^{
                    [SwiftSpinner hide: ^ {
                    
                    }];
                }subtitle:labelAfterTimeout];
            }
        });
    });
}

+(void) hide:(NSString *) completionLabel {
    if(isShowing) {
        [SwiftSpinner show:completionLabel animated:NO];
    
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^ {
            [NSThread sleepForTimeInterval:0.5];
                [SwiftSpinner hide: ^ {
                    
                }];
        });
        isShowing = NO;
    }
    
}

@end
