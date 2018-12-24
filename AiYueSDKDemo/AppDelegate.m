//
//  AppDelegate.m
//  AiYueSDKDemo
//
//  Created by guangying_tang on 2017/7/25.
//  Copyright © 2017年 guangying_tang. All rights reserved.
//

#import "AppDelegate.h"
#import "AiYueSDK.h"
#import <CommonCrypto/CommonCryptor.h>
#import "TableViewController.h"

/* 分享扩展链接的扩展字段 */
extern const NSString *KInviterId; // 邀请人id
extern const NSString *KInviterName;// 邀请名字
extern const NSString *KGameRoomId;// 游戏房间id

const NSString *AiYueAppId = @"ay8d146cee55d8907c8ebc826afa107e72";

@interface AppDelegate () <AiYueSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[TableViewController new]];
    _window.rootViewController = nvc;
    [_window makeKeyAndVisible];
    

    // 1. 注册AppID
    [[AiYueSDK defaultService] registerWithAppID:AiYueAppId];
    // 2. 设置AiYueSDK的代理
    [AiYueSDK defaultService].delegate = self;

    
    
    return YES;
}

#pragma mark -  AiYueSDKDelegate

- (void)AiYueSDK:(AiYueSDK *)sdk didReceiveMessage:(AYMessageFromAiYue *)message
{
    NSDictionary *info = message.info;
    if (info)
    {// 有扩展信息
        NSString *inviterId = info[KInviterId];
        NSString *nviterName = info[KInviterName];
        int gameRoomId  = [info[KGameRoomId] intValue];
        
        NSLog(@"通过分享链接传递的扩展信息:\n inviterId: %@\n nviterName: %@\n gameRoomID: %d\n", inviterId, nviterName, gameRoomId);
    } else
    {// 没有扩展信息
        
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"%s", __func__);
    
    // 2、处理爱约叫起你的app
    [[AiYueSDK defaultService] handleOpenURL:url];
    
    return YES;
}




@end
