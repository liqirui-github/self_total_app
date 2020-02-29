//
//  FoodOne.h
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/20.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>
#import "FoodModel.h"

@interface FoodOne : UIView
@property UIImageView* foodPhoto;
@property UILabel* foodNameLabel;
-(void)setFoodOne:(FoodModel*)foodModel;

@end

