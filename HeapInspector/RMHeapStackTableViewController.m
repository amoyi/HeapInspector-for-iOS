//
//  RMHeapStackTableViewController.m
//  HeapInspectorExample
//
//  Created by Christian Menschel on 23.08.14.
//  Copyright (c) 2014 tapwork. All rights reserved.
//

static NSString *const kTableViewCellIdent = @"kTableViewCellIdent";

#import "RMHeapStackTableViewController.h"
#import "RMHeapStackDetailTableViewController.h"

@interface RMHeapStackTableViewController ()

@end

@implementation RMHeapStackTableViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Close"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(closeButton:)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellIdent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdent
                                                            forIndexPath:indexPath];
    
    NSString *string = self.dataSource[indexPath.row];
    cell.textLabel.text = string;
    // TODO: use a custom cell later
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellValue = self.dataSource[indexPath.row];
    NSString *pointerValue = [self pointerStringFromCellText:cellValue];
    RMHeapStackDetailTableViewController *detailVC = nil;
    detailVC = [[RMHeapStackDetailTableViewController alloc] initWithPointerString:pointerValue];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Helper

- (NSString *)pointerStringFromCellText:(NSString *)cellText
{
    NSArray *components = [cellText componentsSeparatedByString:@": "];
    
    return [components lastObject];
}

@end