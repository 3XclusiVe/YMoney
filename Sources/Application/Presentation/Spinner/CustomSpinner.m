//
//  CustomSpinner.m
//  YMoney
//
//  Created by Дмитрий on 28.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "CustomSpinner.h"
#import "YMoney-Swift.h"

typedef void (^Block)(void);

static volatile BOOL isShowing;

@implementation CustomSpinner

+(void) showWithLabel:(NSString *)label
              timeout:(NSTimeInterval)timeout
    labelAfterTimeout:(NSString *)labelAfterTimeout
             animated:(BOOL)animated {
    
    isShowing = YES;
    
    [SwiftSpinner show:label animated:animated];
    
    [self delay:timeout :^{
        if(isShowing) {
            [[SwiftSpinner show:label animated:YES] addTapHandler:^{
                [SwiftSpinner hide: ^ {
                    isShowing = NO;
                }];
            }subtitle:labelAfterTimeout];
        }
    }];
    
}

+(void) hide:(NSString *) completionLabel {
    if(isShowing) {
        [SwiftSpinner show:completionLabel animated:NO];
    
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^ {
            [NSThread sleepForTimeInterval:1];
                [SwiftSpinner hide: ^ {
                    
                }];
        });
        isShowing = NO;
    }
    
}

+(void) delay:(double)delay :(Block)block {
    dispatch_after(
                   dispatch_time(
                                 DISPATCH_TIME_NOW,
                                 (long)(delay * (double)NSEC_PER_SEC)
                                 ),
                   dispatch_get_main_queue(), block);
}

@end
