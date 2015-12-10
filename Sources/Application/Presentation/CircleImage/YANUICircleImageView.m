//
//  YANUICircleImageView.m
//  YMoney
//
//  Created by Дмитрий on 07.12.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANUICircleImageView.h"

@implementation YANUICircleImageView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self makeRounded];
}

- (void)makeRounded {

    CGFloat radius = self.frame.size.width / 2;

    CGRect bounds = self.bounds;

    //Make round
    // Create the path for to make circle
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    // Create the shape layer and set its path
    CAShapeLayer *circleMask = [CAShapeLayer layer];

    circleMask.frame = bounds;
    circleMask.path = maskPath.CGPath;

    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = circleMask;

}

@end