//
//  SGLoadMoreView.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/29.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "SGLoadMoreView.h"

@implementation SGLoadMoreView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"frame x= %lf, y = %lf, width=%lf, height=%lf",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityView.color = [UIColor redColor];
        self.activityView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:self.activityView];
        self.activityView.hidden = NO;
//        [self.activityView startAnimating];
        _tipsLabel = [[UILabel alloc] initWithFrame:frame];
        _tipsLabel.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        _tipsLabel.text = @"没有更多数据";
        _tipsLabel.hidden = YES;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor blackColor];
        _tipsLabel.font = [UIFont systemFontOfSize:14.0];
//        _tipsLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:_tipsLabel];
//        self.backgroundColor =[UIColor redColor];
    }
    
    return self;
}

- (void)startAnimation
{
    _tipsLabel.hidden = YES;
    _activityView.hidden = NO;
    [_activityView startAnimating];
}

- (void)stopAnimation
{
    if (_activityView.isAnimating == NO)
    {
        return;
    }

    _activityView.hidden = YES;
    [_activityView stopAnimating];
}

- (BOOL)isAnimating
{
    BOOL isAni = _activityView.isAnimating;
    return isAni;
}

- (void)noMoreData
{
    _activityView.hidden = YES;
    _tipsLabel.hidden = NO;
}

-(void)restartLoadData
{
    _tipsLabel.hidden = YES;
}

@end































