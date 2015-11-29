//
//  Created by Дмитрий on 29.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YANOperationDetailsView.h"

@class YMAHistoryOperationModel;

@interface YANOperationDetailsView (YMAHistoryOperationModel)

-(void) configureWithOperation:(YMAHistoryOperationModel *)operation;

@end