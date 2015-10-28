//
//  AuthorizationViewController.m
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "AuthorizationViewController.h"

@interface AuthorizationViewController ()

- (IBAction)autorizationSuccess:(id)sender;

@end

@implementation AuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)autorizationSuccess:(id)sender {
    NSLog(@"authorization success");
}
@end
