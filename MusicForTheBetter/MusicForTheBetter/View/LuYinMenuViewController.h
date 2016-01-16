//
//  LuYinMenuViewController.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQSChagePitchStringViewController.h"

@interface LuYinMenuViewController : UIViewController

//录音时间
@property (weak, nonatomic) IBOutlet UILabel *luYinTime;

//开始按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin1Button;
//暂停按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin2Button;
//结束按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin3Button;
//保存按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin4Button;
//编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin5Button;
//控制转调页面
@property (nonatomic,strong) WQSChagePitchStringViewController * changePitchVC;


@end
