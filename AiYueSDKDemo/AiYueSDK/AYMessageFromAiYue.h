//
//  AYMessageFromAiYue.h
//  libAiYueSDK
//
//  Created by guangying_tang on 2017/7/25.
//  Copyright © 2017年 guangying_tang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! @brief info属性中可能存在的key，
 *
 */
extern NSString *kGameRoomID; // 游戏房间ID
extern NSString *kGameVideoID; // 游戏录像ID
extern NSString *kLinkAddress; // 链接地址

/*! @brief 来自AiYue消息的类型
 *
 */
typedef NS_ENUM(NSInteger, AYMessageType)
{
    AYMessageTypeGameRoom, // 游戏房间
    AYMessageTypeGameVideo, // 游戏录像
    AYMessageTypeAppLinkAddress, // app链接
};

@interface AYMessageFromAiYue : NSObject <NSCoding>

@property (assign, nonatomic) AYMessageType type;

/*! @brief 附带的信息，字典的key为：kGameRoomID或kGameVideoID
 *
 */
@property (strong, nonatomic) NSDictionary *info;

@property (copy, nonatomic) NSString *callbackURLScheme;


@end
