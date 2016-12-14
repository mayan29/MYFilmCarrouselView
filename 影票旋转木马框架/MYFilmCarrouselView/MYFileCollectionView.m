//
//  MYFileCollectionView.m
//  影票旋转木马框架
//
//  Created by mayan on 2016/11/21.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import "MYFileCollectionView.h"
#import "MYFilmFlowLayout.h"
#import "MYFileCollectionCell.h"

@interface MYFileCollectionView ()

@end

@implementation MYFileCollectionView


+ (instancetype)viewWithFrame:(CGRect)frame itemSize:(CGSize)size
{
    MYFilmFlowLayout *layout = [[MYFilmFlowLayout alloc] init];
    layout.itemSize = size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    MYFileCollectionView *view = [[MYFileCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [view registerNib:[UINib nibWithNibName:NSStringFromClass([MYFileCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    view.showsHorizontalScrollIndicator = NO;

    return view;
}


+ (void)scrollWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    MYFileCollectionCell *cell = (MYFileCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect newFrame = [cell convertRect:cell.bounds toView:[UIApplication sharedApplication].keyWindow];
    CGFloat centerX = newFrame.origin.x + newFrame.size.width * 0.5;
    CGFloat contentOffsetX = collectionView.contentOffset.x - [UIApplication sharedApplication].keyWindow.bounds.size.width * 0.5 + centerX;
    [collectionView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
}


+ (NSIndexPath *)indexWithCollectionView:(UICollectionView *)collectionView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    
    for (MYFileCollectionCell *cell in collectionView.visibleCells) {
        
        CGRect frame = [cell convertRect:cell.bounds toView:[UIApplication sharedApplication].keyWindow];
        CGFloat x = [UIScreen mainScreen].bounds.size.width * 0.5 - cell.bounds.size.width * 0.5;
        
        if (frame.origin.x < (x + 10) && frame.origin.x > (x - 10)) {
            
            path = [collectionView indexPathForCell:cell];
            break;
        }
    }
    return path;
}


@end
