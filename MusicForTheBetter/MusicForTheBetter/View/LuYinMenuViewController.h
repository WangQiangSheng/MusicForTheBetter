//
//  LuYinMenuViewController.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQSChagePitchStringViewController.h"

typedef void(^LuyinMenuBlock)(NSInteger number);

@interface LuYinMenuViewController : UIViewController

//用于主页操作录音菜单
@property (nonatomic,copy) LuyinMenuBlock luyinBlock;


//暂停按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin2Button;
//录音时间
@property (weak, nonatomic) IBOutlet UILabel *luYinTime;


//播放按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin5Button;

@end
