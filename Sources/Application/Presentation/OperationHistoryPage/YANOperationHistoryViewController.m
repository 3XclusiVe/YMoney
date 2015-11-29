//
//  YANOperationHistoryViewController.m
//  YMoney
//
//  Created by Дмитрий on 25.10.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YANOperationHistoryViewController.h"
#import "YANOperationDetailsView.h"
#import "YANOperationDateView.h"

@interface YANOperationHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *operationHistory;
@property (weak, nonatomic) IBOutlet UITabBarItem *operationHistoryButton;

@end

@implementation YANOperationHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell:[YANOperationDateView class]];
    [self registerCell:[YANOperationDetailsView class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YANOperationDetailsView class]) forIndexPath:indexPath];

    return cell;
}


#pragma mark - Private methods

-(void) registerCell:(Class) class {
     [_operationHistory registerNib:[UINib nibWithNibName:NSStringFromClass(class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(class)];
}


@end
