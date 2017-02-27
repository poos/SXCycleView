# SXCycleView 轮播图

####博客文章地址https://my.oschina.net/bieshixuan/blog/789622

####!!!因为苹果CollectionView回收机制更改,所以改用了ScrollView,更快速,更节省内存!!!

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
```

任何问题欢迎留言

![轮播图](https://github.com/poos/SXCycleView/blob/master/Untitled.gif "轮播图")
 
  
   

使用collectionView可以很方便的创建轮播图,并且利用collectionViewCell的复用,很方便的管理,原理也很简单

a,把轮播图的元数据扩大,123123123...123123123

b,创建视图把初始位置设置为中间点

c,处理滚动到头时候


##.自己的想法和优雅的点子

####想法1,数据源的读取并不优雅

数据源是个很明显的双向循环,这个结构跟以前"听说"的双向链表那么的契合,为什么不使用双向链表作为数据源呢

####想法2,collection设置99999整的好么,表示我是一个崇尚优雅的猿

本来就是轮播嘛,滑动的时候怎么左右滚,划,总不会需要超过3个的cell吧

##Then->
假如我有一个链表,假如我只使用3个cell,那么我可以写成一个循环滚动的轮播图吗

###原理应该是
每次滑动结束之后就回到中间的那一张

左划3个cell的数据源整体向左,右划类推
