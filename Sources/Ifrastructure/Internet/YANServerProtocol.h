//
//  YANServerProtocol.h
//  YMoney
//
//  Created by Дмитрий on 26.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YANServerProtocol : NSObject

@end
struct Errors {
    const int INTERNET_CONNECTION_TIMEOUT;
    const int NO_INTERNET_CONNECTION;
    const int INVALID_TOKEN;
};

extern const struct Errors errors;

