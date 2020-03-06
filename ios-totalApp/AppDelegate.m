//
//  AppDelegate.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/18.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WelcomeViewController.h"
//#import "SceneDelegate.h"

@interface AppDelegate ()

@property    UIBackgroundTaskIdentifier bgTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //移除main.storyboard文件后，需要添加这句代码，要不无法显示内容
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        // Override point for customization after application launch.
        
//        ViewController *viewController = [[ViewController alloc] init];
//        self.window.rootViewController = viewController;
        
//        self.window.backgroundColor = [UIColor purpleColor];
//    　　[self.window makeKeyAndVisible];
    //
    
    //判断是否为第一次启动，若为第一次启动则执行引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"first launch第一次程序启动");
        //这里进入引导画面
        WelcomeViewController *view=[[WelcomeViewController alloc]init];
        self.window.rootViewController=view;
        
    }else {
        NSLog(@"second launch再次程序启动");
        //直接进入主界面
        ViewController* vc = [[ViewController alloc] init];
        UINavigationController* nv = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.window setRootViewController:nv];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}


//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}

-(void)showHomeUI
{
//    NSLog(@"jump to here");
//    UINavigationController* nv = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc]init]];
    
    ViewController* vc = [[ViewController alloc] init];
    
    
    UINavigationController* nv = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nv];
    [self.window makeKeyAndVisible];
    //获取当前scenedelegate对象 ？？？
//    NSLog(@"%@",[UIApplication sharedApplication].openSessions);
    
}

//后台保活 需要添加UIApplicationDelegate

//将要进入后台
-(void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"将要进入后台");
}

//已经进入后台
-(void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"已经进入后台");
    [self comeToBackgroundMode];
}

//将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"将要进入前台");
}

//从后台进入程序时调用
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"从后台进入程序时调用");
}

-(void)comeToBackgroundMode{
    
    //初始化一个后台任务BackgroundTask，这个后台任务的作用就是告诉系统当前app在后台有任务处理，需要时间
    UIApplication*  app = [UIApplication sharedApplication];
    self.bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:self.bgTask];
        self.bgTask = UIBackgroundTaskInvalid;
    }];
    //开启定时器 不断向系统请求后台任务执行的时间
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:25.0 target:self selector:@selector(applyForMoreTime) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)applyForMoreTime {
    //如果系统给的剩余时间小于60秒 就终止当前的后台任务，再重新初始化一个后台任务，重新让系统分配时间，这样一直循环下去，保持APP在后台一直处于active状态。
    if ([UIApplication sharedApplication].backgroundTimeRemaining < 60) {
        [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
        self.bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
            self.bgTask = UIBackgroundTaskInvalid;
        }];
    }
}

@end
