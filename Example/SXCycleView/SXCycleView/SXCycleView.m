//
//  CycleView.m
//  test
//
//  Created by xiaoR
//  github地址:https://github.com/poos/SXCycleView
//  无限轮播 任何问题可以前往留言

#import "SXCycleView.h"
#import "SXCellView.h"
#import "SXLinkList.h"

@interface SXCycleView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainView;

@property (nonatomic, strong) SXCellView *cellView0;
@property (nonatomic, strong) SXCellView *cellView1;
@property (nonatomic, strong) SXCellView *cellView2;

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
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _mainView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    _mainView.backgroundColor = [UIColor clearColor];
    _mainView.pagingEnabled = YES;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.delegate = self;
    _mainView.scrollsToTop = NO;
    [self addSubview:_mainView];
    
    _cellView0 = [[SXCellView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self controlView:_cellView0 data:_ptr.last];
    [_mainView addSubview:_cellView0];
    _cellView1 = [[SXCellView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self controlView:_cellView1 data:_ptr];
    [_mainView addSubview:_cellView1];
    _cellView2 = [[SXCellView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
    [self controlView:_cellView2 data:_ptr.next];
    [_mainView addSubview:_cellView2];
    
    [_mainView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    
    _dataCount == 1 ? [_mainView setScrollEnabled:NO] : [self setupTimer];
    _dataCount == 1 ? :[self createPageControl];
    
    UITapGestureRecognizer * tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBlockAction)];
    [self addGestureRecognizer:tapAction];
}

- (void)createPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 10 - 60, self.bounds.size.height - 10 - 20, 60, 20)];
    pageControl.numberOfPages = _dataCount;
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPage = _ptr.index;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)controlView:(SXCellView *)cellView data:(SXLinkList *)listPoint {
    if (_isLocalImage) {
        [cellView setCellData:listPoint.data];
    } else {
        [cellView setCellImageIsUrlData:listPoint.data];
    }
}

- (void)clickBlockAction {
    if (_cellClickblock) {
        _cellClickblock(_ptr.index);
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //tableViewCell的复用会延缓一点点时间,手动设置以防止没有复用的时候显示错误
    if (scrollView.contentOffset.x <= 0 || scrollView.contentOffset.x >= 2 * self.bounds.size.width) {
        if (!_isMove) {
            _isMove = YES;
            _nowPtr = _ptr;
        }
        
        if (scrollView.contentOffset.x <= 0) {
            _ptr = _nowPtr.last;
        } else {
            _ptr = _nowPtr.next;
        }
        [self controlView:_cellView0 data:_ptr.last];
        [self controlView:_cellView1 data:_ptr];
        [self controlView:_cellView2 data:_ptr.next];
        
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO]; //切换到下标1的cell
        _isMove = NO;
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
