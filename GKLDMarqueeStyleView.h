//
//  GKLDMarqueeStyleView.h
//  GKLD
//
//  Copyright © 2021 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
/// TODO: 模型头文件
#import "GKLDHomeBlockListModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 这是自定义的文字广告样式cell
@interface GKLDMarqueeStyleView : UICollectionViewCell

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *headerLabel;
@property (nonatomic,strong) UILabel *titleLabel;
/// TODO: 传入需要的模型
@property (nonatomic, strong) GKLDHomeBlockListDetailModel *model;

-(instancetype)initWithFrame:(CGRect)frame Model:(GKLDHomeBlockListDetailModel *)model;

//@property (nonatomic, copy) void (^marqueeItemClick)(GKLDHomeBlockListDetailModel *model);
@end

NS_ASSUME_NONNULL_END
