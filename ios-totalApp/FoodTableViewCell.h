//
//  FoodTableViewCell.h
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/20.
//  Copyright © 2020 李其瑞. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface FoodTableViewCell: UITableViewCell
//@property NSMutableArray* _foodArray;
//重写自定义cell的initWithStyle:reuseIdentifier方法，可以不需要注册tableviewcell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray *)array;
@end
