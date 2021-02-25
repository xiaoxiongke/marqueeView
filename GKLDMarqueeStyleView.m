//
//  GKLDMarqueeStyleView.m
//  GKLD
//
//  Copyright © 2021 Mac. All rights reserved.
//

#import "GKLDMarqueeStyleView.h"
@interface GKLDMarqueeStyleView()
@property (nonatomic,strong) UIView *headerBackgroundView;

@end
@implementation GKLDMarqueeStyleView

- (instancetype)init{
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame Model:(GKLDHomeBlockListDetailModel *)model{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        self.model = model;
    }
    return self;
}

- (void)setModel:(GKLDHomeBlockListDetailModel *)model{
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"ic_ad_welfare"]];
    self.headerLabel.text = model.name;
    self.titleLabel.text = model.title;
}

//-(void)itemClickAction{
//    if (self.marqueeItemClick) {
//        self.marqueeItemClick(self.model);
//    }
//}

- (void)setUpUI{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction)];
//    [self addGestureRecognizer:tap];
    
    CGFloat horizonMargin = 12*AutoScaleWidth;
    CGFloat verticalmargin = 8*AutoScaleWidth;
    CGFloat height = 30*AutoScaleWidth;
    CGFloat spacing = 4*AutoScaleWidth;
    
    self.headerBackgroundView = [[UIView alloc] init];
    self.headerBackgroundView.backgroundColor = UIColorFromRGB(245, 245, 245);
    
    [self addSubview:self.headerBackgroundView];
    [self.headerBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(horizonMargin);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(height);
    }];
    
    [self.headerBackgroundView addSubview:self.iconView];
    [self.headerBackgroundView addSubview:self.headerLabel];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerBackgroundView).offset(10*AutoScaleWidth);
        make.centerY.equalTo(self.headerBackgroundView);
        make.width.height.mas_equalTo(18*AutoScaleWidth);
    }];
    
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(spacing);
        make.centerY.height.equalTo(self.iconView);
        make.right.equalTo(self.headerBackgroundView).offset(-8*AutoScaleWidth);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerBackgroundView.mas_right).offset(verticalmargin);
        make.right.equalTo(self).offset(-horizonMargin);
        make.top.bottom.equalTo(self.headerBackgroundView);
    }];
    
    [self.headerLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.headerLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    self.headerBackgroundView.layer.cornerRadius = 16;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.textColor = UIColorRGB51;
        _headerLabel.font = [UIFont systemFontOfSize:14];
        _headerLabel.text = @"";
    }
    return _headerLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColorRGB51;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}


@end
