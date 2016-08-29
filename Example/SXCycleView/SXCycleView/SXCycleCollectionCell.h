//
//  CycleCollectionCell.h
//  test
//
//  Created by xiaoR
//  github地址:https://github.com/poos/SXCycleView
//  无限轮播 任何问题可以前往留言

#import <UIKit/UIKit.h>

@interface SXCycleCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)setCellImageIsUrlData:(NSDictionary *)dicData;
- (void)setCellData:(NSDictionary *)dicData;
@end
