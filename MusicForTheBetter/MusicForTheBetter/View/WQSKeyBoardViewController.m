//
//  WQSKeyBoardViewController.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/11.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSKeyBoardViewController.h"
#import "WQSHelper.h"

@interface WQSKeyBoardViewController ()//WQSChagePitchStringViewController

@end

@implementation WQSKeyBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    for (NSInteger i = 300; i < 320; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:i];
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.0f;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    UIButton * button = (UIButton *)[self.view viewWithTag:305];
    button.backgroundColor = [UIColor lightGrayColor];
}

//初始化数据***************************************
-(void)initData{
    self.keyButton21.selected = YES;
    self.keyButton44.selected = NO;
}

//**********************************下边按钮点击事件
- (IBAction)keyButton11Clicked:(id)sender {
    self.keyBoardBlock(11);
    self.keyButton11.selected = YES;
    self.keyButton11.backgroundColor = [UIColor lightGrayColor];
    self.keyButton21.selected = NO;
    self.keyButton21.backgroundColor = [UIColor whiteColor];
    self.keyButton31.selected = NO;
    self.keyButton31.backgroundColor = [UIColor whiteColor];
}

- (IBAction)keyButton12Clicked:(id)sender {
    self.keyBoardBlock(12);
}

- (IBAction)keyButton13Clicked:(id)sender {
    self.keyBoardBlock(13);
}

- (IBAction)keyButton14Clicked:(id)sender {
    self.keyBoardBlock(14);
}

- (IBAction)keyButton15Clicked:(id)sender {
    self.keyBoardBlock(15);
}

- (IBAction)keyButton21Clicked:(id)sender {
    self.keyBoardBlock(21);
    self.keyButton11.selected = NO;
    self.keyButton11.backgroundColor = [UIColor whiteColor];
    self.keyButton21.selected = YES;
    self.keyButton21.backgroundColor = [UIColor lightGrayColor];
    self.keyButton31.selected = NO;
    self.keyButton31.backgroundColor = [UIColor whiteColor];
}

- (IBAction)keyButton22Clicked:(id)sender {
    self.keyBoardBlock(22);
}

- (IBAction)keyButton23Clicked:(id)sender {
    self.keyBoardBlock(23);
}

- (IBAction)keyButton24Clicked:(id)sender {
    self.keyBoardBlock(24);
}

- (IBAction)keyButton25Clicked:(id)sender {
    self.keyBoardBlock(25);
}

- (IBAction)keyButton31Clicked:(id)sender {
    self.keyBoardBlock(31);
    self.keyButton11.selected = NO;
    self.keyButton11.backgroundColor = [UIColor whiteColor];
    self.keyButton21.selected = NO;
    self.keyButton21.backgroundColor = [UIColor whiteColor];
    self.keyButton31.selected = YES;
    self.keyButton31.backgroundColor = [UIColor lightGrayColor];
}
- (IBAction)keyButton32Clicked:(id)sender {
    self.keyBoardBlock(32);
}
- (IBAction)keyButton33Clicked:(id)sender {
    self.keyBoardBlock(33);
}
- (IBAction)keyButton34Clicked:(id)sender {
    self.keyBoardBlock(34);
}
- (IBAction)keyButton35Clicked:(id)sender {
    self.keyBoardBlock(35);
}

- (IBAction)keyButton41Clicked:(id)sender {
    self.keyBoardBlock(41);
}

- (IBAction)keyButton42Clicked:(id)sender {
    self.keyBoardBlock(42);
}

- (IBAction)keyButton43Clicked:(id)sender {
    self.keyBoardBlock(43);
}

- (IBAction)keyButton44Clicked:(id)sender {
    self.keyBoardBlock(44);
    self.keyButton44.selected = !self.keyButton44.selected;
    if(self.keyButton44.selected){
        self.keyButton44.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.keyButton44.backgroundColor = [UIColor whiteColor];
    }
}

- (IBAction)keyButton45Clicked:(id)sender {
    self.keyBoardBlock(45);
}

//**************************************************************************************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
