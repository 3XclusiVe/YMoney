//
//  CustomSpinner.h
//  YMoney
//
//  Created by Дмитрий on 28.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomSpinner : NSObject

+(void) showWithLabel:(NSString *)label
              timeout:(NSTimeInterval) timeout
    labelAfterTimeout:(NSString *)labelAfterTimeout
             animated:(BOOL)animated;

+(void) hide:(NSString *)completionLabel;

@end
