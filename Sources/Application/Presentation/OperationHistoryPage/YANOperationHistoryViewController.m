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
#import "YANYandexMoneyServer.h"
#import "YMAHistoryOperationModel.h"
#import "YANOperationDetailsView+YMAHistoryOperationModel.h"

@interface YANOperationHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *operationHistory;
@property (weak, nonatomic) IBOutlet UITabBarItem *operationHistoryButton;
@property (strong, nonatomic) NSMutableArray<YMAHistoryOperationModel*> *operations;

@end

@implementation YANOperationHistoryViewController {
    UIRefreshControl *_refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell:[YANOperationDateView class]];
    [self registerCell:[YANOperationDetailsView class]];
    [self addRefreshController:@selector(responceLastOperations)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self responceLastOperations];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.operations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YMAHistoryOperationModel* operation = self.operations[indexPath.row];
    
    YANOperationDetailsView *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YANOperationDetailsView class]) forIndexPath:indexPath];
    
    [cell configureWithOperation:operation];

    return cell;
}


#pragma mark - Private methods

-(void) updateRepresentation {
    [self.operationHistory reloadData];
    [_refreshControl endRefreshing];
}

-(void) responceLastOperations {
    [self.yandexMoneyServer performOperationHistoryRequest];
}

-(void) responceNextOperations {
    [self.yandexMoneyServer requestNextOperations];
}

-(void) onReceiveLastOperations:(NSArray *)operations {
    self.operations = [operations mutableCopy];
    [self updateRepresentation];
}

-(void) onReceiveNextOperations:(NSArray *)operations {
    [self.operations addObjectsFromArray:operations];
    [self updateRepresentation];
}

-(void) onInternetConnectionLost {
    [self updateRepresentation];
}

-(void) registerCell:(Class) class {
    [_operationHistory registerNib:[UINib nibWithNibName:NSStringFromClass(class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(class)];
}

-(void) addRefreshController:(SEL)selector {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    [_operationHistory addSubview:_refreshControl];
}
@end
