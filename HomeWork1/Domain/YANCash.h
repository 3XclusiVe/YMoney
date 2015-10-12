//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YANCash : NSObject

/// Валюта. Не может быть нулевая.
@property(nonatomic, nonnull, readonly) NSString *currency;

/// Значение. Должно быть больше нуля.
@property(nonatomic, readonly) float count;

/// @brief Первичный инициализатор. Инициализатор "init" не поддерживатеся.
/// @param длина currency должна быть больше нуля.
/// @param count должно быть больше нуля.
- (nonnull instancetype)initWithCashCount:(float)count
                              andCurrency:(nonnull NSString *)currency;

- (instancetype)init;

@end