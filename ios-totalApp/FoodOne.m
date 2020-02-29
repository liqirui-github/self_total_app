//
//  FoodOne.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/20.
//  Copyright © 2020 李其瑞. All rights reserved.
//
#define MAINSCREENWIDTH [UIScreen mainScreen].bounds.size.width

#import <Foundation/Foundation.h>
#import "FoodOne.h"

@implementation FoodOne

- (instancetype)initWithFrame:(CGRect)frame{ //重写方法
    self= [super initWithFrame: frame];  //先初始化父类的方法
    if(self){
        [self creatUI]; //写自己定义的方法
    }
    return  self;
}
 
-(void)creatUI{
    self.foodPhoto=[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-70)*0.5, 10, 70, 70)];
    [self addSubview:self.foodPhoto];
    self.foodNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, _foodPhoto.frame.size.height+16, self.frame.size.width, 16)];
    self.foodNameLabel.textColor = [UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1.0];
    self.foodNameLabel.font = [UIFont systemFontOfSize:12];
    self.foodNameLabel.textAlignment=NSTextAlignmentCenter;
    //NSTextAlignmentRight
    [self addSubview:self.foodNameLabel];
}
 
-(void)setFoodOne:(FoodModel *)foodModel{
    self.foodNameLabel.text=foodModel.foodName;
    self.foodPhoto.image=[UIImage imageNamed:foodModel.foodPhotoName];
}
@end




















































