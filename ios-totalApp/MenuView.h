//
//  MenuView.h
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/3/1.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuView : UIView
@property (nonatomic, assign) CGFloat value;
-(void)showWithAnimation;
-(void)hideWithAnimation;

@end

NS_ASSUME_NONNULL_END
