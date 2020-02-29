//
//  ActivityCollectionViewCell.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/26.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "ActivityCollectionViewCell.h"
#import "ActivityModel.h"
#import "Masonry/Masonry.h"

@implementation ActivityCollectionViewCell

-(void)createUI:(ActivityModel*)model
{
    UIView* bv = [[UIView alloc] init];
    [self.contentView addSubview:bv];
    
    //50*50
    UIImageView* iv = [[UIImageView alloc] init];

//    UIImageView* iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    iv.image = [UIImage imageNamed:model.activityPhoto];
    
    //给图片加圆角
    //方案1、该方案会强制Core Animation提前渲染屏幕的离屏绘制, 而离屏绘制就会给性能带来负面影响
//    iv.layer.cornerRadius = 25.0f;
//    iv.layer.masksToBounds = YES;
    
    
        
    [bv addSubview:iv];
    
    UILabel* nl = [[UILabel alloc] init];
    nl.text = model.activityName;
    [bv addSubview:nl];
    [nl setFont:[UIFont systemFontOfSize:13.0]];
    
    UILabel* dl = [[UILabel alloc] init];
    dl.text = model.activityDetail;
    [bv addSubview:dl];
    [dl setFont:[UIFont systemFontOfSize:11.0]];
    dl.textColor = [UIColor colorWithRed:194/255.0 green:180/255.0 blue:114/255.0 alpha:1.0];
    
    [bv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //设置约束
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bv.mas_top).offset((self.frame.size.height - 50)*0.5);
        make.left.equalTo(bv.mas_left).offset(15);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [nl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iv.mas_top);
        make.left.equalTo(iv.mas_right).offset(10);
        make.right.equalTo(bv.mas_right).offset(-10);
        make.height.equalTo(@20);
    }];
    
    [dl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nl.mas_bottom).offset(5);
        make.left.equalTo(nl.mas_left);
        make.right.equalTo(nl.mas_right);
        make.height.equalTo(@20);
    }];
    
//    self.backgroundColor = [UIColor purpleColor];
//    self.contentView.backgroundColor = [UIColor blackColor];
    
    //方案二 暂未理解，无效果，c猜测是要继承UIImage
//    UIImage* image = [UIImage imageNamed:model.activityPhoto];
//    UIGraphicsBeginImageContextWithOptions(iv.frame.size, NO, 0.0);
//    
//    // 获得上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 添加一个圆
//    CGRect rect = CGRectMake(0, 0, iv.frame.size.width, iv.frame.size.height);
//    CGContextAddEllipseInRect(ctx, rect);
//    // 裁剪
//    CGContextClip(ctx);
//    
//    // 将图片画上去
//    [image drawInRect:rect];
//    iv.image = UIGraphicsGetImageFromCurrentImageContext();
//    // 关闭上下文
//    UIGraphicsEndImageContext();
    
    
    //方案3:使用贝塞尔曲线"切割"个这个图片, 给UIImageView 添加了的圆角，其实也是通过绘图技术来实现的。

    UIImage* image = [UIImage imageNamed:model.activityPhoto];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 50), NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(iv.frame.origin.x, iv.frame.origin.y, 50, 50) cornerRadius:10] addClip];
    [image drawInRect:CGRectMake(iv.frame.origin.x, iv.frame.origin.y, 50, 50)];
    iv.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}

//-(UIImage*)cicleImage:(NSString*)name
//{
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 50), NO, 0.0);
//
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGRect rect = CGRectMake(0, 0, 50, 50);
//    CGContextAddEllipseInRect(ctx, rect);
//    CGContextClip(ctx);
//    [self ];
//
//    UIGraphicsEndImageContext();
//}

@end
