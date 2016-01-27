//
//  WQSPlayRecorderViewController.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/25.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQSRecorderMessagesModel.h"
#import "WQSPlayMusicManager.h"

@interface WQSPlayRecorderViewController : UIViewController

//当前录音的数据模型
@property (nonatomic,strong) WQSRecorderMessagesModel * recorderModel;

//播放列表
@property (nonatomic,strong) NSMutableArray * recorderList;

//当前录音为第几首
@property (nonatomic,assign) NSInteger atListNumber;

@end
