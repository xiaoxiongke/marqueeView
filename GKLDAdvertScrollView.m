#import "GKLDAdvertScrollView.h"
#import "UIImageView+WebCache.h"
#import "GKLDMarqueeStyleView.h"

#pragma mark - - - GKLDAdvertScrollView
@interface GKLDAdvertScrollView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation GKLDAdvertScrollView

static NSInteger const advertScrollViewMaxSections = 100;
static NSString *const advertScrollViewNormalCell = @"gkldAdvertScrollViewNormalCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
    [self setupSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
        [self setupSubviews];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self removeTimer];
    }
}

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (void)initialization {
    _scrollTimeInterval = 3.0;
    
    [self addTimer];
}

- (void)setBanners:(NSArray *)banners{
    _banners = banners;
    [self.collectionView reloadData];
}

- (void)setupSubviews {
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:tempView];
    [self addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[GKLDMarqueeStyleView class] forCellWithReuseIdentifier:advertScrollViewNormalCell];
    }
    return _collectionView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _collectionView.frame = self.bounds;
    
    if (self.banners.count > 1) {
        [self defaultSelectedScetion];
    }
}

- (void)defaultSelectedScetion {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0.5 * advertScrollViewMaxSections] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

#pragma mark - - - UICollectionView 的 dataSource、delegate方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return advertScrollViewMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.banners.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GKLDMarqueeStyleView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:advertScrollViewNormalCell forIndexPath:indexPath];
    cell.model = self.banners[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(advertScrollView:didSelectedItemAtIndex:)]) {
        [self.delegate advertScrollView:self didSelectedItemAtIndex:indexPath.item];
    }
}

#pragma mark - - - NSTimer
- (void)addTimer {
    [self removeTimer];

    self.timer = [NSTimer timerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(beginUpdateUI) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)beginUpdateUI {
    if (self.banners.count == 0) return;
    
    // 1、当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间那组的数据
    NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0.5 * advertScrollViewMaxSections];
    [self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];

    // 2、计算出下一个需要展示的位置
    NSInteger nextItem = resetCurrentIndexPath.item + 1;
    NSInteger nextSection = resetCurrentIndexPath.section;
    if (nextItem == self.banners.count) {
        nextItem = 0;
        nextSection++;
    }

    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];

    // 3、通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

- (void)setScrollTimeInterval:(CFTimeInterval)scrollTimeInterval {
    _scrollTimeInterval = scrollTimeInterval;
    if (scrollTimeInterval) {
        [self addTimer];
    }
}


@end
