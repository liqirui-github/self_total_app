//
//  MyButton.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/26.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.customSpace = self.customSpace ? self.customSpace : 2;
    
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
    [self.titleLabel sizeToFit];
    
    CGRect labelFrame = self.titleLabel.frame;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    labelFrame.origin.x = (self.frame.size.width - self.customSpace - labelFrame.size.width - 12)*0.5;
//    labelFrame.origin.y = (self.frame.size.height - labelFrame.size.height)*0.5;
//    self.titleLabel.frame = labelFrame;
//    self.titleLabel.backgroundColor = [UIColor grayColor];
//
//    CGRect imageFrame = CGRectMake(labelFrame.origin.x+self.customSpace +labelFrame.size.width, (self.frame.size.height-12)*0.5, 12, 12);
//    NSLog(@"y:%f height:%f ",self.frame.origin.y, self.frame.size.height);
//    self.imageView.frame = imageFrame;
    
    
    CGRect imageFrame = CGRectMake(self.frame.size.width - 10, (self.frame.size.height-8)*0.5, 10, 10);
    self.imageView.frame = imageFrame;
    
    labelFrame.origin.x = imageFrame.origin.x-self.customSpace - labelFrame.size.width;
    labelFrame.origin.y = (self.frame.size.height - labelFrame.size.height)*0.5;
    self.titleLabel.frame = labelFrame;
    self.titleLabel.textAlignment = NSTextAlignmentRight;
}

@end
