//
//  WQSPlayMusicManager.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/16.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^playerBlock)(AVAudioPlayer * player);

//用于播放录音，并刷新播放页面进度条

@interface WQSPlayMusicManager : NSObject

//播放器，用于播放录音
@property (nonatomic,strong) AVAudioPlayer * player;

//定时器，用于定时刷新播放页面
@property (nonatomic,strong) NSTimer * timer;

//刷新播放页面进度条的block语句块
@property (nonatomic,copy) playerBlock block;



//获取播放器单例，单例能有效防止混音的发生
+(instancetype)sharePlayMusicPlayManagerWithBlock:(playerBlock) block;

//开始播放任务
-(void)startPlayWithPath:(NSString *) path;

//暂停或者继续播放
-(void)pauseOrStartPlay;

//结束播放
-(void)stopPlay;




@end
