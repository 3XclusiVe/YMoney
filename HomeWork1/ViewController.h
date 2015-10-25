//
//  ViewController.h
//  HomeWork1
//
//  Created by Дмитрий on 12.10.15.
//  Copyright (c) 2015 DMA. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enterButton;

@property (weak, nonatomic) IBOutlet UIButton *createWalletButton;

- (IBAction)enterButtonTouch:(id)sender;

- (IBAction)createWalletButtonTouch:(id)sender;

@end
