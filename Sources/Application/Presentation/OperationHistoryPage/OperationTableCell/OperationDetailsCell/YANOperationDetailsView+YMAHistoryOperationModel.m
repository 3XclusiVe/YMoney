//
//  Created by Дмитрий on 29.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANOperationDetailsView+YMAHistoryOperationModel.h"
#import "YMAHistoryOperationModel.h"
#import "NSException+POSRx.h"

@implementation YANOperationDetailsView (YMAHistoryOperationModel)

-(void) configureWithOperation:(YMAHistoryOperationModel *)operation {
    
    POSRX_CHECK_EX(operation != nil, @"missing operation");
    
    self.operationTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.operationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    if(operation.direction == YMAHistoryOperationDirectionIn) {
        self.operationAmount.text = [NSString stringWithFormat:@"+%@ ₽",operation.amount];
        self.operationAmount.textColor = [UIColor colorWithRed:(32/255.f) green:(205/255.f) blue:(32/255.f) alpha:1];
    } else {
        self.operationAmount.text = [NSString stringWithFormat:@"-%@ ₽",operation.amount];
    }
    self.operationLabel.text = operation.label;
    self.operationTitle.text = operation.title;
}

@end
