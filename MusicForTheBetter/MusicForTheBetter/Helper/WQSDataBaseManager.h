//
//  WQSDataBaseManager.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "WQSMusicStringModel.h"
#import "WQSRecorderMessagesModel.h"

//用于存贮在本地数据库的操作

@interface WQSDataBaseManager : NSObject

//数据库操作工具
@property (nonatomic,strong) FMDatabase * dataBase;

//获取数据库操作单例
+(instancetype)shareDataBaseManager;


//------------------------------对转调简谱的操作
//插入语句
-(void)insertMisicStringMessageToDataBase:(WQSMusicStringModel *) stringModel;
//修改语句
-(void)changeMusicStringMessageToDataBase:(WQSMusicStringModel *) stringModel;


//------------------------------对转调简谱、录音的共有操作
//查询语句
-(NSArray *)selectMusicStringByDataBaseFrom:(NSString * ) table;
//删除语句
-(void)deleteAmessageToDataBase:(NSString *) idNumber AndFrom:(NSString * ) table;


//------------------------------对转调录音的操作
//修改语句
-(void)changeRecorderMessageToDataBase:(WQSRecorderMessagesModel *) rocorderModel;
//插入语句
-(void)insertRecorderMessageToDataBase:(WQSRecorderMessagesModel *) recorderModel;



@end
