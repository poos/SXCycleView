# SXCycleView

#图片效果可以点开上边的Untitled.gif查看,太晃眼了

###a. pod 'SXCycleView'

###b. import SXCycleView.h

```
[[SXCycleView alloc] initWithFrame:CGRectMake(10, 200, 300, 200)
                                              imageUrlArrs:@[  ]
                                                    titles:@[  ]
                                                clickBlock:^(NSInteger currentIndex) {
                                                    NSLog(@"%ld", currentIndex);
                                                }]];
```
