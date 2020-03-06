//
//  DetailViewController.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/29.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "DetailViewController.h"
#import "Masonry/Masonry.h"
#import "StoreModel.h"
#import "MenuView.h"
#import "MessageUI/MessageUI.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"

@interface DetailViewController ()<MFMessageComposeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property UIImageView* iv;
@property UILabel* lb;
@property StoreModel* sModel;
@property UIScrollView* pageSv;  //页面滚动区域
@property UIScrollView* iSv;  //图片滚动区域
@property MenuView* mv;
@property UIImagePickerController* ipc;
@property MPMoviePlayerViewController* mvPlayer;
//@property(nonatomic,assign) UIRectEdge edgesForExtendedLayout NS_AVAILABLE_IOS(7_0); // Defaults to UIRectEdgeAll
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem* bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pop)];
        self.navigationItem.leftBarButtonItem = bbi;
        
        UIBarButtonItem* hbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotoHome)];
        self.navigationItem.rightBarButtonItem = hbi;
    
    //self.navigationController.navigationBar.hidden = YES;
    //设置导航栏不遮挡view内容
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.pageSv = [[UIScrollView alloc] init];

    self.pageSv.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.pageSv];

//    self.iSv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.8)];
    self.iSv = [[UIScrollView alloc] init];
    [self.pageSv addSubview:self.iSv];
    self.iSv.backgroundColor = [UIColor redColor];

    [self.pageSv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];

    //在使用约束时，测试isv滚动区域无法和pagesv滚动区域建立top的约束关系
    //猜测是否是因为pagesv滚动时，内部的isv的top压根就无法和它有约束关系？？？？？
    [self.iSv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(@0);
        //equalto传入的是对象不是值，以下两种方式都可以
//        make.height.equalTo(@(self.view.frame.size.height));
        make.height.equalTo([NSNumber numberWithFloat:self.view.frame.size.height*0.8]);
        }];

    self.pageSv.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    
    self.iv = [[UIImageView alloc] init];
    [self.iSv addSubview:self.iv];
    //获取图片尺寸 后期可根据图片真实尺寸灵活控制iv和isv的frame
    CGSize imageSize = [UIImage imageNamed:self.sModel.storePhotoName].size;
    self.iv.image = [UIImage imageNamed:self.sModel.storePhotoName];
    
    //创建约束时尽量避开滚动区域内参照物
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(@0);
        make.height.equalTo(@((self.view.frame.size.width/imageSize.width)* imageSize.height));
    }];
    
    self.iSv.contentSize = CGSizeMake(self.view.frame.size.width,(self.view.frame.size.width/imageSize.width)* imageSize.height);
    
    //此处测试pagesv滚动区域是否生效
    self.lb = [[UILabel alloc] init];
    [self.pageSv addSubview:self.lb];
    
    [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iSv.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@65);
    }];
    //放开UILabel文本行数限制
    self.lb.numberOfLines = 0;
    self.lb.text = [NSString stringWithFormat:@"%@\n%@",self.sModel.storeName,self.sModel.storeDeliveryCost];
    self.lb.backgroundColor = [UIColor blueColor];
    self.lb.textAlignment = NSTextAlignmentCenter;
    self.lb.textColor = [UIColor systemPinkColor];
    
    //设置悬浮按钮，打电话，发短信，视频观看，打开相册
    UIButton *sbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    sbutton.backgroundColor = [UIColor clearColor];
    [sbutton setBackgroundImage:[UIImage imageNamed:@"touch"] forState:UIControlStateNormal];
    [self.pageSv addSubview:sbutton];
    [sbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.iSv);
        make.centerY.equalTo(self.iSv).offset(150);
    }];
    
    [sbutton addTarget:self action:@selector(showOrHideMenu) forControlEvents:(UIControlEventTouchUpInside)];
    
    //绘制背景透明的圆形区域，放置在按钮上方
    self.mv = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    
    [self.pageSv addSubview:self.mv];
    [self.mv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@320);
        make.height.equalTo(@200);
        make.centerX.equalTo(sbutton.mas_centerX);
//        make.centerY.equalTo(self.iSv).offset(-150);
        make.bottom.equalTo(sbutton.mas_top).offset(-5);
    }];
//    self.mv.hidden = YES;
}

//
-(void)showOrHideMenu
{
    if (self.mv.isHidden == YES)
    {
//        self.mv.hidden = NO;
        [self.mv showWithAnimation];
    }
    else
    {
        [self.mv hideWithAnimation];
//        self.mv.hidden = YES;
    }
}

//返回上一级页面
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//返回主界面
-(void)gotoHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setStoreModel:(StoreModel*)model
{
    self.sModel = model;
}

-(void)showMessage
{
    MFMessageComposeViewController* con = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText])
    {
        con.messageComposeDelegate = self;
        con.recipients = @[@"18951603146"];
        con.body = @"货已到，速来";
        con.subject = @"好消息";
    }
    [self presentViewController:con animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    //发送完信息就回到程序
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(void)openPhotoLibrary
{
    if (!self.ipc)
    {
        self.ipc = [[UIImagePickerController alloc] init];
        self.ipc.delegate = self;
        //设置照片是否可编辑
        self.ipc.allowsEditing = NO;
    }
    
    self.ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.ipc animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    //打开相册，选择图片 需要打开工程里的相册使用权限，可直接在info.plist文件中添加，需要添加UIImagePickerControllerDelegate,UINavigationControllerDelegate协议
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* img = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.iv.image = img;
}

-(void)playVideo
{
    NSString* webUrl = @"http://movie.ks.js.cn/flv/other/1_0.flv";
//    _mvPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:webUrl]];
//    [self presentViewController:self.mvPlayer animated:YES completion:nil];
    
    //视频播放使用AVPlayerViewController，需要添加AVKit/AVKit.h和AVFoundation/AVFoundation.h
    AVPlayerViewController* play = [[AVPlayerViewController alloc] init];
    play.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:webUrl]];
    [self presentViewController:play animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
