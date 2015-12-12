//
//  YNAjef.m
//  YMoney
//
//  Created by Дмитрий on 07.12.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YMAHistoryOperationModel+NSCoding.h"

NSString * kOperationIdKey = @"operationId";
NSString * kOperationStatusKey = @"status";
NSString * kOperationDateKey = @"datetime";
NSString * kOperationTitleKey = @"title";
NSString * kOperationPatternIdKey = @"pattern";
NSString * kOperationDirectionKey = @"direction";
NSString * kOperationAmountKey = @"amount";
NSString * kOperationLabelKey = @"label";
NSString * kOperationIsFavoriteKey = @"favorite";
NSString * kOperationTypeKey = @"type";


@implementation YMAHistoryOperationModel (NSCoding)


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.operationId forKey:kOperationIdKey];
    [encoder encodeInt:self.status forKey:kOperationStatusKey];
    [encoder encodeObject:self.datetime forKey:kOperationDateKey];
    [encoder encodeObject:self.title forKey:kOperationTitleKey];
    [encoder encodeObject:self.patternId forKey:kOperationPatternIdKey];
    [encoder encodeInt:self.direction forKey:kOperationDirectionKey];
    [encoder encodeObject:self.amount forKey:kOperationAmountKey];
    [encoder encodeObject:self.label forKey:kOperationLabelKey];
    [encoder encodeBool:self.isFavourite forKey:kOperationIsFavoriteKey];
    [encoder encodeInt:self.type forKey:kOperationTypeKey];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    NSString* operationId = [decoder decodeObjectForKey:kOperationIdKey];
    YMAHistoryOperationStatus status = [decoder decodeIntForKey:kOperationStatusKey];
    NSDate* date = [decoder decodeObjectForKey:kOperationDateKey];
    NSString* title = [decoder decodeObjectForKey:kOperationTitleKey];
    NSString* patternId = [decoder decodeObjectForKey:kOperationPatternIdKey];
    YMAHistoryOperationDirection direction = [decoder decodeIntForKey:kOperationDirectionKey];
    NSString* amount = [decoder decodeObjectForKey:kOperationAmountKey];
    NSString* label = [decoder decodeObjectForKey:kOperationLabelKey];
    BOOL isFavorite = [decoder decodeBoolForKey:kOperationIsFavoriteKey];
    YMAHistoryOperationType type = [decoder decodeIntForKey:kOperationTypeKey];

    return [self initWithOperationId:operationId
                              status:status
                            datetime:date
                               title:title
                           patternId:patternId
                           direction:direction
                              amount:amount
                               label:label
                           favourite:isFavorite
                                type:type];
}

@end
