//
//  FoodTableViewCell.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/20.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MAINSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#import "FoodTableViewCell.h"
#import "FoodOne.h"
//#import "FoodModel.h"
@implementation FoodTableViewCell
 
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
 
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray *)array{
    //重写父类的方法，自定义的方法记得在.h文件中声明
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        for(int i=0;i<8;i++){ //用for循环实现八个模块的生成，注意上下的边界不同，所以用if语句分成两种情况
            if(i<4){
                FoodOne *food=[[FoodOne alloc]initWithFrame:CGRectMake( i* (MAINSCREENWIDTH-0)/4, 0, (MAINSCREENWIDTH-0)/4, 100)];
                
                [self.contentView addSubview:food];
                [food setFoodOne:array[i]];
                
            }else{
                FoodOne *food=[[FoodOne alloc]initWithFrame:CGRectMake( (i-4)* (MAINSCREENWIDTH-0)/4, 110, (MAINSCREENWIDTH-0)/4, 100)];
                [self.contentView addSubview:food];
                [food setFoodOne:array[i]];
            }
        }
    }
    return self;
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 
    // Configure the view for the selected state
}


@end
