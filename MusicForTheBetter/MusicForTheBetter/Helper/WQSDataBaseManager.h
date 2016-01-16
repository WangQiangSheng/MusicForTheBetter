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

//用于存贮在本地数据库的操作

@interface WQSDataBaseManager : NSObject

//数据库操作工具
@property (nonatomic,strong) FMDatabase * dataBase;

//获取数据库操作单例
+(instancetype)shareDataBaseManager;

//查询语句
-(NSArray *)selectMusicStringByDataBase;

//插入语句
-(void)insertAMessageToDataBase:(WQSMusicStringModel *) stringModel;

//删除语句
-(void)deleteAmessageToDataBase:(NSString *) idNumber;

//修改语句
-(void)changeAmessageToDataBase:(WQSMusicStringModel *) stringModel;


@end
