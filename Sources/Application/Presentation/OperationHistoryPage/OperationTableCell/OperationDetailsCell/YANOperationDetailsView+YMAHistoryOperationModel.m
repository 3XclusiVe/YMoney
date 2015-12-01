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
    
    self.operationAmount.text = operation.amount;
    self.operationLabel.text = operation.label;
    self.operationTitle.text = operation.title;
    
}

@end
