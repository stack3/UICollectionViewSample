//
//  STViewController.m
//  UICollectionViewSample
//
//  Created by EIMEI on 2013/06/20.
//  Copyright (c) 2013 stack3.net. All rights reserved.
//

#import "STViewController.h"
#import "STCollectionViewSampleController.h"
#import "STCollectionViewControllerSampleController.h"
#import "STSectionSampleViewController.h"
#import "STSpacingSampleViewController.h"

typedef enum {
    _STMenuItemCollectionViewSample,
    _STMenuItemCollectionViewControllerSample,
    _STMenuItemSectionSample,
    _STMenuItemSpacingSample,
} _STMenuItems;

@implementation STViewController {
    __weak IBOutlet UITableView *_tableView;
    __strong NSMutableArray *_menuItems;
}

- (id)init
{
    self = [super initWithNibName:@"STViewController" bundle:nil];
    if (self) {
        self.title = @"Menu";
        
        _menuItems = [NSMutableArray arrayWithCapacity:10];
        [_menuItems addObject:@"UICollectionView"];
        [_menuItems addObject:@"UICollectionViewController"];
        [_menuItems addObject:@"Section"];
        [_menuItems addObject:@"Spacing"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"CellId";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSString *menuItem = [_menuItems objectAtIndex:indexPath.row];
    cell.textLabel.text = menuItem;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _STMenuItemCollectionViewSample) {
        STCollectionViewSampleController *con = [[STCollectionViewSampleController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    } else if (indexPath.row == _STMenuItemCollectionViewControllerSample) {
        STCollectionViewControllerSampleController *con = [[STCollectionViewControllerSampleController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    } else if (indexPath.row == _STMenuItemSectionSample) {
        STSectionSampleViewController *con = [[STSectionSampleViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    } else if (indexPath.row == _STMenuItemSpacingSample) {
        STSpacingSampleViewController *con = [[STSpacingSampleViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }
}

@end
