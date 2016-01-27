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


//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        //iOS7之后
        /*
         第一个参数: 预设空间 宽度固定  高度预设 一个最大值
         第二个参数: 行间距 如果超出范围是否截断
         第三个参数: 属性字典 可以设置字体大小
         */
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        //返回计算出的行高
        return rect.size.height;
        
    }else {
        //iOS7之前
        /*
         1.第一个参数  设置的字体固定大小
         2.预设 宽度和高度 宽度是固定的 高度一般写成最大值
         3.换行模式 字符换行
         */
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        return textSize.height;//返回 计算出得行高
    }
}


@end
