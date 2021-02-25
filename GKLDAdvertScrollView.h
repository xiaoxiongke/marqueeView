//  GKLD
//
//  Copyright © 2021 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKLDAdvertScrollView;

@protocol GKLDAdvertScrollViewDelegate <NSObject>
/// delegate 方法
- (void)advertScrollView:(GKLDAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index;
@end

@interface GKLDAdvertScrollView : UIView
#pragma mark - - - 公共 API
/** delegate */
@property (nonatomic, weak) id<GKLDAdvertScrollViewDelegate> delegate;
/** 滚动时间间隔，默认为3s */
@property (nonatomic, assign) CFTimeInterval scrollTimeInterval;
/// 模型数组
@property (nonatomic,strong) NSArray *banners;
@end
