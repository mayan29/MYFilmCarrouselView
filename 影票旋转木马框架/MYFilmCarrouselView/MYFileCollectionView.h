//
//  MYFileCollectionView.h
//  影票旋转木马框架
//
//  Created by mayan on 2016/11/21.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYFileCollectionView : UICollectionView


// 初始化
+ (instancetype)viewWithFrame:(CGRect)frame itemSize:(CGSize)size;

// 滚动到指定item
+ (void)scrollWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

// 返回需展示的item的indexPath
+ (NSIndexPath *)indexWithCollectionView:(UICollectionView *)collectionView;

@end
