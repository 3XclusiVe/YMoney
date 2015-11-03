//
//  AuthorizationViewController.h
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChildViewControllerDelegate;

@interface AuthorizationViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) id<ChildViewControllerDelegate> delegate;

@end

@protocol ChildViewControllerDelegate <NSObject>

- (void)childViewController:(AuthorizationViewController*)viewController
             didChooseValue:(CGFloat)value;

@end