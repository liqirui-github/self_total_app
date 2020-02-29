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
    
    WelcomeViewController *view=[[WelcomeViewController alloc]init];
    self.window.rootViewController=view;
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

@end
