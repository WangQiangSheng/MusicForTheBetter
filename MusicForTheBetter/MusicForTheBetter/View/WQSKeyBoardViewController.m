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






@end

@implementation WQSKeyBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger i = 300; i < 320; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:i];
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.0f;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }

}

#pragma mark - 按钮相应事件

//**********************************上边按钮点击事件
- (IBAction)topLeftClicked:(id)sender {
}

- (IBAction)topCenterClicked:(id)sender {
}

- (IBAction)topRightClicked:(id)sender {
}


//**********************************下边按钮点击事件

- (IBAction)keyButton11Clicked:(id)sender {
}
- (IBAction)keyButton12Clicked:(id)sender {
}
- (IBAction)keyButton13Clicked:(id)sender {
}
- (IBAction)keyButton14Clicked:(id)sender {
}
- (IBAction)keyButton15Clicked:(id)sender {
}

- (IBAction)keyButton21Clicked:(id)sender {
}
- (IBAction)keyButton22Clicked:(id)sender {
}
- (IBAction)keyButton23Clicked:(id)sender {
}
- (IBAction)keyButton24Clicked:(id)sender {
}
- (IBAction)keyButton25Clicked:(id)sender {
}

- (IBAction)keyButton31Clicked:(id)sender {
}
- (IBAction)keyButton32Clicked:(id)sender {
}
- (IBAction)keyButton33Clicked:(id)sender {
}
- (IBAction)keyButton34Clicked:(id)sender {
}
- (IBAction)keyButton35Clicked:(id)sender {
}

- (IBAction)keyButton41Clicked:(id)sender {
}
- (IBAction)keyButton42Clicked:(id)sender {
}
- (IBAction)keyButton43Clicked:(id)sender {
}
- (IBAction)keyButton44Clicked:(id)sender {
}
- (IBAction)keyButton45Clicked:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
