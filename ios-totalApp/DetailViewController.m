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

@interface DetailViewController ()
@property UIImageView* iv;
@property UILabel* lb;
@property StoreModel* sModel;
@property UIScrollView* pageSv;  //页面滚动区域
@property UIScrollView* iSv;  //图片滚动区域
//@property(nonatomic,assign) UIRectEdge edgesForExtendedLayout NS_AVAILABLE_IOS(7_0); // Defaults to UIRectEdgeAll
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.iv = [[UIImageView alloc] init];
    self.iv.backgroundColor = [UIColor redColor];
    self.iv.image = [UIImage imageNamed:self.sModel.storePhotoName];
    [self.view addSubview:self.iv];
    
    self.lb = [[UILabel alloc] init];
    self.lb.text = self.sModel.storeName;
    [self.view addSubview:self.lb];
    
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@200);
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
    }];
    
    [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iv.mas_left);
        make.top.equalTo(self.iv.mas_bottom).offset(0);
        make.right.equalTo(self.iv.mas_right);
        make.height.equalTo(@30);
    }];
    self.lb.backgroundColor = [UIColor purpleColor];
    
    UIBarButtonItem* bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pop)];
        self.navigationItem.leftBarButtonItem = bbi;
        
        UIBarButtonItem* hbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotoHome)];
        self.navigationItem.rightBarButtonItem = hbi;
    
    //self.navigationController.navigationBar.hidden = YES;
    //设置导航栏不遮挡view内容
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //创建两个UISCrollView，一个展示图片，一个放置图片的UIScrollView和用户信息列表
    //用户信息部分设置半透明，设置统一背景图片
    
    self.pageSv = [[UIScrollView alloc] init];
    self.iSv = [[UIScrollView alloc] init];
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
