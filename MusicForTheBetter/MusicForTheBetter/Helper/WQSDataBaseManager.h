//
//  WQSDataBaseManager.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface WQSDataBaseManager : NSObject

@property (nonatomic,strong) FMDatabase * dataBase;

@end
