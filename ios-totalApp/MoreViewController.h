//
//  MoreViewController.h
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/27.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreViewController : UIViewController
@property NSMutableArray* foodArray;
@property NSMutableArray* storeArray;
@property(assign, nonatomic) NSInteger startNo;  //数据起始位置
@property(assign, nonatomic) NSInteger stopNo;  //数据结束位置
@end

NS_ASSUME_NONNULL_END
