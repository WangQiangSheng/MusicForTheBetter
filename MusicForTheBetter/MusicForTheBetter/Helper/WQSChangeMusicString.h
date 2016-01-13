//
//  ChangeMusicString.h
//  MyProgectChange
//
//  Created by qianfeng007 on 15/9/29.
//  Copyright (c) 2015年 浮生若梦亦如烟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQSChangeMusicString : NSObject

+(NSString *)changeFromPitch:(NSString *)oldPitch ToPitch:(NSString *)newPitch byTextString:(NSString *)text;

@end
