//
//  SGLoadMoreView.h
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/29.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGLoadMoreView : UIView//UICollectionReusableView
@property (nonatomic, retain) UIActivityIndicatorView* activityView;
@property (nonatomic, retain) UILabel* tipsLabel;

- (void)startAnimation;
- (void)stopAnimation;
- (BOOL)isAnimating;
- (void)noMoreData;
- (void)restartLoadData;

@end

NS_ASSUME_NONNULL_END
