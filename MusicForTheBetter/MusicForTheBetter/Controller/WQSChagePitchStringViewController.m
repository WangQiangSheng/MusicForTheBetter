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

//0：高音 、 1：中音 、 2：低音
@property (nonatomic,assign) NSInteger selectedPitch;

//中间的输入框的字体大小设置
@property (nonatomic,assign) CGFloat fontSize;

//设置半音键
@property (nonatomic,assign) BOOL semitone;

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
    self.selectedPitch = 1;
    self.yesOrNo = NO;
    self.semitone = NO;
    self.fontSize = 18.0f;
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
    [self addKeyBoardBlock];
    [self addChildViewController:self.keyBoardVC];
    self.centerTextView.inputView = self.keyBoardVC.view;
    self.centerTextView.inputAccessoryView = self.accessoryInputView;
    self.centerTextView.font = [UIFont systemFontOfSize:self.fontSize];
    [self.view addSubview:self.centerTextView];
    
    self.pitchSelectView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 216)];
    self.pitchSelectView.delegate = self;
    self.pitchSelectView.dataSource = self;
    self.pitchSelectView.backgroundColor = [UIColor whiteColor];

}

#pragma mark - 键盘相应事件

-(void)addKeyBoardBlock{
    __weak typeof(self) weakSelf = self;
    
    self.keyBoardVC.keyBoardBlock = ^(NSInteger number){
        
        switch (number) {
            case 11:
                weakSelf.selectedPitch = 0;
                break;
                //------------------------------------------------->
                
            case 12:
                weakSelf.fontSize += 1.0;
                weakSelf.centerTextView.font = [UIFont systemFontOfSize:weakSelf.fontSize];
                break;
                //------------------------------------------------->
                
            case 13:
                weakSelf.fontSize -= 1.0;
                weakSelf.centerTextView.font = [UIFont systemFontOfSize:weakSelf.fontSize];
                break;
                //------------------------------------------------->
                
            case 14:
                if(weakSelf.centerTextView.text.length > 0 ){
                    NSMutableString * textString = [[NSMutableString alloc]initWithString: weakSelf.centerTextView.text];
                    NSRange rangeLastChar  = NSMakeRange(textString.length-1, 1);
                    NSRange rangeLastChar2 = NSMakeRange(textString.length-2, 1);
                    NSRange rangeLastChar3 = NSMakeRange(textString.length-3, 1);
                    NSArray * arrList = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
                    NSArray * arrList2 = @[@" ",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"\n"];
                    NSString * lastChar = [textString substringWithRange:rangeLastChar];
                    NSString * lastChar2 = nil;
                    NSString * lastChar3 = nil;
                    if(textString.length > 1){
                        lastChar2 = [textString substringWithRange:rangeLastChar2];
                    }
                    if(textString.length > 2){
                        lastChar3 = [textString substringWithRange:rangeLastChar3];
                    }
                    
                    if([arrList2 containsObject:lastChar] && ![lastChar2 isEqualToString:@"#"]){
                        weakSelf.centerTextView.text = [textString substringToIndex:textString.length-1];
                    }else if ([arrList containsObject:lastChar] && [lastChar2 isEqualToString:@"#"]){
                        weakSelf.centerTextView.text = [textString substringToIndex:textString.length-2];
                    }else if ( ([lastChar isEqualToString:@")"] || [lastChar isEqualToString:@"]"] || [lastChar isEqualToString:@"}"]) &&  ![lastChar3 isEqualToString:@"#"] ){
                        weakSelf.centerTextView.text = [textString substringToIndex:textString.length-3];
                    }else if ( ([lastChar isEqualToString:@")"] || [lastChar isEqualToString:@"]"] || [lastChar isEqualToString:@"}"]) &&  [lastChar3 isEqualToString:@"#"] ){
                        weakSelf.centerTextView.text = [textString substringToIndex:textString.length-4];
                    }
                    
                }
                break;
                //------------------------------------------------->
                
            case 15:
                [weakSelf.centerTextView resignFirstResponder];
                break;
                //------------------------------------------------->
                
            case 21:
                weakSelf.selectedPitch = 1;
                break;
                //------------------------------------------------->
                
            case 22:
                weakSelf.centerTextView.text = [weakSelf changeString:weakSelf.centerTextView.text andString:@"1"];
                break;
                //------------------------------------------------->
                
            case 23:
                weakSelf.centerTextView.text = [weakSelf changeString:weakSelf.centerTextView.text andString:@"2"];
                break;
                //------------------------------------------------->
                
            case 24:
                weakSelf.centerTextView.text = [weakSelf changeString:weakSelf.centerTextView.text andString:@"3"];
                break;
                //------------------------------------------------->
                
            case 25:
                [weakSelf changeKeyBoard];
                break;
                //------------------------------------------------->
                
            case 31:
                weakSelf.selectedPitch = 2;
                break;
                //------------------------------------------------->
                
            case 32:
                weakSelf.centerTextView.text = [weakSelf changeString:weakSelf.centerTextView.text andString:@"4"];
                break;
                //------------------------------------------------->
                
            case 33:
                weakSelf.centerTextView.text = [weakSelf changeString:weakSelf.centerTextView.text andString:@"5"];
                break;
                //------------------------------------------------->
                
            case 34:
                weakSelf.centerTextView.text = [weakSelf changeString:weakSelf.centerTextView.text andString:@"6"];
                break;
                //------------------------------------------------->
                
            case 35:
                [weakSelf showAboutSaveMusicString];
                break;
                //------------------------------------------------->
                
            case 41:
                weakSelf.centerTextView.text = [NSString stringWithFormat:@"%@\n",weakSelf.centerTextView.text];
                break;
                //------------------------------------------------->
                
            case 42:
                weakSelf.centerTextView.text = [weakSelf changeString:weakSelf.centerTextView.text andString:@"7"];
                break;
                //------------------------------------------------->
                
            case 43:
                weakSelf.centerTextView.text = [NSString stringWithFormat:@"%@ ",weakSelf.centerTextView.text];
                break;
                //------------------------------------------------->
                
            case 44:
                weakSelf.semitone = !weakSelf.semitone;
                break;
                //------------------------------------------------->
                
            case 45:
                [weakSelf.centerTextView resignFirstResponder];
                weakSelf.centerTextView.editable = NO;
                break;
                //------------------------------------------------->
                
            default:
                NSLog(@"键盘错误！！！");
                break;
        }
        
    };
}

//动画切换两键盘
-(void)changeKeyBoard{
    [UIView animateWithDuration:0.55f animations:^{
        [self.centerTextView resignFirstResponder];
        self.centerTextView.inputView = self.pitchSelectView;
        self.centerTextView.inputAccessoryView = self.accessoryPitchView;
        [self.centerTextView becomeFirstResponder];
    }];
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
        [self.centerTextView resignFirstResponder];
    }
}

-(void)createNavationBarItems{
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(backToOtherVC)];
    self.navigationItem.leftBarButtonItem = backButton;
    UIBarButtonItem * luYinButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(luYinMenu)];
    self.navigationItem.rightBarButtonItem = luYinButton;
}

-(void)luYinMenu{
    if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"确定"]){
        [self.centerTextView resignFirstResponder];
        self.navigationItem.rightBarButtonItem.title = @"取消";
    }else{
        [self.centerTextView becomeFirstResponder];
        self.navigationItem.rightBarButtonItem.title = @"确定";
    }
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

#pragma mark - 控制键盘的输入……

-(NSString *)changeString:(NSString *) allString andString:(NSString *) newString{
    NSString * allStr = nil;
    NSString * lastPitch = nil;
    
    if(!self.semitone){
        [self.inputButton1 setTitle:[NSString stringWithFormat:@"(%@)",newString] forState:UIControlStateNormal];
        [self.inputButton2 setTitle:[NSString stringWithFormat:@"%@",newString] forState:UIControlStateNormal];
        [self.inputButton3 setTitle:[NSString stringWithFormat:@"[%@]",newString] forState:UIControlStateNormal];
        
        if(self.selectedPitch == 0){
            lastPitch = [NSString stringWithFormat:@"[%@]",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.inputButton4 setTitle:[NSString stringWithFormat:@"[#%@]",newString] forState:UIControlStateNormal];
        }else if (self.selectedPitch == 1){
            lastPitch = newString;
            allStr = [NSString stringWithFormat:@"%@%@",allString,newString];
            [self.inputButton4 setTitle:[NSString stringWithFormat:@"#%@",newString] forState:UIControlStateNormal];
        }else if (self.selectedPitch == 2){
            lastPitch = [NSString stringWithFormat:@"(%@)",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.inputButton4 setTitle:[NSString stringWithFormat:@"(#%@)",newString] forState:UIControlStateNormal];
        }
    }else{
        [self.inputButton1 setTitle:[NSString stringWithFormat:@"(#%@)",newString] forState:UIControlStateNormal];
        [self.inputButton2 setTitle:[NSString stringWithFormat:@"#%@",newString] forState:UIControlStateNormal];
        [self.inputButton3 setTitle:[NSString stringWithFormat:@"[#%@]",newString] forState:UIControlStateNormal];
        
        if(self.selectedPitch == 0){
            lastPitch = [NSString stringWithFormat:@"[#%@]",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.inputButton4 setTitle:[NSString stringWithFormat:@"[%@]",newString] forState:UIControlStateNormal];
        }else if (self.selectedPitch == 1){
            lastPitch = [NSString stringWithFormat:@"#%@",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.inputButton4 setTitle:[NSString stringWithFormat:@"%@",newString] forState:UIControlStateNormal];
        }else if (self.selectedPitch == 2){
            lastPitch = [NSString stringWithFormat:@"(#%@)",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.inputButton4 setTitle:[NSString stringWithFormat:@"(%@)",newString] forState:UIControlStateNormal];
        }
    }
    return allStr;
}








-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
