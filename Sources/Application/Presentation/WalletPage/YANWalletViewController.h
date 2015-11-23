//
//  YANWalletViewController.h
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YANKeyStorage;
@class YMAAPISession;

@interface YANWalletViewController : UIViewController

@property (strong, nonatomic) YANKeyStorage* keyStorage;

@property (strong, nonatomic) YMAAPISession* yanApiSession;

@end
