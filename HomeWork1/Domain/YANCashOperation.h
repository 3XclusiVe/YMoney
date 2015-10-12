//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YANCash;

@interface YANCashOperation : NSObject

/// Дата операции. Не может быть нулевой.
@property(nonatomic, nonnull, readonly) NSDate *operationDate;

/// Описание операции. Не может быть нулевой.
@property(nonatomic, nonnull, readonly) NSString *operationDescription;

/// Сумма опреации. Не может быть нулевой.
@property(nonatomic, nonnull, readonly) YANCash *operationSum;

/// Направление операции. Платежи или пополнения.
@property(nonatomic, readonly) int operationDirection;

/// @brief Первичный инициализатор. Инициализатор "init" не поддерживатеся.
/// @param аргументы не должны быть нулевыми.
- (nonnull instancetype)initOperationWithDate:(nonnull NSDate *)operationDate
                              WithDescription:(nonnull NSString *)operationDescription
                                     WithCash:(nonnull YANCash *)operationSum
                                WithDirection:(int)operationDirection;

- (nullable instancetype)init;

@end