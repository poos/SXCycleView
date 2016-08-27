//
//  CycleCollectionCell.h
//  test
//
//  Created by n369 on 16/8/15.
//  Copyright © 2016年 n369. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)setCellImageIsUrlData:(NSDictionary *)dicData;
- (void)setCellData:(NSDictionary *)dicData;
@end
