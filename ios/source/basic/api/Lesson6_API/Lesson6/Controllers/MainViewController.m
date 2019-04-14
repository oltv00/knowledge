//
//  MainViewController.m
//  Lesson6
//
//  Created by Oleg Tverdokhleb on 24.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MainViewController.h"
#import "APIManager.h"

@interface MainViewController () <APIManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *array;
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialize];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupInitialize {
    _array = [NSMutableArray array];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]
                              initWithFrame:self.view.frame
                              style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark - APIManagerDelegate

-(void)getAdvice:(NSDictionary *)advice {
    [_array addObject:advice[@"text"]];
    [_tableView reloadData];
}

#pragma mark - Action

- (IBAction)actionAddAdvice:(UIBarButtonItem *)sender {
    [[APIManager managerWithDelegate:self] getRandomAdvice];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _array[indexPath.row];
    
    return cell;
}


@end
