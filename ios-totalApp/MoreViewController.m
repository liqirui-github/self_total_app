//
//  MoreViewController.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/27.
//  Copyright © 2020 李其瑞. All rights reserved.
//

//动态加载，逻辑存在问题，开始fresh时loadMore被触发，暂实现动态刷新，理论上需要记录开始加载位置并将滚动条设置到该位置

#import "MoreViewController.h"
#import "FoodModel.h"
#import "Masonry/Masonry.h"
#import "StoreTableViewCell.h"
#import "StoreModel.h"
#import "SGLoadMoreView.h"
#import "DetailViewController.h"

//未发现重复定义，此处警告很费解
#define PAGEs_MAX_SIZE 4

//-----------自定义UIRefreshControl--------------
@interface WSRefreshControl : UIRefreshControl

@end

@implementation WSRefreshControl

-(void)beginRefreshing
{
    [super beginRefreshing];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)endRefreshing
{
    [super endRefreshing];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end

//-----------自定义UIRefreshControl--------------

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) SGLoadMoreView* loadMoreView;
@property UITableView* tv;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //使用UICollectionView做一个圆环布局。-待定
    
    
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    
    UIBarButtonItem* bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = bbi;
//    self.navigationItem.backBarButtonItem = bbi;
    
    UIBarButtonItem* hbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotoHome)];
    self.navigationItem.rightBarButtonItem = hbi;
    
    [self initData];
    
    //动态加载
    self.tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tv];
    
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
//    self.tv.backgroundColor = [UIColor orangeColor];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    //UITableViewCell之间分隔符的样式，默认直线
    self.tv.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tv.refreshControl = [[UIRefreshControl alloc] init];
    self.tv.refreshControl = [[WSRefreshControl alloc] init];
    self.tv.refreshControl.tintColor = [UIColor redColor];
    self.tv.refreshControl.alpha = 0.6;
    self.tv.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"上一页"];
    [self.tv.refreshControl addTarget:self action:@selector(updata:) forControlEvents:UIControlEventValueChanged];

    //加载更多，高度44
    self.loadMoreView = [[SGLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, self.tv.frame.size.width, 44)];
    self.tv.tableFooterView = self.loadMoreView;
//    [self.tv addSubview:self.loadMoreView];
    
    [self.tv.refreshControl beginRefreshing];
}

-(void)updata:(UIRefreshControl*)control
{
//    [control performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
    if (self.tv.refreshControl.isRefreshing && self.loadMoreView.isAnimating ==NO){
//        [self.modelArray removeAllObjects];//清除旧数据，每次都加载最新的数据
        //重新设置起始位置 每页6个item 注意下标
        
        if (self.stopNo == 0)
        {
            self.stopNo = 5;
        }
        else
        {
            NSInteger cnt = self.storeArray.count - 1;
            NSInteger length = 5;
            NSInteger start = 0;
            if (self.startNo -length >= start)
            {
                self.startNo = self.startNo - length;
            }
            else
            {
                self.startNo = 0;
            }
            
            if (self.stopNo - self.startNo > 9)
            {
                self.stopNo = self.startNo + 9;
            }
//            else
//            {
//                if (cnt - self.startNo > 5)
//                {
//                    self.stopNo = self.startNo + 5;
//                }
//                else
//                {
//                    self.stopNo = cnt;
//                }
//            }
        }
        
        self.tv.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
//        [self addData];
        self.tv.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        
        [self.tv.refreshControl endRefreshing];
        [self.tv reloadData];
        self.loadMoreView.tipsLabel.hidden = YES;

    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 4;
//    NSUInteger cnt = self.storeArray.count;
//    if (cnt > self.startNo + PAGEs_MAX_SIZE)  //分页数
//    {
//        return PAGEs_MAX_SIZE;s
//    }
//    else if (cnt > self.startNo)
//    {
//        return cnt - self.startNo;
//    }
//    else
//    {
//        return 0;
//    }
    
    return self.stopNo - self.startNo + 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    StoreTableViewCell* stvc = (StoreTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"more" forIndexPath:indexPath];
    StoreTableViewCell* stvc = (StoreTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"more"];

    if (stvc == nil)
    {
        stvc = [[StoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"more"];
    }
    
    [stvc setStoreModel:[self.storeArray objectAtIndex:(self.startNo + indexPath.item)]];
//    stvc.backgroundColor = [UIColor blackColor];
    return stvc;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    /*self.tv.refreshControl.isRefreshing == NO加这个条件是为了防止下面的情况发生：
    每次进入UITableView，表格都会沉降一段距离，这个时候就会导致currentOffsetY + scrollView.frame.size.height   > scrollView.contentSize.height 被触发，从而触发loadMore方法，而不会触发refresh方法。
     */
    if ( currentOffsetY + scrollView.frame.size.height  > scrollView.contentSize.height &&  self.tv.refreshControl.isRefreshing == NO  && self.loadMoreView.isAnimating == NO && self.loadMoreView.tipsLabel.isHidden ){
        [self.loadMoreView startAnimation];//开始旋转菊花
        [self loadMore];
    }
//    NSLog(@"%@ ---%f----%f",NSStringFromCGRect(scrollView.frame),currentOffsetY,scrollView.contentSize.height);
}

-(void)loadMore
{
//    self.startNo = self.stopNo;
    
    if (self.stopNo - self.startNo >= 9)
    {
        self.startNo = self.startNo +5;
    }
    
    NSInteger cnt = self.storeArray.count - 1;
    self.stopNo = cnt - self.stopNo > 5 ? self.stopNo+5 : cnt;
    [self.loadMoreView stopAnimation];
    [self.tv reloadData];
    if (self.stopNo >= cnt)
    {
        [self.loadMoreView noMoreData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //indexPath.item
    DetailViewController* dvc = [[DetailViewController alloc] init];
    [dvc setStoreModel:[self.storeArray objectAtIndex:indexPath.item+self.startNo]];
    dvc.title = @"详情页";
    //切换页面，考虑到返回主页，还是用了导航控制器的push方法
//    [self presentViewController:dvc animated:YES completion:^{
//        //
//    }];
    [self.navigationController pushViewController:dvc animated:YES];
    
}

-(void)initData
{
    self.startNo = 0;
    self.stopNo = 0;
    
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
    
    FoodModel *food9 = [[FoodModel alloc] init];
    food9.foodPhotoName = @"09";
    food9.foodName = @"石家庄";
    
    FoodModel *food10 = [[FoodModel alloc] init];
    food10.foodPhotoName = @"010";
    food10.foodName = @"青海";
    
    FoodModel *food11 = [[FoodModel alloc] init];
    food11.foodPhotoName = @"011";
    food11.foodName = @"拉萨";
    
    FoodModel *food12 = [[FoodModel alloc] init];
    food12.foodPhotoName = @"012";
    food12.foodName = @"乌鲁木齐";
    
    FoodModel *food13 = [[FoodModel alloc] init];
    food13.foodPhotoName = @"013";
    food13.foodName = @"大理";
    
    FoodModel *food14 = [[FoodModel alloc] init];
    food14.foodPhotoName = @"014";
    food14.foodName = @"海口";
    
    FoodModel *food15 = [[FoodModel alloc] init];
    food15.foodPhotoName = @"015";
    food15.foodName = @"福州";
    
    FoodModel *food16 = [[FoodModel alloc] init];
    food16.foodPhotoName = @"016";
    food16.foodName = @"承德";
    
    FoodModel *food17 = [[FoodModel alloc] init];
    food17.foodPhotoName = @"017";
    food17.foodName = @"澳门";
    
    FoodModel *food18 = [[FoodModel alloc] init];
    food18.foodPhotoName = @"018";
    food18.foodName = @"台湾";
    
    FoodModel *food19 = [[FoodModel alloc] init];
    food19.foodPhotoName = @"019";
    food19.foodName = @"香港";
    
    FoodModel *food20 = [[FoodModel alloc] init];
    food20.foodPhotoName = @"020";
    food20.foodName = @"哈尔滨";
    
    self.foodArray=[[NSMutableArray alloc]initWithObjects:food1,food2,food3,food4,food5,food6,food7,food8,food9,food10,food11,food12,food13,food14,food15,food16,food17,food18,food19,food20, nil];
    
    StoreModel* smodel1 = [[StoreModel alloc] init];
    smodel1.storePhotoName = @"01";
    smodel1.storeName = @"上海m2-01";
    smodel1.storeDistance = @"168cm 55kg 本科";
    smodel1.storeDeliveryCost = @"实时价格 ¥8000";
    
    StoreModel* smodel2 = [[StoreModel alloc] init];
    smodel2.storePhotoName = @"02";
    smodel2.storeName = @"北京天上人间-02";
    smodel2.storeDistance = @"172cm 58kg 本科";
    smodel2.storeDeliveryCost = @"暂无价格信息";
    
    StoreModel* smodel3 = [[StoreModel alloc] init];
    smodel3.storePhotoName = @"03";
    smodel3.storeName = @"南京1912-03";
    smodel3.storeDistance = @"163cm 50kg 本科";
    smodel3.storeDeliveryCost = @"实时价格 ¥5000";
    
    StoreModel* smodel4 = [[StoreModel alloc] init];
    smodel4.storePhotoName = @"04";
    smodel4.storeName = @"杭州火知了-04";
    smodel4.storeDistance = @"172cm 57kg 本科";
    smodel4.storeDeliveryCost = @"实时价格 ¥6000";
    
    StoreModel* smodel5 = [[StoreModel alloc] init];
    smodel5.storePhotoName = @"05";
    smodel5.storeName = @"长沙解放西路-05";
    smodel5.storeDistance = @"172cm 55kg 硕士";
    smodel5.storeDeliveryCost = @"实时价格 ¥4800";
    
    StoreModel* smodel6 = [[StoreModel alloc] init];
    smodel6.storePhotoName = @"06";
    smodel6.storeName = @"上海m2-06";
    smodel6.storeDistance = @"168cm 55kg 本科";
    smodel6.storeDeliveryCost = @"实时价格 ¥8000";
    
    StoreModel* smodel7 = [[StoreModel alloc] init];
    smodel7.storePhotoName = @"07";
    smodel7.storeName = @"北京天上人间-07";
    smodel7.storeDistance = @"172cm 58kg 本科";
    smodel7.storeDeliveryCost = @"暂无价格信息";
    
    StoreModel* smodel8 = [[StoreModel alloc] init];
    smodel8.storePhotoName = @"08";
    smodel8.storeName = @"南京1912-08";
    smodel8.storeDistance = @"163cm 50kg 本科";
    smodel8.storeDeliveryCost = @"实时价格 ¥5000";
    
    StoreModel* smodel9 = [[StoreModel alloc] init];
    smodel9.storePhotoName = @"09";
    smodel9.storeName = @"杭州火知了-09";
    smodel9.storeDistance = @"172cm 57kg 本科";
    smodel9.storeDeliveryCost = @"实时价格 ¥6000";
    
    StoreModel* smodel10 = [[StoreModel alloc] init];
    smodel10.storePhotoName = @"010";
    smodel10.storeName = @"长沙解放西路-10";
    smodel10.storeDistance = @"172cm 55kg 硕士";
    smodel10.storeDeliveryCost = @"实时价格 ¥4800";
    
    StoreModel* smodel11 = [[StoreModel alloc] init];
    smodel11.storePhotoName = @"011";
    smodel11.storeName = @"上海m2-11";
    smodel11.storeDistance = @"168cm 55kg 本科";
    smodel11.storeDeliveryCost = @"实时价格 ¥8000";
    
    StoreModel* smodel12 = [[StoreModel alloc] init];
    smodel12.storePhotoName = @"012";
    smodel12.storeName = @"北京天上人间-12";
    smodel12.storeDistance = @"172cm 58kg 本科";
    smodel12.storeDeliveryCost = @"暂无价格信息";
    
    StoreModel* smodel13 = [[StoreModel alloc] init];
    smodel13.storePhotoName = @"013";
    smodel13.storeName = @"南京1912-13";
    smodel13.storeDistance = @"163cm 50kg 本科";
    smodel13.storeDeliveryCost = @"实时价格 ¥5000";
    
    StoreModel* smodel14 = [[StoreModel alloc] init];
    smodel14.storePhotoName = @"014";
    smodel14.storeName = @"杭州火知了-14";
    smodel14.storeDistance = @"172cm 57kg 本科";
    smodel14.storeDeliveryCost = @"实时价格 ¥6000";
    
    StoreModel* smodel15 = [[StoreModel alloc] init];
    smodel15.storePhotoName = @"015";
    smodel15.storeName = @"长沙解放西路-15";
    smodel15.storeDistance = @"172cm 55kg 硕士";
    smodel15.storeDeliveryCost = @"实时价格 ¥4800";
    
    StoreModel* smodel16 = [[StoreModel alloc] init];
    smodel16.storePhotoName = @"016";
    smodel16.storeName = @"上海m2-16";
    smodel16.storeDistance = @"168cm 55kg 本科";
    smodel16.storeDeliveryCost = @"实时价格 ¥8000";
    
    StoreModel* smodel17 = [[StoreModel alloc] init];
    smodel17.storePhotoName = @"017";
    smodel17.storeName = @"北京天上人间-17";
    smodel17.storeDistance = @"172cm 58kg 本科";
    smodel17.storeDeliveryCost = @"暂无价格信息";
    
    StoreModel* smodel18 = [[StoreModel alloc] init];
    smodel18.storePhotoName = @"018";
    smodel18.storeName = @"南京1912-18";
    smodel18.storeDistance = @"163cm 50kg 本科";
    smodel18.storeDeliveryCost = @"实时价格 ¥5000";
    
    StoreModel* smodel19 = [[StoreModel alloc] init];
    smodel19.storePhotoName = @"019";
    smodel19.storeName = @"杭州火知了-19";
    smodel19.storeDistance = @"172cm 57kg 本科";
    smodel19.storeDeliveryCost = @"实时价格 ¥6000";
    
    StoreModel* smodel20 = [[StoreModel alloc] init];
    smodel20.storePhotoName = @"020";
    smodel20.storeName = @"长沙解放西路-20";
    smodel20.storeDistance = @"172cm 55kg 硕士";
    smodel20.storeDeliveryCost = @"实时价格 ¥4800";
    
    self.storeArray = [[NSMutableArray alloc] initWithObjects:smodel1, smodel2,smodel3,smodel4,smodel5,smodel6, smodel7,smodel8,smodel9,smodel10,smodel11, smodel12,smodel13,smodel14,smodel15,smodel16, smodel17,smodel18,smodel19,smodel20,nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//}

@end
