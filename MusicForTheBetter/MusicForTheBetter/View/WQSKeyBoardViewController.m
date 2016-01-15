//
//  WQSKeyBoardViewController.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/11.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSKeyBoardViewController.h"

@interface WQSKeyBoardViewController ()//WQSChagePitchStringViewController

//0：高音 、 1：中音 、 2：低音
@property (nonatomic,assign) NSInteger selectedPitch;

//中间的输入框的字体大小设置
@property (nonatomic,assign) CGFloat fontSize;



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
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    }
}

//初始化数据***************************************
-(void)initData{
    self.selectedPitch = 1;
    self.keyButton21.selected = YES;
}


//**********************************下边按钮点击事件

- (IBAction)keyButton11Clicked:(id)sender {
    self.selectedPitch = 0;
}
- (IBAction)keyButton12Clicked:(id)sender {
    self.fontSize += 1.0;
    self.changePitchStringVC.centerTextView.font = [UIFont systemFontOfSize:self.fontSize];
}
- (IBAction)keyButton13Clicked:(id)sender {
    self.fontSize -= 1.0;
    self.changePitchStringVC.centerTextView.font = [UIFont systemFontOfSize:self.fontSize];
}
- (IBAction)keyButton14Clicked:(id)sender {
    //******************************后面慢慢写
}
- (IBAction)keyButton15Clicked:(id)sender {
    [self.changePitchStringVC.centerTextView resignFirstResponder];
}

- (IBAction)keyButton21Clicked:(id)sender {
    self.selectedPitch = 0;
}
- (IBAction)keyButton22Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@1",self.changePitchStringVC.centerTextView.text];
}
- (IBAction)keyButton23Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@2",self.changePitchStringVC.centerTextView.text];
}
- (IBAction)keyButton24Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@3",self.changePitchStringVC.centerTextView.text];
}
- (IBAction)keyButton25Clicked:(id)sender {
    [self.changePitchStringVC.centerTextView resignFirstResponder];
    
    
}

- (IBAction)keyButton31Clicked:(id)sender {
    self.selectedPitch = 1;
}
- (IBAction)keyButton32Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@4",self.changePitchStringVC.centerTextView.text];
}
- (IBAction)keyButton33Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@5",self.changePitchStringVC.centerTextView.text];
}
- (IBAction)keyButton34Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@6",self.changePitchStringVC.centerTextView.text];
}
- (IBAction)keyButton35Clicked:(id)sender {
    
}
- (IBAction)keyButton41Clicked:(id)sender {
    
}
- (IBAction)keyButton42Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@7",self.changePitchStringVC.centerTextView.text];
}
- (IBAction)keyButton43Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@\n",self.changePitchStringVC.centerTextView.text];
}
- (IBAction)keyButton44Clicked:(id)sender {
    
}
- (IBAction)keyButton45Clicked:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
