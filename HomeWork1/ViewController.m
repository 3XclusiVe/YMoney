//
//  ViewController.m
//  HomeWork1
//
//  Created by Дмитрий on 12.10.15.
//  Copyright (c) 2015 DMA. All rights reserved.
//


#import "ViewController.h"
#import "AuthorizationViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (weak, nonatomic) IBOutlet UIButton *createWalletButton;

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //if([segue.identifier isEqualToString:@"shwAuthorizationView"]){
    
        AuthorizationViewController *controller = segue.destinationViewController;
        
        controller.delegate = self;

    //}
}

// Implement the delegate methods for ChildViewControllerDelegate
- (void)childViewController:(AuthorizationViewController *)viewController didChooseValue:(CGFloat)value {
    
    [self.enterButton setTitle:@"Попробовать войти еще раз" forState:UIControlStateNormal];
    
    // ...then dismiss the child view controller
    [self.navigationController popViewControllerAnimated:YES];
}

@end