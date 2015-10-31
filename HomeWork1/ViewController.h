//
//  ViewController.h
//  HomeWork1
//
//  Created by Дмитрий on 12.10.15.
//  Copyright (c) 2015 DMA. All rights reserved.
//


#import <UIKit/UIKit.h>

@class AuthorizationViewController;

@protocol ChildViewControllerDelegate;

@interface ViewController : UIViewController <ChildViewControllerDelegate>

- (void)childViewController:(AuthorizationViewController *)viewController didChooseValue:(CGFloat)value;

@end
