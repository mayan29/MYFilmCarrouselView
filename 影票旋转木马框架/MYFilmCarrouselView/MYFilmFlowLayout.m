//
//  MYFilmFlowLayout.m
//  影票旋转木马框架
//
//  Created by mayan on 2016/11/18.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import "MYFilmFlowLayout.h"

#define CollectionW self.collectionView.bounds.size.width
#define ItemW self.itemSize.width

@interface MYFilmFlowLayout ()

@property (nonatomic) NSInteger visibleCount;

@end

@implementation MYFilmFlowLayout



// 什么时候调用：第一次布局、collectionView刷新
// 作用：计算cell布局（条件：cell的位置固定不变）
- (void)prepareLayout
{
    [super prepareLayout];
    
    if (self.visibleCount < 1) {
        self.visibleCount = 5;
    }
    
    
    CGFloat inset = CollectionW * 0.5 - ItemW * 0.5;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
}


// 作用：计算collectionView滚动范围
- (CGSize)collectionViewContentSize
{
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(cellCount * ItemW, CGRectGetHeight(self.collectionView.frame));
}


// 作用：返回一段区域内cell尺寸、一个UICollectionViewLayoutAttributes对象对应一个cell
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    CGFloat centerY = self.collectionView.contentOffset.x + CollectionW / 2;
    NSInteger index = centerY / ItemW;
    NSInteger count = (self.visibleCount - 1) / 2;
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN(([self.collectionView numberOfItemsInSection:0] - 1), (index + count));
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;
}



// 什么时候调用：手指一松开就会调用
// 作用：确定最终偏移量（最终偏移量不等于手指离开时偏移量、有惯性）
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat index = roundf((proposedContentOffset.x + CollectionW * 0.5 - ItemW * 0.5) / ItemW);
    
    proposedContentOffset.x = ItemW * index + ItemW * 0.5 - CollectionW * 0.5;
    
    return proposedContentOffset;
}




- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    
    CGFloat cY = self.collectionView.contentOffset.x + CollectionW / 2;
    CGFloat attributesY = ItemW * indexPath.row + ItemW / 2;
    attributes.zIndex = - ABS(attributesY - cY);
    
    CGFloat delta = cY - attributesY;
    CGFloat ratio =  - delta / (ItemW * 2);
    CGFloat scale = 1 - ABS(delta) / (ItemW * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    attributes.center = CGPointMake(attributesY, CGRectGetHeight(self.collectionView.frame) / 2);
    
    
    return attributes;
}




// MY:作用：在滚动时是否允许刷新布局、默认NO
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}


@end

















