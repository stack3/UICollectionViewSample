//
//  STCollectionViewSampleController.m
//  UICollectionViewSample
//
//  Created by EIMEI on 2013/06/20.
//  Copyright (c) 2013 stack3.net. All rights reserved.
//

#import "STCollectionViewSampleController.h"
#import "STCollectionItem.h"
#import "STCustomCollectionViewCell.h"

@implementation STCollectionViewSampleController {
    IBOutlet __weak UICollectionView *_collectionView;
    __strong NSMutableArray *_items;
}

- (id)init
{
    self = [super initWithNibName:@"STCollectionViewSampleController" bundle:nil];
    if (self) {
        self.title = @"UICollectionView";
        _items = [NSMutableArray arrayWithCapacity:50];
        for (int i = 0; i < 50; i++) {
            STCollectionItem *item = [[STCollectionItem alloc] init];
            item.number = i+1;
            item.caption = [NSString stringWithFormat:@"caption%d", item.number];
            [_items addObject:item];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"STCustomCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"CellId"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STCustomCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];

    STCollectionItem *item = [_items objectAtIndex:indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", item.number];
    cell.captionLabel.text = item.caption;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    STCollectionItem *item = [_items objectAtIndex:indexPath.row];
    NSString *message = [NSString stringWithFormat:@"%d\n%@", item.number, item.caption];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    [alertView show];
}

@end
