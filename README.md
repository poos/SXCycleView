# SXCycleView

![view](https://github.com/poos/SXCycleView/blob/master/Untitled.gif "")

### you can use
###pod 'SXCycleView', '~> 1.0.0'
else you can Download to use it, look Example for help

Then, you should :
###import SXCycleView.h

```
[[SXCycleView alloc] initWithFrame:CGRectMake(10, 200, 300, 200)
                                              imageUrlArrs:@[  ]
                                                    titles:@[  ]
                                                clickBlock:^(NSInteger currentIndex) {
                                                    NSLog(@"%ld", currentIndex);
                                                }]];
