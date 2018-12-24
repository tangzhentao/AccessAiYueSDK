//
//  ShareTypeModel.h
//  AiYueSDKDemo
//
//  Created by itang on 2017/12/12.
//  Copyright © 2017年 guangying_tang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, ShareType)
{
    ShareTypeLogin = 1,
    ShareTypeImageObject,
    ShareTypeImageLink,
    ShareTypeLink,
    ShareTypeLinkWithExt,
    ShareTypeInstalled,
};

@interface ShareTypeModel : NSObject

@property (assign, nonatomic) ShareType type;
@property (copy, nonatomic) NSString *name;

+ (instancetype)modelWithName:(NSString *)name type:(ShareType)type;

@end
