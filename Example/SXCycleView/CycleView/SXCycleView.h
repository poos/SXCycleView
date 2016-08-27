//
//  CycleView.h
//  test
//
//  Created by n369 on 16/8/15.
//  Copyright © 2016年 n369. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickedImageBlock)(NSInteger currentIndex);

@interface SXCycleView : UITableViewCell

@property (nonatomic, assign) BOOL autoScroll;                //是否自动滚动,默认Yes
@property (nonatomic, assign) CGFloat autoScrollTimeInterval; //自动滚动间隔时间,默认5s

/**
 开放的 pageControl
 ! 可以set一个新的pageControl以替换
 ! 亦可简单重设frame
 ! 设置为nil即不显示
 */
@property (nonatomic, weak) UIPageControl *pageControl;

//image数组初始化
- (instancetype)initWithFrame:(CGRect)frame imageArrs:(NSArray<UIImage *> *)imageArr clickBlock:(ClickedImageBlock)block;
- (instancetype)initWithFrame:(CGRect)frame imageArrs:(NSArray<UIImage *> *)imageArr titles:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block;

//url数组初始化
- (instancetype)initWithFrame:(CGRect)frame imageUrlArrs:(NSArray<NSString *> *)urlArr clickBlock:(ClickedImageBlock)block;
- (instancetype)initWithFrame:(CGRect)frame imageUrlArrs:(NSArray<NSString *> *)urlArr titles:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block;

@end
