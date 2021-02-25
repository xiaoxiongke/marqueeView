//
//  GKLDMarqueeStyleView.h
//  GKLD
//
//  Created by 向宇涛 on 2021/1/21.
//  Copyright © 2021 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKLDHomeBlockListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GKLDMarqueeStyleView : UICollectionViewCell

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *headerLabel;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic, strong) GKLDHomeBlockListDetailModel *model;

-(instancetype)initWithFrame:(CGRect)frame Model:(GKLDHomeBlockListDetailModel *)model;

//@property (nonatomic, copy) void (^marqueeItemClick)(GKLDHomeBlockListDetailModel *model);
@end

NS_ASSUME_NONNULL_END
