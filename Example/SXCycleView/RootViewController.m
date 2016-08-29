//
//  RootViewController.m
//  SXCycleView
//
//  Created by n369 on 16/8/27.
//  Copyright © 2016年 SX. All rights reserved.
//

#import "RootViewController.h"
#import "SXCycleView.h"

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    [self.view addSubview:[SXCycleView initWithFrame:CGRectMake(10, 200, 300, 200)
                                              imageUrlArrs:@[ @"http://f.hiphotos.baidu.com/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=5a86654bae345982d187edc06d9d5ac8/f2deb48f8c5494ee3d44fe262ef5e0fe99257eaf.jpg", @"http://h.hiphotos.baidu.com/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=6058a406ca3d70cf58f7a25f99b5ba65/34fae6cd7b899e5110d5cc2b41a7d933c8950db1.jpg", @"http://g.hiphotos.baidu.com/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=b34606e657da81cb5aeb8b9f330fbb73/eac4b74543a98226d1d4c5358c82b9014a90eb8f.jpg" ]
                                                    titles:@[ @"1111", @"2222", @"3333" ]
                                                clickBlock:^(NSInteger currentIndex) {
                                                    NSLog(@"%ld", currentIndex);
                                                }]];
}

@end
