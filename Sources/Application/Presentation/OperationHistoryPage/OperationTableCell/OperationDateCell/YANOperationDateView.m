//
//  OperationTableViewCell.m
//  YMoney
//
//  Created by Дмитрий on 29.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANOperationDateView.h"

@implementation YANOperationDateView : UITableViewCell

+ (instancetype) loadFromNib {
    return [[[NSBundle bundleForClass:[self class]]
             loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]
            firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
