//
//  WQSChagePitchStringViewController.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/11.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSChagePitchStringViewController.h"

//宏常量
#import "WQSConstant.h"

//键盘
#import "WQSKeyBoardViewController.h"

//音符串转换工具类
#import "WQSChangeMusicString.h"


@interface WQSChagePitchStringViewController ()

//中间的输入TEXTVIEW
@property (nonatomic,strong) UITextView * centerTextView;

//定制键盘
@property (nonatomic,strong) UIView * keyBoardView;

//录音菜单
@property (nonatomic,strong) UIView * luYinMenuView;

//原来调性
@property (nonatomic,strong) NSString * pitchOld;

//目标调性
@property (nonatomic,strong) NSString * picthNew;

@end


@implementation WQSChagePitchStringViewController

#pragma mark - 键盘出现以及影藏相关事件

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)keyBoardWillShow{
    [UIView animateWithDuration:0.25f animations:^{
        self.centerTextView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-216);
    }];
}

-(void)keyBoardWillHide{
    [UIView animateWithDuration:0.25f animations:^{
        self.centerTextView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
//********************************************************

#pragma mark - 创建视图以及初始化数据
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initData];
    [self createView];
    [self createNavationBarItems];
}

-(void)initData{
    
}

-(void)createView{
    
    self.title = @"音符转调";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.centerTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth , ScreenHeight-64)];
    self.centerTextView.backgroundColor = [UIColor lightGrayColor];
    WQSKeyBoardViewController * keyBoardVC = [[WQSKeyBoardViewController alloc]init];
    keyBoardVC.changePitchStringVC = self;
    [self addChildViewController:keyBoardVC];
    self.centerTextView.inputView = keyBoardVC.view;
    
    [self.view addSubview:self.centerTextView];
    
}

-(void)createNavationBarItems{
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(backToOtherVC)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem * luYinButton = [[UIBarButtonItem alloc]initWithTitle:@"录音" style:UIBarButtonItemStylePlain target:self action:@selector(luYinMenu)];
    self.navigationItem.rightBarButtonItem = luYinButton;
    
}

-(void)luYinMenu{
    
    
    
}

-(void)backToOtherVC{
    CATransition * transition = [[CATransition alloc]init];
    transition.duration = 1.0f;
    transition.type = @"reveal";
    [self.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//**********************************************************


#pragma mark - 转换音符

-(void)changeMusicStringAndShow{
    
    //待改善、目前，连着的两个特殊关键字符会出问题EG：#，（，【，{……
    
//    self.centerTextView.text = [WQSChangeMusicString changeFromPitch:self.pitchOld ToPitch:self.pitchNew byTextString:self.centerTextView.text];
    
    
}

























-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
