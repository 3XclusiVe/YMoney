//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum Direction {
    IN,
    OUT
} OperationDirection;

@class YANCash;

@interface YANCashOperation : NSObject

/// Дата операции. Не может быть нулевой.
@property(nonatomic, nonnull, readonly) NSDate *operationDate;

/// Описание операции. Не может быть нулевой.
@property(nonatomic, nonnull, readonly) NSString *operationDescription;

/// Сумма опреации. Не может быть нулевой.
@property(nonatomic, nonnull, readonly) YANCash *operationSum;

/// Направление операции. Платежи или пополнения.
// 1 - пополнения.
// -1 - платежи.
// в дальнейшем будет enum.
@property(nonatomic, readonly) OperationDirection operationDirection;

/// @brief Первичный инициализатор. Инициализатор "init" не поддерживатеся.
/// @param аргументы не должны быть нулевыми.
- (nonnull instancetype)initOperationWithDate:(nonnull NSDate *)operationDate
                                  Description:(nonnull NSString *)operationDescription
                                         Cash:(nonnull YANCash *)operationSum
                                    Direction:(OperationDirection )
                                            operationDirection;
@end