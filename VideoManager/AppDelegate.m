//
//  AppDelegate.m
//  VideoManager
//
//  Created by lerrruby on 15/10/21.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "AppDelegate.h"
#import "loginViewController.h"
#import "MainViewController.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NewFeatureViewController.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WXApi registerApp:@"wx242f39cacb01ded0"];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if(ScreenHeight > 480){
        self.autoSizeScaleX = ScreenWidth/320;
        self.autoSizeScaleY = ScreenHeight/568;
    }else{
        self.autoSizeScaleX = 1.0;
        self.autoSizeScaleY = 1.0;
    }

    
    //2.1从沙盒中取出上次使用的版本号。用userdefaults 不用考虑路径
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"key"];
    //2.2加载版本号
    NSString * currentVersionCode = [NSBundle mainBundle].infoDictionary[key];
    //2.3 判断第一次使用
    if ([lastVersionCode isEqualToString:currentVersionCode]) {
        loginViewController *loginController = [[loginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginController];
        MainViewController*main = [[MainViewController alloc]init];
        
        self.window.rootViewController = nav;
        
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionCode forKey:@"key"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NewFeatureViewController *new = [[NewFeatureViewController alloc]init];
        new.startBlock = ^(BOOL shared){
            loginViewController *loginController = [[loginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginController];
            MainViewController*main = [[MainViewController alloc]init];
            
            self.window.rootViewController = nav;
        };
        self.window.rootViewController = new;
        
    }


    
    [self.window makeKeyAndVisible];

    return YES;
}
-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

-(BOOL)application:(UIApplication*)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
