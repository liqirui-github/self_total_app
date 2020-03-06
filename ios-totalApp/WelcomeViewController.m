//
//  WelcomeViewController.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/18.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "Masonry/Masonry.h"
//#import "SceneDelegate.h"
@interface WelcomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property UIImageView* prevView;
@end


@implementation WelcomeViewController

//使用布局设置 使引导页适应横屏  未达到预期效果。未显示的内容，在横竖屏切换时未全部自适应
//考虑在横竖屏切换时，先进行记录，再重新布局
//或者参考:  https://www.jb51.net/article/134519.htm 

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    self.scrollView=[[UIScrollView alloc]init];
//    [self.view addSubview:self.scrollView];
//
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//
//    self.scrollView.delegate=self;
////    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width*3, self.view.bounds.size.height) ;
//    self.scrollView.pagingEnabled=YES;
//    self.scrollView.showsVerticalScrollIndicator=NO;
//    self.scrollView.showsHorizontalScrollIndicator=NO;
//
//    for(int i=0;i<3;i++){
//        UIImageView *scrollImgView=[[UIImageView alloc]init];
//        [self.scrollView addSubview:scrollImgView];
//        [scrollImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_top);
//            make.bottom.equalTo(self.view.mas_bottom);
//            make.width.equalTo(self.view.mas_width);
//            if (i == 0)
//            {
//                make.left.equalTo(self.scrollView.mas_left);
//                self.prevView = scrollImgView;
//            }
//            else
//            {
//                make.left.equalTo(self.prevView.mas_right);
//                self.prevView = scrollImgView;
//            }
//
//        }];
//        NSString *imgName=[NSString stringWithFormat:@"0%d",i+1];  //格式转换，获取图片名称
//        scrollImgView.image=[UIImage imageNamed:imgName];
//
//        if(i==2){
//            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//            btn.backgroundColor=[UIColor clearColor];
//            [btn setTitle:@"开始浪起来吧" forState:UIControlStateNormal];
////            btn.frame=CGRectMake(80+self.view.bounds.size.width*2, self.view.bounds.size.height-200, self.view.bounds.size.width-160, 150);  //需要注意的是button距左边界的距离要加上self.view.bounds.size.width*4，即要加上前面四个页面
//            [btn addTarget:self action:@selector(jumpToLogin) forControlEvents:UIControlEventTouchUpInside];
//            [self.scrollView addSubview:btn];
//            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(scrollImgView);
//                make.bottom.equalTo(scrollImgView.mas_bottom).offset(-50);
//            }];
//        }
//    }
//
//    //考虑在进行旋转时，重新设定contentsize
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
////    [self.view addSubview:self.scrollView];
//
////    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-100)/2, self.view.bounds.size.height-50, 100, 30)];
//    self.pageControl=[[UIPageControl alloc]init];
//    [self.view addSubview:self.pageControl];
//
//    self.pageControl.currentPage=0;
//    self.pageControl.numberOfPages=2;
//    self.pageControl.currentPageIndicatorTintColor=[UIColor lightGrayColor];
//    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
//
//    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
//    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.delegate=self;
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width*3, self.view.bounds.size.height) ;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    for(int i=0;i<3;i++){
        //        self.pageControl.hidden=NO; //hidden代码写在这里无效
        CGFloat x=i*self.view.bounds.size.width;
        UIImageView *scrollImgView=[[UIImageView alloc]initWithFrame:CGRectMake(x, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        NSString *imgName=[NSString stringWithFormat:@"0%d",i+1];  //格式转换，获取图片名称
        scrollImgView.image=[UIImage imageNamed:imgName];
        [self.scrollView addSubview:scrollImgView];
        if(i==2){
            //            self.pageControl.hidden=YES;   //hidden代码写在这里无效
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//            UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
            btn.backgroundColor=[UIColor clearColor];
            [btn setTitle:@"开始浪起来吧" forState:UIControlStateNormal];
            btn.frame=CGRectMake(80+self.view.bounds.size.width*2, self.view.bounds.size.height-200, self.view.bounds.size.width-160, 150);  //需要注意的是button距左边界的距离要加上self.view.bounds.size.width*4，即要加上前面四个页面
            [btn addTarget:self action:@selector(jumpToLogin) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:btn];
        }
    }
    [self.view addSubview:self.scrollView];

    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-100)/2, self.view.bounds.size.height-50, 100, 30)];
    self.pageControl.currentPage=0;
    self.pageControl.numberOfPages=2;
    self.pageControl.currentPageIndicatorTintColor=[UIColor lightGrayColor];
    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
    [self.view addSubview:self.pageControl];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=self.scrollView.contentOffset.x;
    int page=(offset+self.view.bounds.size.width/2)/self.view.bounds.size.width;
    self.pageControl.currentPage=page;
    if(page==2){  //控制最后一页不显示pagecontroller
        self.pageControl.hidden=YES;
    }else{
        self.pageControl.hidden=NO;
    }
}
 
- (void)jumpToLogin {
    AppDelegate *myAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [myAppDelegate changeToLogin];  //调用跳转方法
    [myAppDelegate showHomeUI];  //调用跳转方法
    
    //sceneDelegate进行跳转
//    NSSet<UISceneSession*>  *sss = [UIApplication sharedApplication].openSessions;
//    UISceneSession* se;
//    int nNum = 0;
//    NSEnumerator * enumerator = [sss objectEnumerator];
//
//    while (se = [enumerator nextObject]) {
//        NSLog(@"num= %d, %@", ++nNum, se);
//        SceneDelegate* sd = (SceneDelegate*)[se scene].delegate;
//        [sd showHomeUI];
    //}
    
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
