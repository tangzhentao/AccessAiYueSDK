//
//  AiYueSDK.h
//  Game
//
//  Created by guangying_tang on 2017/7/17.
//  Copyright © 2017年 guangying_tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYRequest.h"
#import "AYResponse.h"
#import "AYMessageFromAiYue.h"

typedef void (^Completion) (AYResponse *response);

@protocol AiYueSDKDelegate;

@interface AiYueSDK : NSObject

@property (weak, nonatomic) id<AiYueSDKDelegate> delegate;

/*! @brief 创建单例服务
 *
 *  @return 返回单例对象
 */
+ (instancetype)defaultService;

/*! @brief 注册
 *
 *  @param appID 应用在爱约服务端注册的appID，并且爱约调起应用时会作为应用的URLScheme使用。因此，应该的URLScheme要设置为该appID；
 */
 - (void)registerWithAppID:(NSString *)appID;

/*! @brief 处理爱约通过URL启动App时传递的数据
 *
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 爱约启动第三方应用时传递过来的URL
 * @return 成功返回YES，失败返回NO。
 */
- (BOOL)handleOpenURL:(NSURL *) url;

/*! @brief 是否安装了AiYue
 *
 *  @return 安装了返回YES，否则NO
 */
+ (BOOL)isAiYueInstalled;


- (void)sendRequest:(AYRequest *)request completion:(Completion)completion;

@end

@protocol AiYueSDKDelegate <NSObject>

- (void)AiYueSDK:(AiYueSDK *)sdk didReceiveMessage:(AYMessageFromAiYue *)message;

@end
