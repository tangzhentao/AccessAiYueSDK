//
//  ShareTypeModel.m
//  AiYueSDKDemo
//
//  Created by itang on 2017/12/12.
//  Copyright © 2017年 guangying_tang. All rights reserved.
//

#import "ShareTypeModel.h"

@implementation ShareTypeModel

+ (instancetype)modelWithName:(NSString *)name type:(int)type;
{
    return [[self alloc] initWithName:name type:type];
}

- (instancetype)initWithName:(NSString *)name type:(int)type;
{
    self = [super init];
    if (self) {
        _name =name;
        _type = type;
    }
    
    return self;
}

@end
