//
//  WQSMusicStringModel.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQSMusicStringModel : NSObject
//create table if not exists MusicString (id integer primary key autoincrement , title varchar[100] , numbersstring varchar[4000], time varchar[100]

//数据表的主键
@property (nonatomic,strong) NSString * id;

//转调后谱的名字
@property (nonatomic,strong) NSString * title;

//转调后的谱子
@property (nonatomic,strong) NSString * numbersstring;

//存贮转调谱子的时间
@property (nonatomic,strong) NSString * time;

@end
