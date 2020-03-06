//
//  MenuView.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/3/1.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "MenuView.h"
#import "MessageUI/MessageUI.h"
#import "DetailViewController.h"

#define toRad(angle) ((angle) * M_PI / 180)

@interface MenuView()<MFMessageComposeViewControllerDelegate>
@property (nonatomic, assign) CGPoint dotCenter;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat pointLenth;
@property (nonatomic, strong) NSArray *stateArray;
@property (nonatomic, strong) CALayer *pointLayer;

@end

@implementation MenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dotCenter = CGPointMake(frame.size.width/2.0, frame.size.height-30);
        self.radius = frame.size.height - 150;
//        self.pointLenth = self.radius;
        self.stateArray = @[@"拨号", @"短信", @"相册",@"观看"];
        
//        //贝塞尔曲线画一个圆
//        UIBezierPath *piePath = [UIBezierPath bezierPath];
//        [piePath addArcWithCenter:self.dotCenter radius:10 startAngle:0 endAngle:2*M_PI clockwise:YES];
//
//        CAShapeLayer *pieShapeLayer = [[CAShapeLayer alloc] init];
//        pieShapeLayer.strokeColor = nil;
//        pieShapeLayer.fillColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:122/255.0f alpha:1.0f].CGColor;
//        pieShapeLayer.path = [piePath CGPath];;
//        [self.layer addSublayer:pieShapeLayer];
        self.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.0f];
        
        //使用label画圆
        for (NSInteger i=0; i<4; i++) {
            CGFloat startAngle = -180 + 60*i;
            CGPoint labelCenter = [self pointWithAngle:toRad(startAngle) radius:self.radius + 30];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            label.center = labelCenter;
            label.font = [UIFont systemFontOfSize:14];
            label.backgroundColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:122/255.0f alpha:1.0f];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = self.stateArray[i];
            label.layer.cornerRadius = 20;
            label.layer.masksToBounds = YES;
            [label setTag:i+10];
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDidClick:)]];
//            label.hidden = YES;
            label.alpha = 0.0f;
            [self addSubview:label];
        }
        
//        UIButton* button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        button.center = CGPointMake(60, 50);
//        [self addSubview:button];
//
//        [button addTarget:self action:@selector(showWithAnimation) forControlEvents:UIControlEventTouchUpInside];
//
//        UIButton* sbutton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        sbutton.center = CGPointMake(20, 50);
//        [self addSubview:sbutton];
//
//        [sbutton addTarget:self action:@selector(hideWithAnimation) forControlEvents:UIControlEventTouchUpInside];
        
        self.hidden = YES;
    }
    
    return self;
}

-(void)labelDidClick:(UIGestureRecognizer*)recongnizer
{
    //此处应该判空的
    UILabel* label = (UILabel*)recongnizer.view;
    NSLog(@"label tag: %ld", label.tag);
    switch (label.tag) {
        case 10:
        {
            //拨号
            //方式一  UIWebView已废弃
//            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"189****3146"];
//            UIWebView* Webview = [[UIWebView alloc] init];
//            [Webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//            [self addSubview:Webview];
            
            //方式二 openURL已废弃  telprompt协议无法通过上架审核**
            //NSURL *url = [NSURL URLWithString:@"telprompt://189****3146"];
            //[[UIApplication sharedApplication] openURL:url];
                
            //方式三 推荐
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://189****3146"] options:@{} completionHandler:nil];
        }
            break;
        case 11:
            //短信
        {
           
             for (UIView* next = [self superview]; next; next = next.superview) {
                 UIResponder *nextResponder = [next nextResponder];
                 if ([nextResponder isKindOfClass:[DetailViewController class]]) {
                     [(DetailViewController *)nextResponder showMessage];
                     break;
                 }
             }
            //需要添加MessageUI/MessageUI.h头文件和MFMessageComposeViewControllerDelegate协议，并且需要引入MessageUI.framework框架
            //引入MessageUI.framework步骤：TARGETS-》Build phases -〉Link Binary With Libraries-》点击添加按钮，搜索后添加
            //此处无法在该view中发起短信，已回传到其视图控制器层***
//            MFMessageComposeViewController* con = [[MFMessageComposeViewController alloc] init];
//            if ([MFMessageComposeViewController canSendText])
//            {
//                con.messageComposeDelegate = self;
//                con.recipients = @[@"18951603146"];
//                con.body = @"货已到，速来";
//                con.subject = @"好消息";
//            }
//            [self.inputAccessoryViewController presentViewController:con animated:YES completion:nil];
            
            //方式二 无法回到app中
//           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://189****3146"] options:@{} completionHandler:nil];
        }
            break;
        case 12:
            //打开相册
        {
            for (UIView* next = [self superview]; next; next = next.superview) {
                UIResponder *nextResponder = [next nextResponder];
                if ([nextResponder isKindOfClass:[DetailViewController class]]) {
                    [(DetailViewController *)nextResponder openPhotoLibrary];
                    break;
                }
            }
        }
            break;
        case 13:
            //观看视频
        {
            for (UIView* next = [self superview]; next; next = next.superview) {
                UIResponder *nextResponder = [next nextResponder];
                if ([nextResponder isKindOfClass:[DetailViewController class]]) {
                    [(DetailViewController *)nextResponder playVideo];
                    break;
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    //发送完信息就回到程序
    [self.inputAccessoryViewController dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
//            [HUD showHUDMessage:@"发送成功"];
            break;
        case MessageComposeResultFailed:
//            [HUD showHUDMessage:@"发送失败"];
            break;
        case MessageComposeResultCancelled:
//            [HUD showHUDMessage:@"取消发送"];
            break;
        default:
            break;
    }
}

-(void)showWithAnimation
{
    self.hidden = NO;
//    [UIView animateWithDuration:2 animations:^{
//        for (int tag = 0; tag < 4; tag++)
//        {
//            UILabel* label = (UILabel*)[self viewWithTag:tag+10];
//            if (label != nil)
//            {
////                label.hidden = NO;
//                label.alpha = 1.0f;
//            }
//        }
//    }];
    
    
//    for (int tag = 0; tag < 4; tag++)
//    {
//        UILabel* label = (UILabel*)[self viewWithTag:tag+10];
//        if (label != nil)
//        {
//            [UIView animateWithDuration:1 animations:^{
////                label.hidden = NO;
//                label.alpha = 1.0f;
//            }];
//        }
//    }
    
    [UIView animateWithDuration:0.3 animations:^{
        UILabel* label = (UILabel*)[self viewWithTag:10];
        if (label != nil)
        {
            label.alpha = 1.0f;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            UILabel* label = (UILabel*)[self viewWithTag:11];
            if (label != nil)
            {
                label.alpha = 1.0f;
            }
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                UILabel* label = (UILabel*)[self viewWithTag:12];
                if (label != nil)
                {
                    label.alpha = 1.0f;
                }
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    UILabel* label = (UILabel*)[self viewWithTag:13];
                    if (label != nil)
                    {
                        label.alpha = 1.0f;
                    }
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}

-(void)hideWithAnimation
{
//    [UIView animateWithDuration:3 animations:^{
//        for (int tag = 0; tag < 4; tag++)
//        {
//            UILabel* label = (UILabel*)[self viewWithTag:tag+10];
//            if (label != nil)
//            {
//                //label.hidden = YES;
//                label.alpha = 0.0f;
//            }
//        }
//    }];
    
//    for (int tag = 0; tag < 4; tag++)
//    {
//        UILabel* label = (UILabel*)[self viewWithTag:tag+10];
//        if (label != nil)
//        {
//            [UIView animateWithDuration:1 animations:^{
//                //label.hidden = YES;
//                label.alpha = 0.0f;
//            }];
//        }
//    }
    
    [UIView animateWithDuration:0.3 animations:^{
        UILabel* label = (UILabel*)[self viewWithTag:10];
        if (label != nil)
        {
            label.alpha = 0.0f;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            UILabel* label = (UILabel*)[self viewWithTag:11];
            if (label != nil)
            {
                label.alpha = 0.0f;
            }
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                UILabel* label = (UILabel*)[self viewWithTag:12];
                if (label != nil)
                {
                    label.alpha = 0.0f;
                }
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    UILabel* label = (UILabel*)[self viewWithTag:13];
                    if (label != nil)
                    {
                        label.alpha = 0.0f;
                    }
                } completion:^(BOOL finished) {
                    self.hidden = YES;
                }];
            }];
        }];
    }];
    
    //动画在执行隐藏时为延时生效
//    [UIView animateWithDuration:3 animations:^{
//
//    } completion:^(BOOL finished) {
//        self.hidden = YES;
//    }];
//    self.hidden = YES;
    
    //[self performSelector:@selector(hideSelf) withObject:nil afterDelay:0.5];
}

- (CGPoint)pointWithAngle:(CGFloat)angle radius:(CGFloat)radius {
    CGFloat x = self.dotCenter.x + cosf(angle) * radius;
    CGFloat y = self.dotCenter.y + sinf(angle) * radius;
    return CGPointMake(x, y);
}

@end
