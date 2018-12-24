//
//  AYResponse.h
//  AiYue
//
//  Created by guangying_tang on 2017/7/22.
//  Copyright © 2017年 guanying. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AYErrorType) {
    AYErrorTypeNone = 0, // 没错误，
    AYErrorTypeUserCancell, // 用户取消
    AYErrorTypeNetwork, // 网络错误
    AYErrorTypeTimeout, // 请求超时
    AYErrorTypeUnknown, // 未知错误
};

@interface AYResponse : NSObject <NSCoding>

@property (assign, nonatomic) AYErrorType errorType;
@property (copy, nonatomic) NSString *errorDescription;
@property (copy, nonatomic) NSString *callbackURLScheme;

@end

@interface AuthorizeLoginResponse : AYResponse

@property (copy, nonatomic) NSString *openId;

@end
