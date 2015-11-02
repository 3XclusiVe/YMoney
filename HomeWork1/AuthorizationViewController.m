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

@property (weak, nonatomic) IBOutlet UIWebView *authorizationWebView;


- (IBAction)authorizationFailed:(id)sender;

@end

@implementation AuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *websiteUrl = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [_authorizationWebView loadRequest:urlRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)autorizationSuccess:(id)sender {
    NSLog(@"authorization success");
}
- (IBAction)authorizationFailed:(id)sender {
    id<ChildViewControllerDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(childViewController:didChooseValue:)]) {
        [strongDelegate childViewController:self didChooseValue:5];
    }
}
@end
