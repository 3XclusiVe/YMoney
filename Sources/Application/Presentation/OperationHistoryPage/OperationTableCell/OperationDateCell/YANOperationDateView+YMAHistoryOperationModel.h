//
//  TableViewCell.h
//  YMoney
//
//  Created by Дмитрий on 29.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YANOperationDateView.h"

@class YMAHistoryOperationModel;

@interface YANOperationDateView (YMAHistoryOperationModel)

-(void) configureWithDate:(NSDate *)operationDate;

@end
