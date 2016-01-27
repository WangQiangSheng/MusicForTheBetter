//
//  WQSRocorderTableViewCell.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/26.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQSRocorderTableViewCell : UITableViewCell

//左上角图标
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

//录音名称
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//作者名称
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

//录音自身时长
@property (weak, nonatomic) IBOutlet UILabel *recorderTimeLabel;

//录音时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

//录音播放列表
@property (nonatomic,strong) NSMutableArray * recorderList;

//当前录音在录音列表的位置
@property (nonatomic,assign) NSInteger atListNumber;

//爱心  标注
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;





@end
