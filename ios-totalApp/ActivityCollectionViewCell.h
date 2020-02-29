//
//  ActivityCollectionViewCell.h
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/26.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityCollectionViewCell : UICollectionViewCell

-(void)createUI:(ActivityModel*)model;

@end

NS_ASSUME_NONNULL_END
