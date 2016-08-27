# SXCycleView

![view](https://github.com/poos/SXCycleView/blob/master/Untitled.gif "")

###a. pod 'SXCycleView'
else you can Download to use it, look Example for help

###b. import SXCycleView.h

```
[[SXCycleView alloc] initWithFrame:CGRectMake(10, 200, 300, 200)
                                              imageUrlArrs:@[  ]
                                                    titles:@[  ]
                                                clickBlock:^(NSInteger currentIndex) {
                                                    NSLog(@"%ld", currentIndex);
                                                }]];
