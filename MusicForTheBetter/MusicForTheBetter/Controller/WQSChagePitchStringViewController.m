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


@interface WQSChagePitchStringViewController () <UIPickerViewDataSource,UIPickerViewDelegate>


//定制键盘
@property (nonatomic,strong) UIView * keyBoardView;

//录音菜单
@property (nonatomic,strong) UIView * luYinMenuView;

//原来调性
@property (nonatomic,strong) NSString * pitchOld;

//目标调性
@property (nonatomic,strong) NSString * picthNew;

//选择原调性和目标调性
@property (nonatomic,strong) UIPickerView * pitchSelectView;

//输入时键盘上方的视图
@property (nonatomic,strong) UIView * accessoryInputView;

//选调时键盘上方的视图
@property (nonatomic,strong) UIView * accessoryPitchView;

//选调数据源
@property (nonatomic,strong) NSArray * pitchArrayData;


//自定义输入键盘，键盘的头视图
@property (nonatomic,strong) UIButton * inputButton1;
@property (nonatomic,strong) UIButton * inputButton2;
@property (nonatomic,strong) UIButton * inputButton3;
@property (nonatomic,strong) UIButton * inputButton4;

//自定义选调键盘，键盘的头视图
@property (nonatomic,strong) UIButton * pitchButton1;
@property (nonatomic,strong) UIButton * pitchButton2;

//
//
//
//
//
//
//
//
//




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
    NSArray * oldPitch = @[@"A",@"#A",@"B",@"C",@"#C",@"D",@"#D",@"E",@"F",@"#F",@"G",@"#G"];
    NSArray * newPitch = @[@"A",@"#A",@"B",@"C",@"#C",@"D",@"#D",@"E",@"F",@"#F",@"G",@"#G"];
    self.pitchArrayData = @[oldPitch,newPitch];
}

-(void)createView{
    
    self.title = @"音符转调";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.centerTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth , ScreenHeight-64)];
    self.centerTextView.backgroundColor = [UIColor lightGrayColor];
    //创建键盘上方的视图
    [self createInputTopView];
    
    WQSKeyBoardViewController * keyBoardVC = [[WQSKeyBoardViewController alloc]init];
    keyBoardVC.changePitchStringVC = self;
    [self addChildViewController:keyBoardVC];
    self.centerTextView.inputView = keyBoardVC.view;
    self.centerTextView.inputAccessoryView = self.accessoryInputView;
    [self.view addSubview:self.centerTextView];
    
    self.pitchSelectView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 216)];
    self.pitchSelectView.delegate = self;
    self.pitchSelectView.dataSource = self;
    self.pitchSelectView.backgroundColor = [UIColor whiteColor];


}

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
        [button addTarget:self action:@selector(inputViewButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%ld",i] forState:UIControlStateNormal];
    }
    
    self.accessoryPitchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    
    
    
    
}

-(void)inputViewButtonClicked{
    
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
//    return [[self.pitchArrayData objectAtIndex:component] objectAtIndex:row];
    if(component == 0){
        return [NSString stringWithFormat:@"原调：%@",[[self.pitchArrayData objectAtIndex:component] objectAtIndex:row]];
    }else{
        return [NSString stringWithFormat:@"目标：%@",[[self.pitchArrayData objectAtIndex:component] objectAtIndex:row]];;
    }

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        self.pitchOld = [[self.pitchArrayData objectAtIndex:0] objectAtIndex:row];
    }else{
        self.picthNew = [[self.pitchArrayData objectAtIndex:1] objectAtIndex:row];
    }
}






-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
