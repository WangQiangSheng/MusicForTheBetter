//
//  ViewController.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/11.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "ViewController.h"

//定义部分宏常量
#import "WQSConstant.h"

//音符转换页面
#import "WQSChagePitchStringViewController.h"

#define Left [UIScreen mainScreen].bounds.size.width/5.0
#define Bottom [UIScreen mainScreen].bounds.size.height/6.0
#define r [UIScreen mainScreen].bounds.size.width/2.0
#define PI 3.1415

#define POINT_X ([UIScreen mainScreen].bounds.size.width/5.0 - [UIScreen mainScreen].bounds.size.width/8.0 + [UIScreen mainScreen].bounds.size.width/16.0)
#define POINT_Y (ScreenHeight - Bottom + [UIScreen mainScreen].bounds.size.width/8.0 - [UIScreen mainScreen].bounds.size.width/16.0)

@interface ViewController (){
//    MusicStringViewController * _mvc;
}

@property (nonatomic,strong) NSArray * titleArr;

@property (nonatomic,strong) NSArray * num;

@property (nonatomic,strong) UIButton * button;

@property (nonatomic,strong) NSArray * pages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self createView];

}

//初始化数据
-(void)initData{
//    self.titleArr = @[@"转谱",@"查看",@"录音",@"搜索",@"帮助",@"关于"];
    self.titleArr = @[@"",@"",@"",@"",@"",@""];
    self.num = @[@(POINT_X),                                      @(POINT_Y - r),
                 @(POINT_X + r*sin(18/180.0 * M_PI)),             @(POINT_Y - r*cos(18/180.0 * M_PI)),
                 @(POINT_X + r*sin(36/180.0 * M_PI)),             @(POINT_Y - r*cos(36/180.0 * M_PI)),
                 @(POINT_X + r*sin(54/180.0 * M_PI)),             @(POINT_Y - r*cos(54/180.0 * M_PI)),
                 @(POINT_X + r*sin(72/180.0 * M_PI)),             @(POINT_Y - r*cos(72/180.0 * M_PI)),
                 @(POINT_X + r),                                  @(POINT_Y)];
    
//    NSLog(@"POINT_X:%lf        POINTF_Y:%lf      R:%lf",POINT_X,POINT_Y,r);
//    
//    for (int i = 0 ; i < 6 ; i++) {
//        NSLog(@"X_:%lf        Y_:%lf",[[self.num objectAtIndex:i*2] floatValue],[[self.num objectAtIndex:i*2+1] floatValue]);
//    }

}

-(void)createView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"VC_backimage.png" ofType:nil];
    imageView.image = [UIImage imageWithContentsOfFile:path];
    
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createButtons];
    [self createMenuButton];
    //  [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VC_fusheng.png"]];
    image.frame = CGRectMake(0, 20, ScreenWidth, 64);
    self.navigationItem.titleView = image;
    //添加手势
    [self addTapGesture:self.view];
}
//创建菜单按钮
-(void)createMenuButton{
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width/4.0, [UIScreen mainScreen].bounds.size.width/4.0);
    [self.button addTarget:self action:@selector(menuButtonDidChicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button setBackgroundColor:RGBA(127, 252, 80, 0.3)];
    self.button.center = CGPointMake(Left,ScreenHeight - Bottom);
    NSString * path = [[NSBundle mainBundle]pathForResource:@"VC_caidan.png" ofType:UIControlStateNormal];
    [self.button setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    self.button.layer.cornerRadius = [UIScreen mainScreen].bounds.size.width*0.125;
    self.button.layer.masksToBounds = YES;
    self.button.tag = 99;
    [self.view addSubview:self.button];
}

-(void)menuButtonDidChicked{
    [self changeCoordinate:1];
}

//创建按钮
-(void)createButtons{
    self.titleArr = @[@"",@"",@"",@"",@"",@""];
    NSArray * arr = @[@"VC_zhuanpu.png",@"VC_chakan.png",@"VC_luyin.png",@"VC_sousou.png",@"VC_helper.png",@"VC_guanyu.png"];
    for (int i = 0; i < 6; i++) {
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:[self.titleArr objectAtIndex:i] forState:UIControlStateNormal];
        but.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.125, [UIScreen mainScreen].bounds.size.width*0.125);
        [but addTarget:self action:@selector(buttonDidChicked:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSString * path = [[NSBundle mainBundle]pathForResource:arr[i] ofType:nil];
        [but setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        but.center = CGPointMake(Left,ScreenHeight - Bottom);
        but.tag = 100 + i;
        but.layer.cornerRadius = [UIScreen mainScreen].bounds.size.width*0.0625;
        but.layer.masksToBounds = YES;
        [self.view addSubview:but];
    }
    
}

-(void)buttonDidChicked:(UIButton *)button{
    switch (button.tag) {
        case 100:
            //转调界面
            [self createWQSChagePitchStringViewController];
            break;
        case 101:
            //查看界面
            [self createMusicStringViewController];
            break;
        case 102:
            //录音界面
            [self createEnjoyShowViewController];
            break;
        case 103:
            //搜索网络资源文件
            [self createSearcghViewController];
            break;
        case 104:
            //帮助界面
            [self createStudentViewController];
            break;
        default:
            //产品介绍界面
            [self createAboutViewController];
            break;
    }
}

//转调界面*************************************************************
-(void)createWQSChagePitchStringViewController{
    
    CATransition * transition = [[CATransition alloc]init];
    transition.duration = 1.0f;
    transition.type = @"oglFilp";
    [self.view.layer addAnimation:transition forKey:nil];

    WQSChagePitchStringViewController  * changeStringView = [[WQSChagePitchStringViewController alloc] init];
    [self.navigationController pushViewController:changeStringView animated:YES];
}


//产品介绍界面*********************************************************
- (void)createAboutViewController {
//    AboutViewController *about = [[AboutViewController alloc] init];
//    [self.navigationController pushViewController:about animated:YES];
}
//搜索网络资源文件
-(void)createSearcghViewController{
//    SearcghViewController *sear = [[SearcghViewController alloc] init];
//    sear.title = @"搜索网络资源";
//    [self.navigationController pushViewController:sear animated:YES];
}
//录音界面
-(void)createEnjoyShowViewController{
//    EnjoyMusicViewController* evc = [[EnjoyMusicViewController alloc] init];
//    evc.title = @"欣赏网友作品";
//    [self.navigationController pushViewController:evc animated:YES];
}


-(void)createMusicStringViewController{
//    //    MusicStringViewController * mvc = [[MusicStringViewController alloc]init];
//    _mvc.title = @"本地曲谱";
//    [self.navigationController pushViewController:_mvc animated:YES];
}
-(void)createStudentViewController{
//    StudyMusicViewController * svc = [[StudyMusicViewController alloc]init];
//    svc.title = @"网络教程";
//    [self.navigationController pushViewController:svc animated:YES];
}


#pragma mark - 轻拍手势
//轻拍手势
- (void)addTapGesture:(UIView *)view {
    //实例化轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    [view addGestureRecognizer:tap];
    
}

//轻点屏幕，将按钮收起
-(void)tapGestureAction{
    [self changeCoordinate:0];
}

//根据传递的参数不同，改变按钮的坐标
-(void)changeCoordinate:(int)num{
    for(int i = 0;i < 6 ; i++)
    {
        UIButton *but = (UIButton *)[self.view viewWithTag:100+i];
        
        [UIView transitionWithView:but duration:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            if(num == 1){
                [UIView animateWithDuration:2.0 delay:i*0.05f usingSpringWithDamping:0.4
                      initialSpringVelocity:2.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    but.center = CGPointMake([[self.num objectAtIndex:i*2] floatValue],[[self.num objectAtIndex:i*2+1] floatValue]);
                          but.transform = CGAffineTransformMakeRotation(M_PI * 10);
                } completion:^(BOOL finished) {
                    
                }];

            }else{
                
                but.center = CGPointMake(Left,ScreenHeight - Bottom);
                
            }
         
        } completion:nil];
    }
}




#pragma mark - 内存泄露管理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
