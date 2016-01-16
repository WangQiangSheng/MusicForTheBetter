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
//正常输入键盘
#import "WQSKeyBoardViewController.h"
//音符串转换工具类
#import "WQSChangeMusicString.h"
//录音菜单
#import "LuYinMenuViewController.h"
//
#import "WQSDataBaseManager.h"
#import "WQSMusicStringModel.h"


@interface WQSChagePitchStringViewController () <UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>

//录音菜单
@property (nonatomic,strong) LuYinMenuViewController * luYinMenuVC;
//原来调性
@property (nonatomic,strong) NSString * pitchOld;
//目标调性
@property (nonatomic,strong) NSString * pitchNew;
//选调数据源
@property (nonatomic,strong) NSArray * pitchArrayData;
//自定义选调键盘，键盘的头视图
@property (nonatomic,strong) UIButton * pitchButton1;
@property (nonatomic,strong) UIButton * pitchButton2;
//是否有动过转调键盘
@property (nonatomic,assign) BOOL yesOrNo;


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
        self.centerTextView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-216-54);
    }];
}

-(void)keyBoardWillHide{
    [UIView animateWithDuration:0.25f animations:^{
        self.centerTextView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-100);
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
    NSArray * oldPitch = @[@"A",@"#A",@"B",@"C",@"#C",@"D",@"#D",@"E",@"F",@"#F",@"G",@"#G"];
    NSArray * newPitch = @[@"A",@"#A",@"B",@"C",@"#C",@"D",@"#D",@"E",@"F",@"#F",@"G",@"#G"];
    self.pitchArrayData = @[oldPitch,newPitch];
    self.pitchOld = @"A";
    self.pitchNew = @"A";
    self.yesOrNo = NO;
}

-(void)createView{
    
    self.title = @"音符转调";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.centerTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth , ScreenHeight-64-100)];
    self.centerTextView.backgroundColor = RGB(230, 230, 230);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    LuYinMenuViewController * luYinMenu = [[LuYinMenuViewController alloc]init];
    UIView * luYinView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-100, ScreenWidth, 100)];
    [self.view addSubview:luYinView];
    luYinMenu.view.frame = luYinView.bounds;
    [luYinView addSubview:luYinMenu.view];
    [self addChildViewController:luYinMenu];
    luYinMenu.changePitchVC = self;
    
    //创建键盘上方的视图
    [self createInputTopView];
    
    self.keyBoardVC = [[WQSKeyBoardViewController alloc]init];
    self.keyBoardVC.changePitchStringVC = self;
    [self addChildViewController:self.keyBoardVC];
    self.centerTextView.inputView = self.keyBoardVC.view;
    self.centerTextView.inputAccessoryView = self.accessoryInputView;
    self.centerTextView.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:self.centerTextView];
    
    self.pitchSelectView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 216)];
    self.pitchSelectView.delegate = self;
    self.pitchSelectView.dataSource = self;
    self.pitchSelectView.backgroundColor = [UIColor whiteColor];

}

#pragma mark - 创建键盘上方的视图
-(void)createInputTopView{
    
    self.accessoryInputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    self.accessoryInputView.backgroundColor = [UIColor whiteColor];
    self.inputButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.inputButton1.tag = 400;
    [self.accessoryInputView addSubview:self.inputButton1];
    self.inputButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.inputButton2.tag = 401;
    [self.accessoryInputView addSubview:self.inputButton2];
    self.inputButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.inputButton3.tag = 402;
    [self.accessoryInputView addSubview:self.inputButton3];
    self.inputButton4 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.inputButton4.tag = 403;
    [self.accessoryInputView addSubview:self.inputButton4];
    
    for (NSInteger i = 400 ; i < 404 ; i++ ) {
        UIButton * button = (UIButton *)[self.accessoryInputView viewWithTag:i];
        button.frame = CGRectMake((i-400)*ScreenWidth/4.0, 5, ScreenWidth/4.0, 40);
        [button addTarget:self action:@selector(inputViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    self.accessoryPitchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    self.accessoryPitchView.backgroundColor = [UIColor whiteColor];
    self.pitchButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.pitchButton1.tag = 410;
    [self.accessoryPitchView addSubview:self.pitchButton1];
    [self.pitchButton1 setTitle:@"取消" forState:UIControlStateNormal];
    self.pitchButton1.frame = CGRectMake(20, 5, 60, 44);
    [self.pitchButton1 addTarget:self action:@selector(pitchViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.pitchButton1.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.pitchButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.pitchButton2.tag = 411;
    [self.accessoryPitchView addSubview:self.pitchButton2];
    [self.pitchButton2 setTitle:@"确定" forState:UIControlStateNormal];
    self.pitchButton2.frame = CGRectMake(ScreenWidth - 80, 5, 60, 44);
    [self.pitchButton2 addTarget:self action:@selector(pitchViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.pitchButton2.titleLabel.font = [UIFont systemFontOfSize:18.0f];
}

-(void)inputViewButtonClicked:(UIButton *) button{
    [self.keyBoardVC keyButton14Clicked:nil];
    self.centerTextView.text = [NSString stringWithFormat:@"%@%@",self.centerTextView.text,[button titleForState:UIControlStateNormal]];
    for (NSInteger i = 400 ; i < 404 ; i++ ) {
        UIButton * button = (UIButton *)[self.accessoryInputView viewWithTag:i];
        [button setTitle:@"" forState:UIControlStateNormal];
    }
}

-(void)pitchViewButtonClicked:(UIButton *) button{
    if(button.tag == 410){
        [UIView animateWithDuration:0.25f animations:^{
            [self.centerTextView resignFirstResponder];
            self.centerTextView.inputView = self.keyBoardVC.view;
            self.centerTextView.inputAccessoryView = self.accessoryInputView;
            [self.centerTextView becomeFirstResponder];
        }];
    }else{
        self.centerTextView.text = [WQSChangeMusicString changeFromPitch:self.pitchOld ToPitch:self.pitchNew byTextString:self.centerTextView.text];
        self.keyBoardVC.pitchOld = self.pitchOld;
        self.keyBoardVC.pitchNew = self.pitchNew;
        [self.centerTextView resignFirstResponder];
    }
}

-(void)createNavationBarItems{
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(backToOtherVC)];
    self.navigationItem.leftBarButtonItem = backButton;
    UIBarButtonItem * luYinButton = [[UIBarButtonItem alloc]initWithTitle:@"录音" style:UIBarButtonItemStylePlain target:self action:@selector(luYinMenu)];
    self.navigationItem.rightBarButtonItem = luYinButton;
}

-(void)luYinMenu{
    
    
    
}

//返回主页面、加入动画
-(void)backToOtherVC{
    CATransition * transition = [[CATransition alloc]init];
    transition.duration = 1.0f;
    transition.type = @"reveal";
    [self.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

//**********************************************************

//在没转调前不支持保存，如果用户点击保存，则会提示用户，
-(void)showAboutSaveMusicString{
    if(!self.yesOrNo){
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示：" message:@"只有转过调的谱子，才支持保存到本地哦~~~" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * acitonDefault = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:acitonDefault];
        CATransition * transition = [[CATransition alloc]init];
        transition.duration = 0.45;
        transition.type = @"rippleEffect";
        [self.view.layer addAnimation:transition forKey:nil];
        [self presentViewController:alertC animated:YES completion:nil];
    }else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"保存" message:@"请输入您要保存到本地的名字：" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    /**
     *id 主键，用于唯一标示，能自增一
     *title 谱的名字，（由用户输入，并自动加上原调、目标调）
     *numbersstring 简谱内容
     *time 保存时间
     *username 用户名称（昵称）
     *userphone 用户账号（手机号）
     */
    
    WQSDataBaseManager * manager = [WQSDataBaseManager shareDataBaseManager];
    WQSMusicStringModel * model = [[WQSMusicStringModel alloc]init];
    
    if(buttonIndex == 0){
        UITextField * textField = [alertView textFieldAtIndex:0];
        NSString * title = [NSString stringWithFormat:@"%@ (%@调->%@调)",textField.text,self.pitchOld,self.pitchNew];
        model.title = title;
    }
    model.numbersstring = self.centerTextView.text;
    model.username = @"浮生若梦亦如烟";
    model.userphone = @"18137270550";
    [manager insertAMessageToDataBase:model];
}

#pragma mark - 选调相关代理 - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [self.pitchArrayData count];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return [[self.pitchArrayData objectAtIndex:component] count];
    }else{
        return [[self.pitchArrayData objectAtIndex:component] count];
    }
}

#pragma mark - 选调相关代理 - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [NSString stringWithFormat:@"原调：%@",[[self.pitchArrayData objectAtIndex:component] objectAtIndex:row]];
    }else{
        return [NSString stringWithFormat:@"目标：%@",[[self.pitchArrayData objectAtIndex:component] objectAtIndex:row]];;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        self.pitchOld = [[self.pitchArrayData objectAtIndex:0] objectAtIndex:row];
        self.yesOrNo = YES;
    }else{
        self.pitchNew = [[self.pitchArrayData objectAtIndex:1] objectAtIndex:row];
        self.yesOrNo = YES;
    }
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
