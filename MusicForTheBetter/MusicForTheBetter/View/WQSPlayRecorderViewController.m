//
//  WQSPlayRecorderViewController.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/25.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSPlayRecorderViewController.h"
#import "WQSRecorderMusicManager.h"
#import "AppDelegate.h"
#import "WQSDataBaseManager.h"

#define RECORDERFILES [NSString stringWithFormat:@"%@/Documents/RecorderList",NSHomeDirectory()]

@interface WQSPlayRecorderViewController ()

//歌曲名称
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//作者名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//指针
@property (weak, nonatomic) IBOutlet UIImageView *needleImageView;
//中央图片
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
//当前播放时间
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
//整个录音时间
@property (weak, nonatomic) IBOutlet UILabel *allTimeLabel;
//开始或暂停
@property (weak, nonatomic) IBOutlet UIButton *startOrPauseButton;
//上一曲
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
//下一曲
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
//收藏、标注
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
//循环模式
@property (weak, nonatomic) IBOutlet UIButton *schemaButton;

@property (nonatomic,strong) WQSPlayMusicManager * playManager;

@end



@implementation WQSPlayRecorderViewController

-(void)viewDidAppear:(BOOL)animated{
    [self initData];
    [self createView];
}

-(void)initData{
    self.recorderModel = [self.recorderList objectAtIndex:self.atListNumber];
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    self.schemaButton.selected = appDelegate.schema;
    if([self.recorderModel.heart intValue] == 0){
        self.heartButton.selected = NO;
    }else{
        self.heartButton.selected = YES;
    }
}

-(void)createView{
    
    self.titleLabel.text = self.recorderModel.title;
    self.nameLabel.text = [NSString stringWithFormat:@"——    %@    ——",self.recorderModel.username];
    
    CGRect centerFram = self.centerImageView.frame;
    self.centerImageView.layer.cornerRadius = centerFram.size.height/2.0;
    self.centerImageView.layer.masksToBounds = YES;
    self.centerImageView.layer.borderWidth = 3.0f;
    self.centerImageView.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] CGColor];

}


- (IBAction)lastRecorderClicked:(id)sender {
    if(self.schemaButton.selected){
        if(self.atListNumber > 0 ){
            self.atListNumber--;
            self.recorderModel = [self.recorderList objectAtIndex:self.atListNumber];
            NSString * recorderPath = [NSString stringWithFormat:@"%@/%@",RECORDERFILES,self.recorderModel.filespath];
            [self.playManager startPlayWithPath:recorderPath];
            self.currentLabel.text = @"00:00";
            self.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:self.playManager.player.duration];
        }else{
            self.atListNumber = self.recorderList.count - 1;
            self.recorderModel = [self.recorderList objectAtIndex:self.atListNumber];
            NSString * recorderPath = [NSString stringWithFormat:@"%@/%@",RECORDERFILES,self.recorderModel.filespath];
            [self.playManager startPlayWithPath:recorderPath];
            self.currentLabel.text = @"00:00";
            self.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:self.playManager.player.duration];
        }
    }else{
        self.atListNumber = arc4random()%self.recorderList.count;
        self.recorderModel = [self.recorderList objectAtIndex:self.atListNumber];
        NSString * recorderPath = [NSString stringWithFormat:@"%@/%@",RECORDERFILES,self.recorderModel.filespath];
        [self.playManager startPlayWithPath:recorderPath];
        self.currentLabel.text = @"00:00";
        self.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:self.playManager.player.duration];
    }
}

- (IBAction)nextRecorderClicked:(id)sender {
    if(self.schemaButton.selected){
        if(self.atListNumber < self.recorderList.count - 2 ){
            self.atListNumber++;
            self.recorderModel = [self.recorderList objectAtIndex:self.atListNumber];
            NSString * recorderPath = [NSString stringWithFormat:@"%@/%@",RECORDERFILES,self.recorderModel.filespath];
            [self.playManager startPlayWithPath:recorderPath];
            self.currentLabel.text = @"00:00";
            self.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:self.playManager.player.duration];
        }else{
            self.atListNumber = 0;
            self.recorderModel = [self.recorderList objectAtIndex:self.atListNumber];
            NSString * recorderPath = [NSString stringWithFormat:@"%@/%@",RECORDERFILES,self.recorderModel.filespath];
            [self.playManager startPlayWithPath:recorderPath];
            self.currentLabel.text = @"00:00";
            self.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:self.playManager.player.duration];
        }
    }else{
        self.atListNumber = arc4random()%self.recorderList.count;
        self.recorderModel = [self.recorderList objectAtIndex:self.atListNumber];
        NSString * recorderPath = [NSString stringWithFormat:@"%@/%@",RECORDERFILES,self.recorderModel.filespath];
        [self.playManager startPlayWithPath:recorderPath];
        self.currentLabel.text = @"00:00";
        self.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:self.playManager.player.duration];
    }
}


- (IBAction)startOrPauseClicked:(id)sender {
    
    
    
}

- (IBAction)heartClicked:(id)sender {
    self.heartButton.selected = !self.heartButton.selected;
    WQSDataBaseManager * dataBaseManager = [WQSDataBaseManager shareDataBaseManager];
    if([self.recorderModel.heart isEqualToString:@"0"]){
        self.recorderModel.heart = @"1";
        [dataBaseManager changeRecorderMessageToDataBase:self.recorderModel];
    }else{
        self.recorderModel.heart = @"0";
        [dataBaseManager changeRecorderMessageToDataBase:self.recorderModel];
    }
}

- (IBAction)schemaClicked:(id)sender {
    self.schemaButton.selected = !self.schemaButton.selected;
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.schema = self.schemaButton.selected;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    NSString * recorderPath = [NSString stringWithFormat:@"%@/%@",RECORDERFILES,self.recorderModel.filespath];
    self.startOrPauseButton.selected = YES;

    __weak typeof(self) weakSelf = self;
    self.playManager = [WQSPlayMusicManager sharePlayMusicPlayManagerWithBlock:^(AVAudioPlayer *player) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.currentLabel.text = [WQSPlayMusicManager getFormateTime:player.currentTime];
            weakSelf.progressView.progress = player.currentTime*1.0 / player.duration*1.0 ;
            weakSelf.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:player.duration];
        });
    }];
    self.playManager.block =^(AVAudioPlayer *player) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.currentLabel.text = [WQSPlayMusicManager getFormateTime:player.currentTime];
            weakSelf.progressView.progress = player.currentTime*1.0 / player.duration*1.0 ;
            weakSelf.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:player.duration];
        });
    };
    [self.playManager startPlayWithPath:recorderPath];
    self.currentLabel.text = @"00:00";
    self.allTimeLabel.text = [WQSPlayMusicManager getFormateTime:self.playManager.player.duration];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
