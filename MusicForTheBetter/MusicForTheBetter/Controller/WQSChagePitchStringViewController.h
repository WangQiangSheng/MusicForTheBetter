//
//  WQSChagePitchStringViewController.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/11.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQSKeyBoardViewController.h"

@class WQSKeyBoardViewController;

@interface WQSChagePitchStringViewController : UIViewController

//中间的输入TEXTVIEW
@property (nonatomic,strong) UITextView * centerTextView;

//定制键盘
@property (nonatomic,strong) WQSKeyBoardViewController * keyBoardVC;

//选择原调性和目标调性键盘
@property (nonatomic,strong) UIPickerView * pitchSelectView;

//输入时键盘上方的视图
@property (nonatomic,strong) UIView * accessoryInputView;

//选调时键盘上方的视图
@property (nonatomic,strong) UIView * accessoryPitchView;


//自定义输入键盘，键盘的头视图
@property (nonatomic,strong) UIButton * inputButton1;
@property (nonatomic,strong) UIButton * inputButton2;
@property (nonatomic,strong) UIButton * inputButton3;
@property (nonatomic,strong) UIButton * inputButton4;

-(void)showAboutSaveMusicString;


@end
