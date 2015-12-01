//
//  TableViewCell.m
//  YMoney
//
//  Created by Дмитрий on 29.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANOperationDateView+YMAHistoryOperationModel.h"
#import "YMAHistoryOperationModel.h"
#import "NSException+POSRx.h"

@implementation YANOperationDateView (YMAHistoryOperationModel)

-(void) configureWithDate:(NSDate *)operationDate {
    
    POSRX_CHECK_EX(operationDate != nil, @"missing operation date");
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale systemLocale];
    
    [formatter setLocale:locale];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    NSString *date = [formatter stringFromDate:operationDate];
    
    self.operationDate.text = date;
}

@end
