//
//  OperationTableViewCell.h
//  YMoney
//
//  Created by Дмитрий on 29.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YANOperationDateView : UITableViewCell

+ (instancetype)loadFromNib;

@property (weak, nonatomic) IBOutlet UILabel *operationDate;

@end
