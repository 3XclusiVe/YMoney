//
// Created by Дмитрий on 12.10.15.
// Copyright (c) 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YANCash;


@interface YANBalance : NSObject

/// Значение текущего баланса. Досупно только для чтения.
@property(nonatomic, nonnull, readonly) YANCash *currentBalance;

/// @brief Инициализатор "init" не поддерживатеся.
/// @param startCash не может быть пустым.
- (nonnull instancetype)initWithCash:(YANCash *)startCash;

/// Инициализирует нулевой баланс.
- (instancetype)init;
@end