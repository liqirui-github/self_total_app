//
//  StoreTableViewCell.h
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/27.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreTableViewCell : UITableViewCell

-(void)setStoreModel:(StoreModel*)model;
@end

NS_ASSUME_NONNULL_END
