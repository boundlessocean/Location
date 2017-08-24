//
//  AppDelegate.m
//  onestepcar
//
//  Created by boundlessocean on 2017/8/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [ViewController new];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"f95eIwic67sYj1V34vP2v8TveWdHHG4z"  generalDelegate:vc];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    [window makeKeyAndVisible];
    return YES;
}



    
@end
