//
//  CycleView.m
//  test
//
//  Created by xiaoR
//  github地址:https://github.com/poos/SXCycleView
//  无限轮播 任何问题可以前往留言

#import "SXCycleView.h"
#import "SXCycleCollectionCell.h"
#import "SXLinkList.h"

@interface SXCycleView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, assign) BOOL isMove;
@property (nonatomic, assign) BOOL isLocalImage;
@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, strong) SXLinkList *ptr;
@property (nonatomic, strong) SXLinkList *nowPtr;
@property (nonatomic, copy) ClickedImageBlock cellClickblock;
//轮播
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) NSTimer *timer;

@end

static NSString *const image = @"imageKey";
static NSString *const title = @"titleKey";

@implementation SXCycleView

#pragma mark-------------------set方法----
- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self setupTimer];
    }
}

- (void)setPageControl:(UIPageControl *)pageControl {
    [_pageControl removeFromSuperview];
    _pageControl = nil;
    _pageControl = pageControl;
    _pageControl.numberOfPages = _dataCount;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPage = _ptr.index;
    [self addSubview:_pageControl];
}

- (void)setShowPageControl:(BOOL)showPageControl {
}

#pragma mark-------------------初始化方法----
//image数组初始化
+ (instancetype)initWithFrame:(CGRect)frame imageArrs:(NSArray<UIImage *> *)imageArr clickBlock:(ClickedImageBlock)block {
    return [[self alloc] initWithFrame:frame isLocalImage:YES imgArrs:imageArr titArr:nil clickBlock:block];
}
+ (instancetype)initWithFrame:(CGRect)frame imageArrs:(NSArray<UIImage *> *)imageArr titles:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block {
    return [[self alloc] initWithFrame:frame isLocalImage:YES imgArrs:imageArr titArr:titleArr clickBlock:block];
}

//url数组初始化
+ (instancetype)initWithFrame:(CGRect)frame imageUrlArrs:(NSArray<NSString *> *)urlArr clickBlock:(ClickedImageBlock)block {
    return [[self alloc] initWithFrame:frame isLocalImage:NO imgArrs:urlArr titArr:nil clickBlock:block];
}
+ (instancetype)initWithFrame:(CGRect)frame imageUrlArrs:(NSArray<NSString *> *)urlArr titles:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block {
    return [[self alloc] initWithFrame:frame isLocalImage:NO imgArrs:urlArr titArr:titleArr clickBlock:block];
}

- (instancetype)initWithFrame:(CGRect)frame isLocalImage:(BOOL)isLocalImage imgArrs:(NSArray *)urlArr titArr:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _isLocalImage = isLocalImage;
        _dataCount = urlArr.count;
        _cellClickblock = block;
        _totalItemsCount = urlArr.count;
        
        NSMutableArray *dataArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < urlArr.count; i++) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
            [dic setObject:urlArr[i] forKey:image];
            if (titleArr == nil || titleArr == (NSArray *) [NSNull null]) {
                [dic setObject:@"" forKey:title];
            } else {
                [dic setObject:titleArr[i] forKey:title];
            }
            [dataArr addObject:dic];
        }
        _ptr = [SXLinkList createLinkListWithURLsArray:dataArr];
        
        [self initData];
        [self createView];
    }
    return self;
}

- (void)initData {
    _isMove = NO;
    _nowPtr = nil;
    _autoScroll = YES;
    _autoScrollTimeInterval = 5.f;
}

- (void)createView {
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0.f;
    _flowLayout.minimumInteritemSpacing = 0.f;
    _flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:_flowLayout];
    _mainView.backgroundColor = [UIColor clearColor];
    _mainView.pagingEnabled = YES;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    [_mainView registerClass:[SXCycleCollectionCell class] forCellWithReuseIdentifier:@"SXCycleCollectionCell"];
    _mainView.dataSource = self;
    _mainView.delegate = self;
    _mainView.scrollsToTop = NO;
    [self addSubview:_mainView];
    [_mainView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    
    _dataCount == 1 ? [_mainView setScrollEnabled:NO] : [self setupTimer];
    _dataCount == 1 ? :[self createPageControl];
}

- (void)createPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 10 - 60, self.bounds.size.height - 10 - 20, 60, 20)];
    pageControl.numberOfPages = _dataCount;
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPage = _ptr.index;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

#pragma mark------------------ UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SXCycleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SXCycleCollectionCell" forIndexPath:indexPath];
    
    if (!_isMove) {
        _isMove = YES;
        _nowPtr = _ptr;
    }
    if (indexPath.row == 0) {
        _ptr = _nowPtr.last;
    } else if (indexPath.row == 2) {
        _ptr = _nowPtr.next;
    }
    if (_isLocalImage) {
        [cell setCellData:_ptr.data];
    } else {
        [cell setCellImageIsUrlData:_ptr.data];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellClickblock) {
        _cellClickblock(_ptr.index);
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //tableViewCell的复用会延缓一点点时间,手动设置以防止没有复用的时候显示错误
    if (scrollView.contentOffset.x <= 0 || scrollView.contentOffset.x >= 2 * self.bounds.size.width) {
        _isMove = NO;                                                                     //重置是否移动
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO]; //切换到下标1的cell
        //更新cell的值(滑动过快时候cell没有回收复用)
        SXCycleCollectionCell *cell = (SXCycleCollectionCell *) [self.mainView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        if (_isLocalImage) {
            [cell setCellData:_ptr.data];
        } else {
            [cell setCellImageIsUrlData:_ptr.data];
        }
        _pageControl.currentPage = _ptr.index;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoScroll) {
        [self setupTimer];
    }
}

#pragma mark - actions

- (void)setupTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll {
    if (0 == _totalItemsCount) return;
    [_mainView setContentOffset:CGPointMake(self.bounds.size.width * 2, 0) animated:YES];
}

- (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}

@end
