//
//  AYRequest.h
//  Game
//
//  Created by guangying_tang on 2017/7/21.
//  Copyright © 2017年 guangying_tang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! @brief 错误类型
 *
 */
typedef NS_ENUM(NSInteger, AYRequestType)
{
    AYRequestTypeAuthorizeLogin = 1, // 授权登录
    AYRequestTypeShareLink, // 分享链接
    AYRequestTypeShareImage, // 分享图片
    AYRequestTypeShareGameRoom, // 分享游戏房间
    AYRequestTypeShareGameVeido, // 分享游戏录像
};

/*! @brief 请求发送场景
 *
 */
typedef NS_ENUM(NSInteger, AYScene)
{
    AYSceneSession, // 聊天界面
    AYSceneTimeline, // 朋友圈
};

@interface AYRequest : NSObject <NSCoding>

@property (assign, nonatomic) AYRequestType type;

/** 发送的目标场景，可以选择发送到会话(AYSceneSession)或者朋友圈(AYSceneTimeline)。 默认发送到会话。
 * @see AYScene
 */
@property (assign, nonatomic) AYScene scene;

/** 扩展属性
 * 字典的键值，必须为基本类型()
 */
@property (strong, nonatomic) NSDictionary *ext; // 扩展属性

@end

// 授权登录
@interface AYAuthorizeLoginRequest : AYRequest

@end

// 分享链接
@interface AYShareLinkRequest : AYRequest

@property (copy, nonatomic) NSString *title; // 标题
@property (copy, nonatomic) NSString *content; // 内容

/*
 缩略图
 受网易自定义消息的attachment大小限制，该属性最好是NSString类型的图片地址
 如果一定是UIImage类型的话，图片尽量是小图片，图片过大的话可能导致分享失败
 */
@property (strong, nonatomic) id thumbnailImage;
@property (copy, nonatomic) NSString *linkAdress; // 链接地址

@end

// 分享图片
@interface AYShareImageRequest : AYRequest

@property (copy, nonatomic) NSString *title; // 标题
@property (copy, nonatomic) NSString *content; // 内容
@property (strong, nonatomic) id thumbnailImage; // 缩略图(目前没有使用)
@property (strong, nonatomic) id image; // 图片(目前只能传UIimage)
@property (copy, nonatomic) NSString *linkAdress; // 链接地址

@end


// 分享房间
@interface AYShareGameRoomRequest : AYRequest

@property (copy, nonatomic) NSString *title; // 标题
@property (copy, nonatomic) NSString *content; // 内容

/*
 缩略图
 受网易自定义消息的attachment大小限制，该属性最好是NSString类型的图片地址
 如果一定是UIImage类型的话，图片尽量是小图片，图片过大的话可能导致分享失败
 */
@property (strong, nonatomic) id thumbnailImage;
@property (copy, nonatomic) NSString *roomID __deprecated_msg("Use class AYShareLinkRequest's property ext'"); // 房间号
@property (copy, nonatomic) NSString *linkAdress; // 链接地址

@end

// 分享游戏录像
@interface AYShareGameVedioRequest : AYRequest

@property (copy, nonatomic) NSString *title; // 标题
@property (copy, nonatomic) NSString *content; // 内容

/*
 缩略图
 受网易自定义消息的attachment大小限制，该属性最好是NSString类型的图片地址
 如果一定是UIImage类型的话，图片尽量是小图片，图片过大的话可能导致分享失败
 */
@property (strong, nonatomic) id thumbnailImage;
@property (copy, nonatomic) NSString *vedioID __deprecated_msg("Use class AYShareLinkRequest's property ext'"); // 录像ID
@property (copy, nonatomic) NSString *linkAdress; // 链接地址

@end


