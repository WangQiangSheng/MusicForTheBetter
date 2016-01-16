//
//  WQSMusicStringModel.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQSMusicStringModel : NSObject



//数据表的主键
@property (nonatomic,strong) NSString * id;

//转调后谱的名字
@property (nonatomic,strong) NSString * title;

//转调后的谱子
@property (nonatomic,strong) NSString * numbersstring;

//存贮转调谱子的时间
@property (nonatomic,strong) NSString * time;

//用户的昵称（名字）
@property (nonatomic,strong) NSString * username;

//用户的电话号码（账号）
@property (nonatomic,strong) NSString * userphone;


@end
