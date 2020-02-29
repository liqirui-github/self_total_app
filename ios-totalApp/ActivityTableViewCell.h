//
//  ActivityTableViewCell.h
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/26.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
//@property(nonatomic,strong)ActivityModel* aModel;
@property(nonatomic,strong)NSMutableArray* modelArray;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray*)array;

@end

NS_ASSUME_NONNULL_END
