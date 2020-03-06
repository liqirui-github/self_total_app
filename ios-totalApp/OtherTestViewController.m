//
//  OtherTestViewController.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/3/2.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "OtherTestViewController.h"
#import "AppDelegate.h"
#import <sqlite3.h>  //导入SQLite3，注意是扩折号

@interface OtherTestViewController ()
{
sqlite3* sqlite;
}
@property UIScrollView* pageSv;  //页面滚动区域
@property UIView* vAnimationView;
@end

@implementation OtherTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* view = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor systemPinkColor];
    
    UIBarButtonItem* bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pop)];
        self.navigationItem.leftBarButtonItem = bbi;
        
        UIBarButtonItem* hbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotoHome)];
        self.navigationItem.rightBarButtonItem = hbi;
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.pageSv = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.pageSv.backgroundColor = [UIColor grayColor];
    self.pageSv.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*4);
    [self.view addSubview:self.pageSv];
    
    //UIView层动画
    UIButton* vAnimationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vAnimationBtn.frame = CGRectMake(0, 0, 150, 20);
    vAnimationBtn.backgroundColor = [UIColor blueColor];
    [vAnimationBtn setTitle:@"UIView animation" forState:UIControlStateNormal];
    [vAnimationBtn addTarget:self action:@selector(UIViewAnimationClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.pageSv addSubview:vAnimationBtn];
    
    self.vAnimationView = [[UIView alloc] initWithFrame:CGRectMake(0, 25, 100, 100)];
    self.vAnimationView.backgroundColor = [UIColor redColor];
    [self.pageSv addSubview:self.vAnimationView];
    
    UIButton* cAnimationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cAnimationBtn.frame = CGRectMake(0, 140, 150, 20);
    cAnimationBtn.backgroundColor = [UIColor blueColor];
    [cAnimationBtn setTitle:@"core animation" forState:UIControlStateNormal];
    [cAnimationBtn addTarget:self action:@selector(coreAnimationClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.pageSv addSubview:cAnimationBtn];
    
    
    UIButton* fileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fileBtn.frame = CGRectMake(0, 260, 150, 20);
    fileBtn.backgroundColor = [UIColor blueColor];
    [fileBtn setTitle:@"文件操作" forState:UIControlStateNormal];
    [fileBtn addTarget:self action:@selector(fileBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.pageSv addSubview:fileBtn];
    
    UIButton* databaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    databaseBtn.frame = CGRectMake(0, 290, 150, 20);
    databaseBtn.backgroundColor = [UIColor blueColor];
    [databaseBtn setTitle:@"数据库" forState:UIControlStateNormal];
    [databaseBtn addTarget:self action:@selector(databaseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.pageSv addSubview:databaseBtn];
    
    UIButton* netRequestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    netRequestBtn.frame = CGRectMake(0, 320, 150, 20);
    netRequestBtn.backgroundColor = [UIColor blueColor];
    [netRequestBtn setTitle:@"网络请求" forState:UIControlStateNormal];
    [netRequestBtn addTarget:self action:@selector(netRequestBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.pageSv addSubview:netRequestBtn];
    
    UIButton* liveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    liveBtn.frame = CGRectMake(0, 320, 150, 20);
    liveBtn.backgroundColor = [UIColor blueColor];
    [liveBtn setTitle:@"后台保活" forState:UIControlStateNormal];
    [liveBtn addTarget:self action:@selector(liveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.pageSv addSubview:liveBtn];
}



//懒加载
-(NSString *)datafilePath
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    return [path stringByAppendingPathComponent:@"data.sqlite"];
}

//警告提示框，为后面的操作向用户提示信息
-(void)alert:(NSString *)mes
{
    /*知识点：ios 9.0 后，简单的UIAlertView已经不能用了。
     UIAlertController代替了UIAlertView弹框 和 UIActionSheet下弹框
     */
    //UIAlertControllerStyleAlert：中间；  UIAlertControllerStyleActionSheet：显示在屏幕底部；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:mes preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:cancel];
    [alert addAction:defult];
    [self presentViewController:alert animated:YES completion:nil]; //呈现
}

-(void)post
{
    //对请求路径的说明
    //http://120.25.226.186:32812/login
    //协议头+主机地址+接口名称
    //协议头(http://)+主机地址(120.25.226.186:32812)+接口名称(login)
    //POST请求需要修改请求方法为POST，并把参数转换为二进制数据设置为请求体
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://www.aiipu.com:8083/display/mobiledata?action=SceneBean.dataRequestScene"];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [@"?data=1" dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
                data：响应体信息（期望的数据）
                response：响应头信息，主要是对服务器端的描述
                error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"http response: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
    }];
    
    //7.执行任务
    [dataTask resume];
}


-(void)netRequestBtnClicked
{
    //post请求
    NSURLSession* session = [NSURLSession sharedSession];
    //http://120.25.226.186:32812/login
    //http://www.aiipu.com:8083/display/mobiledata?action=SceneBean.dataRequestScene
    NSURL* url = [NSURL URLWithString:@"http://www.aiipu.com:8083/display/mobiledata?action=SceneBean.dataRequestScene"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [@"?data=1" dataUsingEncoding:NSUTF8StringEncoding];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"http response: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        [self dataConvertToDictionary:data];
        
    }] resume];
}

-(void)dataConvertToDictionary:(NSData*)data
{
//    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSData* datas = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"all key: %@", [jsonDict allKeys]);
//    NSLog(@"%@", [NSString stringWithString:[jsonDict objectForKey:@"retMsg"]]);
    if ([[jsonDict allKeys] containsObject:@"retMsg"])
    {
        NSLog(@"%@", [jsonDict objectForKey:@"retMsg"]);
    }
    
    //存入数据库  FMDB、Core Data
    //https://www.jianshu.com/p/045c372fe439
    

}

-(void)databaseBtnClicked
{
    //退出程序测试
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    UIWindow *window = app.window;
//
//    [UIView animateWithDuration:1.0f animations:^{
//        window.alpha = 0;
//        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//    } completion:^(BOOL finished) {
//        exit(0);
//    }];
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = [paths objectAtIndex:0];
    NSLog(@"documents path: %@", path);
    
    int result = sqlite3_open([[self datafilePath ] UTF8String], &sqlite);
    if(result != SQLITE_OK)
    {
        sqlite3_close(sqlite);
        [self alert:@"数据库打开失败"];
    }
    else
    {
        [self alert:@"数据库打开成功"];
    }
    
    NSString* createSql = @"CREATE TABLE IF NOT EXISTS 'yaxin'(id INTEGER PRIMARY KEY, resMsg TEXT NOT NULL)";
    char* error;
    int ret = sqlite3_exec(sqlite, [createSql UTF8String], NULL, NULL, &error);
    if(ret != SQLITE_OK)
    {
        [self alert:[NSString stringWithFormat:@"数据表创建失败%s",error]];
    }
    
    
}

//程序数据持久化：  https://www.jianshu.com/p/7616cbd72845
//文件需要单独看
-(void)fileBtnClicked
{
    //获取沙盒根目录
//    NSString* path = NSHomeDirectory();
//    NSLog(@"%@", path);
    
    /*
     第一个参数：指定了搜索的路径的名称：NSDocumentDirectory 表示是在Documents中寻找。NSCacheDirectory的话就是在cache文件中寻找
          第二个参数：第二个参数限定了文件的检索范围只在沙箱内部.其意义为用户电脑主目录.也可以修改为网络主机等
          第三个参数：最后一个参数决定了是否展开波浪线符号.展开后才是完整路径,这个布尔值一直为YES.
     */
    
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSLog(@"paths.count:%ld",paths.count);
//    for (NSInteger i = 0; i < paths.count; i++) {
//        NSString *path = paths[i];
//        NSLog(@"path:%@",path);
//    }
    
     //获取Library路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSLog(@"path：%@", path);
    
    //获取Caches路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSLog(@"path：%@", path);
    
    //获取tmp路径
//    NSString *tmp = NSTemporaryDirectory();
//    NSLog(@"tmp：%@", tmp);
    
    //创建文件夹
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* documentsPath = [paths objectAtIndex:0];
//    //创建文件夹的路径
//    NSString *testPath = [documentsPath stringByAppendingPathComponent:@"test"];
//   //创建目录
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    BOOL rest = [fileManager createDirectoryAtPath:testPath withIntermediateDirectories:YES attributes:nil error:nil];
//    if (rest) {
//        NSLog(@"文件夹创建成功:%@",testPath);
//    }else{
//        NSLog(@"文件夹创建失败");
//    }
    
    //创建文件
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];
//
//    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
//    BOOL res=[fileManager createFileAtPath:testPath contents:nil attributes:nil];
//    if (res) {
//        NSLog(@"文件创建成功: %@" ,testPath);
//    }else{
//        NSLog(@"文件创建失败");
//    }
    
    //写数据到文件
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* documentsPath = [paths objectAtIndex:0];
//    NSString* testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
//    NSString* testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
//    NSString* content = @"文件写入测试\n123";
//    BOOL res = [content writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    if (res) {
//        NSLog(@"文件写入成功：%@",testPath);
//    }else
//        NSLog(@"文件写入失败");
    
    //读文件数据
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* documentsPath = [paths objectAtIndex:0];
//    NSString* testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
//    NSString* testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
////    NSData* data = [NSData dataWithContentsOfFile:testPath];
////    NSLog(@"文件读取成功: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    NSString* content = [NSString stringWithContentsOfFile:testPath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"文件读取成功: %@",content);
    
    //删除文件
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* documentsPath = [paths objectAtIndex:0];
//    NSString* testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
//    BOOL rees = [fileManager isExecutableFileAtPath:testPath];
//    NSLog(@"file path: %@", testPath);
//    NSLog(@"是否存在： %d", rees);
//    //此方法判断程序对文件是否存在操作权限，
////    如果您的应用无法访问at path中的文件，可能是因为该文件没有针对一个或多个父目录的搜索特权，因此此方法返回false。此方法遍历路径中的符号链接。与有效的用户和组ID相对，此方法还使用实际用户ID和组ID来确定文件是否可执行。
////    注意 不建议尝试基于文件系统或文件系统上的特定文件的当前状态来断言行为。这样做可能会导致奇怪的行为或比赛条件。尝试执行某个操作（例如加载文件或创建目录），检查错误并优雅地处理这些错误比尝试提前确定该操作是否成功要好得多。
////    NSLog(@"执行删除前文件是否存在: %@",[fileManager isExecutableFileAtPath:testPath]?@"YES":@"NO");
//    BOOL res = [fileManager removeItemAtPath:testPath error:nil];
//    if (res) {
//        NSLog(@"文件删除成功");
//    }else
//        NSLog(@"文件删除失败");
////    NSLog(@"执行删除后文件是否存在: %@",[fileManager isExecutableFileAtPath:testPath]?@"YES":@"NO");
    
    
    //判断文件是否存在
    //创建文件管理对象
    //调用defaultManager 创建一个文件管理的单例对象
    //单例对象:在程序运行期间,只有一个对象存在
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* documentsPath = [paths objectAtIndex:0];
//    NSString* testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
//    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    // YES 存在   NO 不存在
//    BOOL isYES = [fm fileExistsAtPath:testPath];
//    NSLog(@"-->%d",isYES);
//    //判断是否是一个目录
//    if(isYES){
//        BOOL isDir;
//        // 2) 判断是否是一个目录
//        [fm fileExistsAtPath:testDirectory isDirectory:&isDir];
//        if (isDir) {
//            NSLog(@"这是一个目录");
//        }else{
//            NSLog(@"这不是一个目录");
//        }
//    }
//
//    //判断文件是否可读
//    BOOL bReadable = [fm isReadableFileAtPath:testPath];
//    if (bReadable) {
//        NSLog(@"文件可读");
//    }else{
//        NSLog(@"文件不可读");
//    }
//
//    //判断文件是否可写
//    BOOL bWriteable = [fm isWritableFileAtPath:testPath];
//    if (bWriteable) {
//        NSLog(@"文件可写");
//    }else{
//        NSLog(@"文件不可写");
//    }
//
//    NSLog(@"文件是否可删除？%d",[fm isDeletableFileAtPath:testPath
//                         ] ? YES : NO);
//
//    //获取文件属性信息
//    NSDictionary *dict = [fm attributesOfItemAtPath:testPath error:nil];
//    NSLog(@"%@",dict);
//    NSLog(@"%@,%@",[dict objectForKey:@"NSFileOwnerAccountID"],dict[@"NSFileOwnerAccountName"]);
    
    //拷贝文件 拷贝未成功，但是却直接在test文件夹上一层复制出了一个test.txt文件
//    NSString *targetPath = @"/Users/liqirui/Library/Developer/CoreSimulator/Devices/5A1DC322-62B4-45FD-87D8-CA5F4C3BAE91/data/Containers/Data/Application/AADBDE89-FF75-438A-85B6-2A432ACA37EC/Documents/test/love.txt";
//    NSLog(@"复制文件是否成功？%d", [fm copyItemAtPath:testPath toPath:targetPath error:nil] ? YES : NO);

    //移动文件
    //    NSString *targetPath = @"/Users/liqirui/Library/Developer/CoreSimulator/Devices/5A1DC322-62B4-45FD-87D8-CA5F4C3BAE91/data/Containers/Data/Application/AADBDE89-FF75-438A-85B6-2A432ACA37EC/Documents/test2/";
//    NSLog(@"移动文件是否成功？%d", [fm moveItemAtPath:testPath toPath:targetPath error:nil] ? YES : NO);
}

//核心动画编程框架 coreAnimation 其基于CALayer层,将下列CALayer以动画表现出来
//CAGradientLayer 色彩梯度层
//CAReplicatorLayer 视图备份层 对一已存在的CALyer进行备份渲染
//CAShapeLayer  图形渲染层  进行自定义的图形绘制
//CATextLayer 文本绘制层  进行视图上文本的绘制
//CAEmitterLayer  粒子发射器 微观、无序的复杂动画实现

-(void)coreAnimationClicked
{
    CALayer* layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 160, 100, 100);
    layer.position = CGPointMake(50, 220);
    layer.backgroundColor = [UIColor redColor].CGColor;
    CATransition* ani = [CATransition animation];
    ani.type = kCATransitionPush;
    ani.subtype = kCATransitionFromRight;
    ani.duration = 3;
    [layer addAnimation:ani forKey:@""];
    [self.view.layer addSublayer:layer];
    

}

//UIView层动画
-(void)UIViewAnimationClicked
{
    //过渡动画
//    [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.vAnimationView.frame = CGRectMake(100, 25, 60, 60);
//        self.vAnimationView.backgroundColor = [UIColor purpleColor];
//    } completion:^(BOOL finished) {
//
//    }];
    
    //阻尼动画
    //usingSpringWithDamping 0到1 越接近1阻尼越大，阻尼越大回弹幅度越小
    //initialSpringVelocity  动画初速度 初速越大，回弹幅度越大
//    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:50 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.vAnimationView.frame = CGRectMake(100, 25, 60, 60);
//        self.vAnimationView.backgroundColor = [UIColor purpleColor];
//    } completion:^(BOOL finished) {
//    }];
    
    //ios4以前的commit方式创建动画，不建议使用
    
    //转场动画  1、重绘 2、切换
    
    //1、重绘UIView
//    [UIView transitionWithView:self.vAnimationView duration:1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        self.vAnimationView.backgroundColor = [UIColor greenColor];
//        self.vAnimationView.frame = CGRectMake(100, 25, 60, 60);
//    } completion:^(BOOL finished) {
//
//    }];
    
    //2、切换UIView
    UIView* vAnimationView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 25, 100, 100)];
    vAnimationView2.backgroundColor = [UIColor orangeColor];
    [UIView transitionFromView:self.vAnimationView toView:vAnimationView2 duration:1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
    }];
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

//后台保活

@end
