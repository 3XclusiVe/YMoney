//
//  WalletViewController.h
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *balanceLabel;

@property (weak, nonatomic) IBOutlet UITabBarItem *walletButton;

@end
