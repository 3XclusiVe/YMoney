//
//  ViewController.m
//  HomeWork1
//
//  Created by Дмитрий on 12.10.15.
//  Copyright (c) 2015 DMA. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

- (IBAction)enterButtonTouch:(id)sender;

- (IBAction)createWalletButtonTouch:(id)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)enterButtonTouch:(id)sender {
    NSLog(@"enter button touched");
}


- (IBAction)createWalletButtonTouch:(id)sender {
    NSLog(@"create wallet button touched");
}

@end