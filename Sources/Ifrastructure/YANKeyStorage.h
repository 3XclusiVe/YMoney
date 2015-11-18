//
//  YANKeyStorage.h
//  YMoney
//
//  Created by Дмитрий on 04.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YANKeyStorage : NSObject

@property(nonatomic, nonnull, readonly) NSString *accessToken;

- (nonnull instancetype)initWithAccessToken:(nonnull NSString *)accessToken;

@end


