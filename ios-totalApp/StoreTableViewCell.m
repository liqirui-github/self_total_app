//
//  StoreTableViewCell.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/27.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "StoreTableViewCell.h"
#import "StoreModel.h"
#import "Masonry/Masonry.h"

@interface StoreTableViewCell()
{
    UIImageView* view;
    UILabel* storeNameLabel;
    UILabel* storeDistanceLabel;
    UILabel* storeDeliveryCostLabel;
}
@end

@implementation StoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    self->view = [[UIImageView alloc] init];
    [self.contentView addSubview:self->view];
    
    self->storeNameLabel = [[UILabel alloc] init];
    self->storeNameLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self->storeNameLabel];
    
    self->storeDistanceLabel = [[UILabel alloc] init];
    self->storeDistanceLabel.font = [UIFont systemFontOfSize:15];
    self->storeDistanceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self->storeDistanceLabel];
    
    self->storeDeliveryCostLabel = [[UILabel alloc] init];
    self->storeDeliveryCostLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self->storeDeliveryCostLabel];
    
    [self->view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(-(self.contentView.frame.size.height - 80)*0.5);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    
    [self->storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->view.mas_right).offset(10);
        make.top.equalTo(self->view.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@20);
    }];
    
    [self->storeDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->storeNameLabel.mas_left);
        make.right.equalTo(self->storeNameLabel.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(self->storeNameLabel.mas_bottom).offset(10);
    }];
    
    [self->storeDeliveryCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->storeNameLabel.mas_left);
        make.right.equalTo(self->storeNameLabel.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(self->storeDistanceLabel.mas_bottom).offset(10);
    }];
    
}

-(void)setStoreModel:(StoreModel*)model
{
    self->view.image = [UIImage imageNamed:model.storePhotoName];
    self->storeNameLabel.text = model.storeName;
    self->storeDistanceLabel.text = model.storeDistance;
    self->storeDeliveryCostLabel.text = model.storeDeliveryCost;
    
    self->view.layer.cornerRadius = 40.0;
    self->view.layer.masksToBounds = YES;
    
//    UIImage* image = [UIImage imageNamed:model.storePhotoName];
////    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 50), NO, 1.0);
//    UIGraphicsBeginImageContextWithOptions(self->view.frame.size, NO, 1.0);
////    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(iv.frame.origin.x, iv.frame.origin.y, 50, 50) cornerRadius:50] addClip];
//    [[UIBezierPath bezierPathWithRoundedRect:self->view.bounds cornerRadius:50] addClip];
////    [image drawInRect:CGRectMake(iv.frame.origin.x, iv.frame.origin.y, 50, 50)];
//    [image drawInRect:self->view.bounds];
//    self->view.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
}

@end
