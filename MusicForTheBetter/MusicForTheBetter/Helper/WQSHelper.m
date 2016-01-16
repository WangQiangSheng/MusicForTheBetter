//
//  WQSHelper.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSHelper.h"
#import <UIKit/UIKit.h>

@implementation WQSHelper

+(NSMutableAttributedString *)getColorsString:(NSString *)allString andOneString:(NSString *)oneStr andOtherString:(NSString *)otherStr{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:allString];
    NSRange firstRange = [oneStr rangeOfString:allString];
    NSRange secondRange = [otherStr rangeOfString:allString];
    [attributedString setAttributes:@{NSForegroundColorAttributeName : [UIColor purpleColor]} range:firstRange];
    [attributedString setAttributes:@{NSForegroundColorAttributeName : [UIColor purpleColor]} range:secondRange];
    return attributedString;
}

//+(UIColor *)getColorByRed:(CGFloat) red andGreen:(CGFloat) green and:(CGFloat) blue andAlpha:(CGFloat) alpha{
//    return [UIColor colorWithHue:red/255.0 saturation:green/255.0 brightness:blue/255.0 alpha:alpha];
//}


@end
