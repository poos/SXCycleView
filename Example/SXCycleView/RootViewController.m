//
//  RootViewController.m
//  SXCycleView
//
//  Created by n369 on 16/8/27.
//  Copyright © 2016年 SX. All rights reserved.
//

#import "RootViewController.h"
#import "CycleView.h"

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    [self.view addSubview:[[CycleView alloc] initWithFrame:CGRectMake(10, 200, 300, 200)
                                              imageUrlArrs:@[ @"http://img.blog.csdn.net/20150803132715185", @"http://cdn.n369.com/Fsmo4o905DQau3Io9MblvTfuNh1S", @"http://cdn.n369.com/Fl7NLayrRVJOTx6gBagD9aDPTnOM" ]
                                                    titles:@[ @"1111", @"2222", @"3333" ]
                                                clickBlock:^(NSInteger currentIndex) {
                                                    NSLog(@"%ld", currentIndex);
                                                }]];
}

@end
