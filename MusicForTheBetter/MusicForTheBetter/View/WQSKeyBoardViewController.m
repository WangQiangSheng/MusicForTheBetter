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
//        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    }
    UIButton * button = (UIButton *)[self.view viewWithTag:305];
    button.backgroundColor = [UIColor lightGrayColor];
}

//初始化数据***************************************
-(void)initData{
    self.selectedPitch = 1;
    self.keyButton21.selected = YES;
    self.fontSize = 18.0f;
    self.keyButton44.selected = NO;
    self.pitchOld = @"A";
    self.pitchNew = @"A";
}

//**********************************下边按钮点击事件
- (IBAction)keyButton11Clicked:(id)sender {
    self.selectedPitch = 0;
    self.keyButton11.selected = YES;
    self.keyButton11.backgroundColor = [UIColor lightGrayColor];
    self.keyButton21.selected = NO;
    self.keyButton21.backgroundColor = [UIColor whiteColor];
    self.keyButton31.selected = NO;
    self.keyButton31.backgroundColor = [UIColor whiteColor];
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
    
    if(self.changePitchStringVC.centerTextView.text.length > 0 ){
        
        NSMutableString * textString = [[NSMutableString alloc]initWithString: self.changePitchStringVC.centerTextView.text];
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
            self.changePitchStringVC.centerTextView.text = [textString substringToIndex:textString.length-1];
        }else if ([arrList containsObject:lastChar] && [lastChar2 isEqualToString:@"#"]){
            self.changePitchStringVC.centerTextView.text = [textString substringToIndex:textString.length-2];
        }else if ( ([lastChar isEqualToString:@")"] || [lastChar isEqualToString:@"]"] || [lastChar isEqualToString:@"}"]) &&  ![lastChar3 isEqualToString:@"#"] ){
            self.changePitchStringVC.centerTextView.text = [textString substringToIndex:textString.length-3];
        }else if ( ([lastChar isEqualToString:@")"] || [lastChar isEqualToString:@"]"] || [lastChar isEqualToString:@"}"]) &&  [lastChar3 isEqualToString:@"#"] ){
            self.changePitchStringVC.centerTextView.text = [textString substringToIndex:textString.length-4];
        }
        
    }
    
}

- (IBAction)keyButton15Clicked:(id)sender {
    [self.changePitchStringVC.centerTextView resignFirstResponder];
}

- (IBAction)keyButton21Clicked:(id)sender {
    self.selectedPitch = 1;
    self.keyButton11.selected = NO;
    self.keyButton11.backgroundColor = [UIColor whiteColor];
    self.keyButton21.selected = YES;
    self.keyButton21.backgroundColor = [UIColor lightGrayColor];
    self.keyButton31.selected = NO;
    self.keyButton31.backgroundColor = [UIColor whiteColor];
}

- (IBAction)keyButton22Clicked:(id)sender {
    NSString * oldString = self.changePitchStringVC.centerTextView.text;
    self.changePitchStringVC.centerTextView.text = [self changeString:oldString andString:[self.keyButton22 titleForState:UIControlStateNormal]];
}

- (IBAction)keyButton23Clicked:(id)sender {
    NSString * oldString = self.changePitchStringVC.centerTextView.text;
    self.changePitchStringVC.centerTextView.text = [self changeString:oldString andString:[self.keyButton23 titleForState:UIControlStateNormal]];
}

- (IBAction)keyButton24Clicked:(id)sender {
    NSString * oldString = self.changePitchStringVC.centerTextView.text;
    self.changePitchStringVC.centerTextView.text = [self changeString:oldString andString:[self.keyButton24 titleForState:UIControlStateNormal]];
}

- (IBAction)keyButton25Clicked:(id)sender {
    [UIView animateWithDuration:0.25f animations:^{
        [self.changePitchStringVC.centerTextView resignFirstResponder];
        self.changePitchStringVC.centerTextView.inputView = self.changePitchStringVC.pitchSelectView;
        self.changePitchStringVC.centerTextView.inputAccessoryView = self.changePitchStringVC.accessoryPitchView;
        [self.changePitchStringVC.centerTextView becomeFirstResponder];
    }];
}

- (IBAction)keyButton31Clicked:(id)sender {
    self.selectedPitch = 2;
    self.keyButton11.selected = NO;
    self.keyButton11.backgroundColor = [UIColor whiteColor];
    self.keyButton21.selected = NO;
    self.keyButton21.backgroundColor = [UIColor whiteColor];
    self.keyButton31.selected = YES;
    self.keyButton31.backgroundColor = [UIColor lightGrayColor];
}
- (IBAction)keyButton32Clicked:(id)sender {
    NSString * oldString = self.changePitchStringVC.centerTextView.text;
    self.changePitchStringVC.centerTextView.text = [self changeString:oldString andString:[self.keyButton32 titleForState:UIControlStateNormal]];
}
- (IBAction)keyButton33Clicked:(id)sender {
    NSString * oldString = self.changePitchStringVC.centerTextView.text;
    self.changePitchStringVC.centerTextView.text = [self changeString:oldString andString:[self.keyButton33 titleForState:UIControlStateNormal]];
}
- (IBAction)keyButton34Clicked:(id)sender {
    NSString * oldString = self.changePitchStringVC.centerTextView.text;
    self.changePitchStringVC.centerTextView.text = [self changeString:oldString andString:[self.keyButton34 titleForState:UIControlStateNormal]];
}
- (IBAction)keyButton35Clicked:(id)sender {
    
    [self.changePitchStringVC showAboutSaveMusicString];
    
    //***************************************************数据库保存
    
}

- (IBAction)keyButton41Clicked:(id)sender {
     self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@\n",self.changePitchStringVC.centerTextView.text];
}

- (IBAction)keyButton42Clicked:(id)sender {
    NSString * oldString = self.changePitchStringVC.centerTextView.text;
    self.changePitchStringVC.centerTextView.text = [self changeString:oldString andString:[self.keyButton42 titleForState:UIControlStateNormal]];
}

- (IBAction)keyButton43Clicked:(id)sender {
    self.changePitchStringVC.centerTextView.text = [NSString stringWithFormat:@"%@ ",self.changePitchStringVC.centerTextView.text];
}

- (IBAction)keyButton44Clicked:(id)sender {
    self.keyButton44.selected = !self.keyButton44.selected;
    if(self.keyButton44.selected){
        self.keyButton44.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.keyButton44.backgroundColor = [UIColor whiteColor];
    }
}

- (IBAction)keyButton45Clicked:(id)sender {
    [self.changePitchStringVC.centerTextView resignFirstResponder];
    self.changePitchStringVC.centerTextView.editable = NO;
}

#pragma mark - 控制键盘的输入……

-(NSString *)changeString:(NSString *) allString andString:(NSString *) newString{
    NSString * allStr = nil;
    NSString * lastPitch = nil;
    
    if(!self.keyButton44.selected){
        [self.changePitchStringVC.inputButton1 setTitle:[NSString stringWithFormat:@"(%@)",newString] forState:UIControlStateNormal];
        [self.changePitchStringVC.inputButton2 setTitle:[NSString stringWithFormat:@"%@",newString] forState:UIControlStateNormal];
        [self.changePitchStringVC.inputButton3 setTitle:[NSString stringWithFormat:@"[%@]",newString] forState:UIControlStateNormal];
    
        if(self.selectedPitch == 0){
            lastPitch = [NSString stringWithFormat:@"[%@]",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.changePitchStringVC.inputButton4 setTitle:[NSString stringWithFormat:@"[#%@]",newString] forState:UIControlStateNormal];
        }else if (self.selectedPitch == 1){
            lastPitch = newString;
            allStr = [NSString stringWithFormat:@"%@%@",allString,newString];
            [self.changePitchStringVC.inputButton4 setTitle:[NSString stringWithFormat:@"#%@",newString] forState:UIControlStateNormal];
        }else if (self.selectedPitch == 2){
            lastPitch = [NSString stringWithFormat:@"(%@)",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.changePitchStringVC.inputButton4 setTitle:[NSString stringWithFormat:@"(#%@)",newString] forState:UIControlStateNormal];
        }
    }else{
        [self.changePitchStringVC.inputButton1 setTitle:[NSString stringWithFormat:@"(#%@)",newString] forState:UIControlStateNormal];
        [self.changePitchStringVC.inputButton2 setTitle:[NSString stringWithFormat:@"#%@",newString] forState:UIControlStateNormal];
        [self.changePitchStringVC.inputButton3 setTitle:[NSString stringWithFormat:@"[#%@]",newString] forState:UIControlStateNormal];
        
        if(self.selectedPitch == 0){
            lastPitch = [NSString stringWithFormat:@"[#%@]",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.changePitchStringVC.inputButton4 setTitle:[NSString stringWithFormat:@"[%@]",newString] forState:UIControlStateNormal];
        }else if (self.selectedPitch == 1){
            lastPitch = [NSString stringWithFormat:@"#%@",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.changePitchStringVC.inputButton4 setTitle:[NSString stringWithFormat:@"%@",newString] forState:UIControlStateNormal];
        }else if (self.selectedPitch == 2){
            lastPitch = [NSString stringWithFormat:@"(#%@)",newString];
            allStr = [NSString stringWithFormat:@"%@%@",allString,lastPitch];
            [self.changePitchStringVC.inputButton4 setTitle:[NSString stringWithFormat:@"(%@)",newString] forState:UIControlStateNormal];
        }
    }
    return allStr;
}

//**************************************************************************************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
