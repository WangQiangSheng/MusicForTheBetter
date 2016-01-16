//
//  WQSDataBaseManager.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSDataBaseManager.h"
#import "FMDB.h"
#import "WQSMusicStringModel.h"

@class WQSDataBaseManager;

static WQSDataBaseManager * manager = nil;

@implementation WQSDataBaseManager

+(instancetype)shareDataBaseManager{
    
    @synchronized(self) {
        if(!manager){
            manager = [[self alloc] init];
        }
        
    }
    
    return manager;
}

-(instancetype)init{
    
    if(self = [super init]){
        NSString * outerPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/YueLaiYueHao.db"];
        self.dataBase = [[FMDatabase alloc]initWithPath:outerPath];
    }
    
    if(!self.dataBase){
        NSLog(@"数据库创建失败");
    }
    
    if(![self.dataBase open]){
        [self.dataBase close];
        NSLog(@"数据库打开失败");
    }
    
    [self createMusicStringTable];
    
    return self;
}



//创建存贮转调字符串相关的数据表
-(void)createMusicStringTable{
    /**
     *id 主键，用于唯一标示，能自增一
     *title 谱的名字，（由用户输入，并自动加上原调、目标调）
     *numbersstring 简谱内容
     *time 保存时间
     *
     */
    NSString * sql = @"create table if not exists MusicString (id integer primary key autoincrement , title varchar[100] , numbersstring varchar[4000], time varchar[100])";
    BOOL result = [self.dataBase executeUpdate:sql];
    if(!result){
        NSLog(@"创建寸谱表格失败");
        [self.dataBase close];
    }
}

//查找所有的已存曲谱
-(NSArray *)selectMusicStringByDataBase{
    
    NSString * sql = @"select * from MusicString";
    FMResultSet * set = [self.dataBase executeQuery:sql];
    NSMutableArray * itemArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    if([set next]){
        WQSMusicStringModel * model = [[WQSMusicStringModel alloc]init];
        model.id = [NSString stringWithFormat:@"%d",[set intForColumn:@"id"]];
        model.title = [set stringForColumn:@"title"];
        model.numbersstring = [set stringForColumn:@"numbersstring"];
        model.time = [set stringForColumn:@"time"];
        [itemArr addObject:model];
    }
    
    return itemArr;
}










@end
