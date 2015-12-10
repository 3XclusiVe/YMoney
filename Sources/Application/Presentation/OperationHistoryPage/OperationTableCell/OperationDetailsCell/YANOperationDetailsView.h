//
//  Y.h
//  YMoney
//
//  Created by Дмитрий on 29.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YANOperationDetailsView : UITableViewCell

+ (instancetype)loadFromNib;

@property (weak, nonatomic) IBOutlet UIImage *operationTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *operationTitle;
@property (weak, nonatomic) IBOutlet UILabel *operationLabel;

@property (weak, nonatomic) IBOutlet UILabel *operationAmount;
@property (weak, nonatomic) IBOutlet UILabel *operationStatus;

@end
