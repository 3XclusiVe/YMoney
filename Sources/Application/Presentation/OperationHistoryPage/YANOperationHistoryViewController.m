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
#import "YMAHistoryOperationModel+NSCoding.h"
#import "YANOperationDetailsView+YMAHistoryOperationModel.h"
#import "YANHashStorage.h"

@interface YANOperationHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *operationHistory;
@property (weak, nonatomic) IBOutlet UITabBarItem *operationHistoryButton;
@property (strong, nonatomic) NSMutableArray<YMAHistoryOperationModel*> *operations;
@property (strong, nonatomic) NSMutableDictionary<NSDateComponents*, NSMutableArray<YMAHistoryOperationModel*>*> *sections;

@end

@implementation YANOperationHistoryViewController {
    UIRefreshControl *_refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell:[YANOperationDateView class]];
    [self registerCell:[YANOperationDetailsView class]];
    [self addRefreshController:@selector(responceLastOperations)];
    self.operationHistory.estimatedRowHeight = 80;
    self.operationHistory.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self onInternetConnectionLost];
    [self responceLastOperations];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YMAHistoryOperationModel* operation = self.operations[indexPath.section];
    
    YANOperationDetailsView *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YANOperationDetailsView class]) forIndexPath:indexPath];
    
    [cell configureWithOperation:operation];
    
    return cell;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.operations.count;
}


-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    YMAHistoryOperationModel* operation = self.operations[section];
    NSDateComponents * date = [self convertToDayDate:operation.datetime];
    NSInteger year = [date year];
    NSInteger month = [date month];
    NSInteger day = [date day];
    return [NSString stringWithFormat:@"%d-%d-%d", day, month, year];
}

/**
 * для использования refreshcontrollвнизу
 **/
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    scrollView.contentOffset.y;
//    [self.operationHistory indexPathsForVisibleRows];
//}

#pragma mark - Group in sections

-(NSDateComponents *) convertToDayDate:(NSDate *) date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    return components;
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
    [[YANHashStorage sharedInstance] saveOperationHistory:operations];
    
}

-(void) onReceiveNextOperations:(NSArray *)operations {
    [self.operations addObjectsFromArray:operations];
    [self updateRepresentation];
}

-(void) onInternetConnectionLost {
    self.operations = [[[YANHashStorage sharedInstance] loadOperationHistory] mutableCopy];
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
