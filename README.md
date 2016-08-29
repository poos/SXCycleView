# SXCycleView 轮播图

####图片效果可以点开上边的Untitled.gif查看,太晃眼了所以没有往下边放

###a. 使用pod 'SXCycleView' 导入最新包
或者下载文件,SXCycleView文件夹下的文件加入工程即可,注意工程用到了SDWebImage


###b. import SXCycleView.h

```
//最新版本改为类方法
[SXCycleView initWithFrame:CGRectMake(10, 200, 300, 200)
              imageUrlArrs:@[  ]
                    titles:@[  ]
                clickBlock:^(NSInteger currentIndex) {
                    NSLog(@"%ld", currentIndex);
                }]];
``

任何问题欢迎留言
或者发邮箱bieshixuan@163.com
