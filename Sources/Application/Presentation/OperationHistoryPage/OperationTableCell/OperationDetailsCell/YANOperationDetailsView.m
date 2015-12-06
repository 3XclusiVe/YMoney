//
//  YANOperationDetailsView.m
//  YMoney
//
//  Created by Дмитрий on 29.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANOperationDetailsView.h"

@implementation YANOperationDetailsView : UITableViewCell

+ (instancetype) loadFromNib {
    return [[[NSBundle bundleForClass:[self class]]
             loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]
            firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self customizeView];
}

-(void) customizeView {
    self.operationTypeImage.layer.cornerRadius = self.operationTypeImage.frame.size.width / 2;
}

@end
