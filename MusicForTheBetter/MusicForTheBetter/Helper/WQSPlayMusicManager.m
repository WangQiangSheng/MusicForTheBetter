//
//  WQSPlayMusicManager.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/16.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSPlayMusicManager.h"


@class WQSPlayMusicManager;

static WQSPlayMusicManager * manager = nil;

@implementation WQSPlayMusicManager

//获取播放器单例，单例能有效防止混音的发生
+(instancetype)sharePlayMusicPlayManagerWithBlock:(playerBlock) block{
    @synchronized(self) {
        if(!manager){
            manager = [[self alloc]initWithBlock:block];
        }
    }
    
    return manager;
}

-(instancetype)initWithBlock:(playerBlock) block{
    if(self = [super init]){
        //***   这个地方必须用copy，否则有可能出现 block 为空，从而产生各种离奇的错误
        self.block = [block copy];
    }
    return self;
}

//返回当前音乐总时长
-(NSString *)getDurationTimeWithPath:(NSString *) recorderPath{
    //如果播放任务存在并且正在播放，则停掉当前任务，从新开启新任务
    if(self.player){
        self.player = nil;
    }
    //开启一个播放任务，并开始播放
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:recorderPath] error:nil];
    NSInteger recorderDuration = (CGFloat)self.player.duration/1;
    return [NSString stringWithFormat:@"%02ld:%02ld",recorderDuration/60,recorderDuration%60];
}

+(NSString *)getFormateTime:(NSTimeInterval) time{
    NSInteger currentDuration = (CGFloat)time/1;
    return [NSString stringWithFormat:@"%02ld:%02ld",currentDuration/60,currentDuration%60];
}

//开始播放任务
-(void)startPlayWithPath:(NSString *) path{
    //如果播放任务存在并且正在播放，则停掉当前任务，从新开启新任务
    if(self.player){
        if([self.player isPlaying]){
            [self.player stop];
            self.player = nil;
        }
    }
    
    //如果block存在且不为空，则证明是需要刷新UI的界面在调用
    if(self.block && self.block != nil){
        if(!self.timer){
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshPlayView:) userInfo:nil repeats:YES];
        }
    }
    
    //开启一个播放任务，并开始播放
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [self.player play];
    
}


//刷新UI界面
-(void)refreshPlayView:(NSTimer *) timer{
    self.block(self.player);
}


//暂停或者继续播放
-(void)pauseOrStartPlay{
    if(self.player){
        if([self.player isPlaying]){
            [self.player pause];
            //每次暂停或开始都重新创建或者销毁定时器，防止定时器效果叠加，导致大量占用CPU资源
            if(self.timer){
                [self.timer invalidate];
                self.timer = nil;
            }
        }else{
            [self.player play];
            if(!self.timer){
                self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshPlayView:) userInfo:nil repeats:YES];
            }
        }
    }
}


//结束播放
-(void)stopPlay{
    if(self.player){
        [self.player stop];
        self.player = nil;
        if(self.timer){
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}











@end
