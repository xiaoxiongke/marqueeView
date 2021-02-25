//
//  GKLDHomeMarqueeViewCell.m
//  GKLD
//
//  Copyright © 2021 Mac. All rights reserved.
//

#import "GKLDHomeMarqueeViewCell.h"
#import "GKLDHomeBlockListModel.h"
#import "GKLDMarqueeStyleView.h"
#import "GKLDAdvertScrollView.h"

@interface GKLDHomeMarqueeViewCell()<GKLDAdvertScrollViewDelegate>

@property (nonatomic,strong) GKLDAdvertScrollView *bannerView;
@property (nonatomic,strong) GKLDHomeBlockListModel *model;

@end

@implementation GKLDHomeMarqueeViewCell


-(void)ld_baseBindModel:(GKLDBaseModel *)_model
{
    //  TODO: 数据处理
    // 这里是数据赋值
    if ([_model isKindOfClass:[GKLDHomeBlockListModel class]]) {
        GKLDHomeBlockListModel *model = (GKLDHomeBlockListModel *)_model;
        self.model = model;
        self.bannerView.banners = model.list;
    }
}


- (void)ld_setupContentSubView{
    //  TODO: 布局marqueeView
    // 比如:这里是cell内部的文字滚动广告
    CGFloat height = 30*AutoScaleWidth;
    
    GKLDAdvertScrollView *bannerView = [[GKLDAdvertScrollView alloc] init];
    bannerView.delegate = self;
    
    [self.contentView addSubview:bannerView];
    self.bannerView = bannerView;
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(GKLDGeneralMargin12*AutoScaleWidth);
        make.bottom.equalTo(self.contentView).offset(-GKLDGeneralMargin12*AutoScaleWidth);
        make.height.mas_equalTo(height);
    }];
}

#pragma mark - delegate
- (void)advertScrollView:(GKLDAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    //  TODO: 点击事件处理
}


@end
