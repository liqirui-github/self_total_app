//
//  ViewController.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/18.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "ViewController.h"
#import "FoodTableViewCell.h"
#import "FoodModel.h"
#import "Masonry/Masonry.h"
#import "MyButton.h"
#import "ActivityTableViewCell.h"
#import "StoreModel.h"
#import "ActivityModel.h"
#import "StoreTableViewCell.h"
#import "MoreViewController.h"
#import "OtherTestViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong) UIPageControl* pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIView* view = [[UIView alloc] init];
//    UILabel* label = [[UILabel alloc] init];
//    [label setText:@"hello world"];
//    label.textColor = [UIColor greenColor];
//    view.backgroundColor = [UIColor redColor];
//    view.frame = self.view.frame;
//    label.frame = CGRectMake((self.view.frame.size.width-120)/2, (self.view.frame.size.height-40)/2, 120, 40);
//    [view addSubview:label];
//    [self.view addSubview:view];
//    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 9, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    
    UITableView* tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 9, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    tv.delegate = self;
    tv.dataSource = self;
    
    [self.view addSubview:tv];
    
//    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREENWIDTH, 230)]; //设置frame
    UIScrollView* sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 210)];
    sv.delegate = self;
    sv.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*6, 210);
    sv.pagingEnabled = YES;
    sv.showsVerticalScrollIndicator = NO;
    sv.showsHorizontalScrollIndicator = NO;
    
    NSMutableArray* ma = [[NSMutableArray alloc] initWithObjects:@"01.png",@"02.png",@"03.png",@"04.png",@"05.png",@"06.png", nil];
    for (int i = 0; i < 6; i++)
    {
        CGFloat x = [UIScreen mainScreen].bounds.size.width*i;
        UIImageView* scrollImage = [[UIImageView alloc] init];
        scrollImage.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, 210);
        scrollImage.image = [UIImage imageNamed:ma[i]];
        [sv addSubview:scrollImage];
    }
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width -100)*0.5, 180, 100, 20)];
    self.pageControl.currentPage=0;  //当前页面是0
    self.pageControl.numberOfPages=6; //总共6个图片
    
    tv.tableHeaderView = sv;
    [tv addSubview:sv];
    [tv addSubview:self.pageControl];
    [self setTitle:@"首页"];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self initData];
    
    self.view.backgroundColor = [UIColor blackColor];
    //    self.navigationController.navigationBar.backgroundColor = [UIColor purpleColor];
    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1];
}

-(void)initData
{
    FoodModel *food1 = [[FoodModel alloc] init];
        food1.foodPhotoName = @"01";
        food1.foodName = @"上海";
        FoodModel *food2 = [[FoodModel alloc] init];
        food2.foodPhotoName = @"02";
        food2.foodName = @"南京";
        FoodModel *food3 = [[FoodModel alloc] init];
        food3.foodPhotoName = @"03";
        food3.foodName = @"杭州";
        FoodModel *food4 = [[FoodModel alloc] init];
        food4.foodPhotoName = @"04";
        food4.foodName = @"北京";
        FoodModel *food5 = [[FoodModel alloc] init];
        food5.foodPhotoName = @"05";
        food5.foodName = @"深圳";
        FoodModel *food6 = [[FoodModel alloc] init];
        food6.foodPhotoName = @"06";
        food6.foodName = @"长沙";
        FoodModel *food7 = [[FoodModel alloc] init];
        food7.foodPhotoName = @"07";
        food7.foodName = @"吉林";
        FoodModel *food8 = [[FoodModel alloc] init];
        food8.foodPhotoName = @"08";
        food8.foodName = @"成都";
        
        self.foodArray=[[NSMutableArray alloc]initWithObjects:food1,food2,food3,food4,food5,food6,food7,food8, nil];
    
    ActivityModel* model1 = [[ActivityModel alloc] init];
    model1.activityName =@"年度榜";
    model1.activityPhoto = @"01";
    model1.activityDetail = @"奖金50万";
    
    ActivityModel* model2 = [[ActivityModel alloc] init];
    model2.activityName =@"季度榜";
    model2.activityPhoto = @"02";
    model2.activityDetail = @"奖金30万";
    
    ActivityModel* model3 = [[ActivityModel alloc] init];
    model3.activityName =@"月度榜";
    model3.activityPhoto = @"03";
    model3.activityDetail = @"奖金20万";
    
    self.activityArray = [[NSMutableArray alloc] initWithObjects:model1, model2, model3, nil];
    
    StoreModel* smodel1 = [[StoreModel alloc] init];
    smodel1.storePhotoName = @"05";
    smodel1.storeName = @"上海m2";
    smodel1.storeDistance = @"168cm 55kg 本科";
    smodel1.storeDeliveryCost = @"实时价格 ¥8000";
    
    StoreModel* smodel2 = [[StoreModel alloc] init];
    smodel2.storePhotoName = @"06";
    smodel2.storeName = @"北京天上人间";
    smodel2.storeDistance = @"172cm 58kg 本科";
    smodel2.storeDeliveryCost = @"暂无价格信息";
    
    StoreModel* smodel3 = [[StoreModel alloc] init];
    smodel3.storePhotoName = @"07";
    smodel3.storeName = @"南京1912";
    smodel3.storeDistance = @"163cm 50kg 本科";
    smodel3.storeDeliveryCost = @"实时价格 ¥5000";
    
    StoreModel* smodel4 = [[StoreModel alloc] init];
    smodel4.storePhotoName = @"08";
    smodel4.storeName = @"杭州火知了";
    smodel4.storeDistance = @"172cm 57kg 本科";
    smodel4.storeDeliveryCost = @"实时价格 ¥6000";
    
    StoreModel* smodel5 = [[StoreModel alloc] init];
    smodel5.storePhotoName = @"09";
    smodel5.storeName = @"长沙解放西路";
    smodel5.storeDistance = @"172cm 55kg 硕士";
    smodel5.storeDeliveryCost = @"实时价格 ¥4800";
    
    self.storeArray = [[NSMutableArray alloc] initWithObjects:smodel1, smodel2,smodel3,smodel4,smodel5,nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    int page = (offset + [UIScreen mainScreen].bounds.size.width/2)/[UIScreen mainScreen].bounds.size.width;
    self.pageControl.currentPage = page;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rn;
    if (2 == section)
    {
        rn = 5;
    }
    else
    {
        rn = 1;
    }
    return rn;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"item"];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"item"];
//    }
    static NSString* identifier = @"identifier";
    if (indexPath.section == 0)
    {
//        FoodTableViewCell* cell = (FoodTableViewCell*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        FoodTableViewCell* cell = (FoodTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier withArray:self.foodArray];
        }
        return cell;
    }
    else if (indexPath.section == 1)
    {
//        NSLog(@"step 1");
        ActivityTableViewCell* cell = (ActivityTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"activity"];
//        NSLog(@"step 2");
        if (cell == nil)
        {
//            NSLog(@"step 3");
            cell = [[ActivityTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activity" withArray:self.activityArray];
        }
//        NSLog(@"step 4");
        return cell;
    }
    else if (indexPath.section == 2)
    {
        StoreTableViewCell* cell = (StoreTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"store"];
        if (cell == nil)
        {
            cell = [[StoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"store"];
        }
        [cell setStoreModel:[_storeArray objectAtIndex:indexPath.item]];
        
        return cell;
    }
    else
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"unknown"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 120;
    if (indexPath.section == 0)
    {
        height = 230;
    }
    else if (indexPath.section == 1)
    {
        height = 70;
    }
    
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == 0)
    {
        height = 30;
    }
    else if (section == 1)
    {
        height = 30;
    }
    return height;
}


//-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
////    if (section == 0)
////    {
////
////    }
////    else
////    {
////
////    }
//}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = nil;
    if (section == 0)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        view.backgroundColor = [UIColor redColor];
        UILabel* titleLab = [[UILabel alloc] init];
        [titleLab setText:@"推荐"];
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.font = [UIFont systemFontOfSize:12];
//        titleLab.tintColor = [UIColor whiteColor];
        titleLab.textColor = [UIColor whiteColor];
//        titleLab.backgroundColor = [UIColor whiteColor];
        [view addSubview:titleLab];
        
//        UIButton* moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
//        [view addSubview:moreBtn];
        MyButton* moreBtn = [[MyButton alloc] init];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        moreBtn.backgroundColor = [UIColor blackColor];
        [view addSubview:moreBtn];
//        UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01"]];
        [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(showMore) forControlEvents:UIControlEventTouchUpInside];
//        NSLog(@"view height：%f", view.frame.size.height);
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@75);
            make.height.equalTo(@15);
            make.left.equalTo(view.mas_left).offset(5);
        make.top.equalTo(view.mas_top).offset((view.frame.size.height-15)/2);
        }];
        
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@75);
            make.height.equalTo(@24);
        make.top.equalTo(view.mas_top).offset((view.frame.size.height-24)/2);
            make.right.equalTo(view.mas_right).offset(-5);
        }];
        
//        NSLog(@"screen width: %f, height: %f", [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//        NSLog(@"tableview width: %f", tableView.frame.size.width);
        
    }
    else if (section == 1)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        view.backgroundColor = [UIColor blueColor];
        UILabel* titleLab = [[UILabel alloc] init];
        [titleLab setText:@"榜单"];
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab.textColor = [UIColor whiteColor];
        [view addSubview:titleLab];
        
        MyButton* moreBtn = [[MyButton alloc] init];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:moreBtn];
        [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(showOrderMore) forControlEvents:UIControlEventTouchUpInside];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@75);
            make.height.equalTo(@15);
            make.left.equalTo(view.mas_left).offset(5);
        make.top.equalTo(view.mas_top).offset((view.frame.size.height-15)/2);
        }];
        
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@75);
            make.height.equalTo(@24);
        make.top.equalTo(view.mas_top).offset((view.frame.size.height-24)/2);
            make.right.equalTo(view.mas_right).offset(-5);
        }];
    }
    else
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
        view.backgroundColor = [UIColor blueColor];
    }
//    NSLog(@"view frame width:%f,x=%f,%f", view.frame.size.width,view.frame.origin.x,view.frame.origin.y);
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 0)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

-(void)showMore
{
    MoreViewController* mvc = [[MoreViewController alloc] init];
    mvc.title = @"推荐";
    [self.navigationController pushViewController:mvc animated:NO];
    
}

-(void)showOrderMore
{
    OtherTestViewController* otvc = [[OtherTestViewController alloc] init];
    otvc.title = @"杂乱知识点测试";
    [self.navigationController pushViewController:otvc animated:NO];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//    NSLog(@"修改前");
//    [self printViewHierarchy:self.navigationController.navigationBar];
//
//    //修改NavigaionBar的高度
//    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 150);
//
//    NSLog(@"\n修改后");
//    [self printViewHierarchy:self.navigationController.navigationBar];
//}
//
//- (void)printViewHierarchy:(UIView *)superView
//{
//    static uint level = 0;
//    for(uint i = 0; i < level; i++){
//        printf("\t");
//    }
//
//    const char *className = NSStringFromClass([superView class]).UTF8String;
//    const char *frame = NSStringFromCGRect(superView.frame).UTF8String;
//    printf("%s:%s\n", className, frame);
//
//    ++level;
//    for(UIView *view in superView.subviews){
//        [self printViewHierarchy:view];
//    }
//    --level;
//}


////动态设置导航栏的显示和隐藏
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}

@end
