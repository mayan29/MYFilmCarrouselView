//
//  MYFileCollectionCell.m
//  影票旋转木马框架
//
//  Created by mayan on 2016/11/18.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import "MYFileCollectionCell.h"

@interface MYFileCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation MYFileCollectionCell


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
}



@end
