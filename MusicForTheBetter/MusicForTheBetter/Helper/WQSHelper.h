//
//  WQSHelper.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WQSHelper : NSObject


+(NSMutableAttributedString *)getColorsString:(NSString *)allString andOneString:(NSString *)oneStr andOtherString:(NSString *)otherStr;

+(CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;

//+(UIColor *)getColorByRed:(CGFloat) red andGreen:(CGFloat) green and:(CGFloat) blue andAlpha:(CGFloat) alpha;


@end
