//
//  WQSRecorderMessagesModel.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/22.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WQSRecorderMessagesModel : NSObject
/**
 *id 主键，用于唯一标示，能自增一
 *title 录音的名字，（由用户输入）
 *filespath 录音谱内容的路径
 *time 保存时间
 *username 用户名称（昵称）
 *userphone 用户账号（手机号）
 *heart 是否加 * 标注
 */

@property (nonatomic,strong) NSString * id;

@property (nonatomic,strong) NSString * title;

@property (nonatomic,strong) NSString * filespath;

@property (nonatomic,strong) NSString * time;

@property (nonatomic,strong) NSString * username;

@property (nonatomic,strong) NSString * userphone;

@property (nonatomic,strong) NSString * heart;

//------------------------------------------------------>
@property (nonatomic,retain) UIImage * leftTopImage;




@end
