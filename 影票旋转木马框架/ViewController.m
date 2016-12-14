//
//  ViewController.m
//  影票旋转木马框架
//
//  Created by mayan on 2016/11/18.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "MYFileCollectionCell.h"
#import "MYFileCollectionView.h"

#define JHScreenBounds [UIScreen mainScreen].bounds
#define JHScreenW JHScreenBounds.size.width

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) MYFileCollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    MYFileCollectionView *view = [MYFileCollectionView viewWithFrame:CGRectMake(0, 200, JHScreenW, 120) itemSize:CGSizeMake(85, 120)];
    view.delegate = self;
    view.dataSource = self;
    [self.view addSubview:view];
    
    _collectionView = view;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYFileCollectionCell *cell = [MYFileCollectionCell cellWithCollectionView:collectionView indexPath:indexPath];
        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [MYFileCollectionView scrollWithCollectionView:collectionView indexPath:indexPath];
    
    NSLog(@"选择了第%ld个item",indexPath.row);
}

// 滚动停止,设置背景图片
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *path = [MYFileCollectionView indexWithCollectionView:self.collectionView];

    NSLog(@"选择了第%ld个item",path.row);
}


@end
