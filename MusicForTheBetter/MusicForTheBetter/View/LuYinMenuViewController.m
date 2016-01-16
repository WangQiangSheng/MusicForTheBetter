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


@property (weak, nonatomic) IBOutlet UILabel *menuLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation LuYinMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
}

//暂停按钮
- (IBAction)luYin2ButtonClicked:(id)sender {
    
}

//结束按钮
- (IBAction)luYin3ButtonClicked:(id)sender {
    
}

//保存按钮
- (IBAction)luYin4ButtonClicked:(id)sender {
    
}

//编辑按钮
- (IBAction)luYin5ButtonClicked:(id)sender {
    
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
