//
//  LuYinMenuViewController.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/15.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSConstant.h"
#import "LuYinMenuViewController.h"

@interface LuYinMenuViewController ()



//开始按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin1Button;

//结束按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin3Button;
//保存按钮
@property (weak, nonatomic) IBOutlet UIButton *luYin4Button;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *menuLabel;


@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,assign) NSInteger timeNumber;

@end

@implementation LuYinMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timer = nil;
    self.timeNumber = 0;
    self.luYin2Button.selected = YES;
    self.luYin3Button.selected = YES;
    self.luYin4Button.selected = YES;
    
    [self createView];
}

-(void)createView{
    if(ScreenWidth > 375){
        self.menuLabel.font = [UIFont systemFontOfSize:30.0f];
        self.timeLabel.font = [UIFont systemFontOfSize:28.0f];
        self.luYinTime.font = [UIFont systemFontOfSize:28.0f];
    }else if (ScreenWidth < 375){
        self.menuLabel.font = [UIFont systemFontOfSize:25.0f];
        self.timeLabel.font = [UIFont systemFontOfSize:21.0f];
        self.luYinTime.font = [UIFont systemFontOfSize:21.0f];
    }
    
    for (NSInteger i = 500; i < 505; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:i];
        button.layer.cornerRadius = 10.0f;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 3.0f;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
}

//开始按钮
- (IBAction)luYin1ButtonClicked:(id)sender {
    self.luYin2Button.selected = NO;
    self.luYin3Button.selected = NO;
    self.luYin4Button.selected = NO;
    if(!self.luYin1Button.selected){
        self.luyinBlock(61);
    }
    
}

//暂停按钮   暂停:62
- (IBAction)luYin2ButtonClicked:(id)sender {
    if(!self.luYin2Button.selected){
        self.luyinBlock(62);
    }
}

//结束按钮
- (IBAction)luYin3ButtonClicked:(id)sender {
    
    if(!self.luYin3Button.selected){
        self.luyinBlock(63);
    }
    self.luYin2Button.selected = YES;
    self.luYin3Button.selected = YES;
    [self.luYin2Button setTitle:@"暂停" forState:UIControlStateNormal];
}

//保存按钮
- (IBAction)luYin4ButtonClicked:(id)sender {
    
    if(!self.luYin4Button.selected){
        self.luyinBlock(64);
    }
    self.luYin2Button.selected = YES;
    self.luYin3Button.selected = YES;
    self.luYin4Button.selected = YES;
    [self.luYin2Button setTitle:@"暂停" forState:UIControlStateNormal];
}

//播放按钮
- (IBAction)luYin5ButtonClicked:(id)sender {
    self.luyinBlock(65);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
