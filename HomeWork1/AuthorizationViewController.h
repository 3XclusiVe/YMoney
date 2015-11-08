//
//  AuthorizationViewController.h
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthorizationViewControllerDelegate;

@interface AuthorizationViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) id<AuthorizationViewControllerDelegate> delegate;

@end

@protocol AuthorizationViewControllerDelegate <NSObject>

- (void)authorizationViewController:(AuthorizationViewController*)viewController
                     didChooseValue:(CGFloat)value;

@end