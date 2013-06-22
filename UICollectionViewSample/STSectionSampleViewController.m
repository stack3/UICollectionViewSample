//
//  STSectionSampleViewController.m
//  UICollectionViewSample
//
//  Created by EIMEI on 2013/06/20.
//  Copyright (c) 2013 stack3.net. All rights reserved.
//

#import "STSectionSampleViewController.h"
#import "STCollectionItem.h"
#import "STCustomCollectionViewCell.h"
#import "STCustomCollectionSectionView.h"

@implementation STSectionSampleViewController {
    IBOutlet __weak UICollectionView *_collectionView;
    __strong NSMutableArray *_sections;
}

- (id)init
{
    self = [super initWithNibName:@"STSectionSampleViewController" bundle:nil];
    if (self) {
        self.title = @"Section";
        _sections = [NSMutableArray arrayWithCapacity:50];
        for (int j = 0; j < 5; j++) {
            NSMutableArray *items = [NSMutableArray arrayWithCapacity:10];
            for (int i = 0; i < 10; i++) {
                STCollectionItem *item = [[STCollectionItem alloc] init];
                item.number = i+1;
                item.caption = [NSString stringWithFormat:@"caption%d", item.number];
                [items addObject:item];
            }
            [_sections addObject:items];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"STCustomCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"CellId"];
    
    nib = [UINib nibWithNibName:@"STCustomCollectionSectionView" bundle:nil];
    [_collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Section"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *items = [_sections objectAtIndex:section];
    return items.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        STCustomCollectionSectionView *sectionView = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Section" forIndexPath:indexPath];
        sectionView.titleLabel.text = [NSString stringWithFormat:@"Section%d", indexPath.section + 1];
        return sectionView;
    } else {
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"CellId";
    STCustomCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    NSArray *items = [_sections objectAtIndex:indexPath.section];
    STCollectionItem *item = [items objectAtIndex:indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", item.number];
    cell.captionLabel.text = item.caption;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [_sections objectAtIndex:indexPath.section];
    STCollectionItem *item = [items objectAtIndex:indexPath.row];
    NSString *message = [NSString stringWithFormat:@"section:%d\n%d\n%@", indexPath.section+1, item.number, item.caption];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    [alertView show];
}

@end
