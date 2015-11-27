//
//  YANServerProtocol.m
//  YMoney
//
//  Created by Дмитрий on 26.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANServerProtocol.h"

@implementation YANServerProtocol

@end

const struct Errors errors = {
    .INTERNET_CONNECTION_TIMEOUT = -1001,
    .NO_INTERNET_CONNECTION = -1009,
    .INVALID_TOKEN = 401
};