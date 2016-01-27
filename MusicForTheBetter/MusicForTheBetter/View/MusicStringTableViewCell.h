//
//  MusicStringTableViewCell.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/22.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
#import "WQSMusicStringModel.h"
#import "LocalResourceViewController.h"

typedef void(^MusicStringBlock)(NSInteger number);

@interface MusicStringTableViewCell : UITableViewCell <UMSocialUIDelegate>

//简谱名称
@property (weak, nonatomic) IBOutlet UILabel *titleMusicString;

//转调标志
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;

//制作人昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//时间Label
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

//其他按钮（暂时还没想到）
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

//查看按钮
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

//分享按钮
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak,nonatomic) WQSMusicStringModel * musicStringModel;

@property (nonatomic,copy) MusicStringBlock musicBlock;

@property (nonatomic,assign) id <UMSocialUIDelegate> fatherVC;

@end
