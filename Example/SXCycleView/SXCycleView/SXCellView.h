//
//  SXCellView.h
//  SXCycleView
//
//  Created by n369 on 2017/2/27.
//  Copyright © 2017年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXCellView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;


- (void)setCellImageIsUrlData:(NSDictionary *)dicData;
- (void)setCellData:(NSDictionary *)dicData;

@end
