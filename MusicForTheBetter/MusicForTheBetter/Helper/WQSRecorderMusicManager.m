//
//  WQSRecorderMusicManager.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/16.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "WQSRecorderMusicManager.h"

@class WQSRecorderMusicManager;

static WQSRecorderMusicManager * manager = nil;

@implementation WQSRecorderMusicManager

+(instancetype)shareRecorderMusicManager{
    @synchronized(self) {
        if(!manager){
            manager = [[self alloc]init];
        }
    }
    return manager;
}

-(instancetype)init{
    if(self = [super init]){
//初始化录音单例
        self.playDictionary = [[NSMutableDictionary alloc]init];
        self.playSession = [AVAudioSession sharedInstance];
//设置录音模式
        [self.playSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
//设置音乐格式
        [self.playDictionary setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
        [self.playDictionary setObject:@(44100) forKey:AVSampleRateKey];
        [self.playDictionary setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
        [self.playDictionary setObject:@(16) forKey:AVLinearPCMBitDepthKey];
        [self.playDictionary setObject:@(2) forKey:AVNumberOfChannelsKey];
    }
    return self;
}

//开始录音、并暂时保存录音
-(void)startRecorderWithSavePath:(NSString * ) path{
    if(self.playRecorder){
        [self.playRecorder stop];
        self.playRecorder = nil;
    }
    
    self.playRecorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:path] settings:self.playDictionary error:nil];
    
    if([self.playRecorder prepareToRecord]){
        [self.playRecorder record];
    }
    
}

//开始或暂停录音
-(void)pauseOrStartRecorder{
    if(self.playRecorder){
        if([self.playRecorder isRecording]){
            [self.playRecorder pause];
        }else{
            [self.playRecorder record];
        }
    }
}

//结束录音
-(void)stopRecorder{
    if(self.playRecorder){
        [self.playRecorder stop];
        self.playRecorder = nil;
    }
}


@end
