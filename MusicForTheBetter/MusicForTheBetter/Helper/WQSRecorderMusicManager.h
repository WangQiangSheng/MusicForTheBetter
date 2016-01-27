//
//  WQSRecorderMusicManager.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/16.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

//负责录音

@interface WQSRecorderMusicManager : NSObject

//创建录音会话
@property (nonatomic,strong) AVAudioSession * playSession;

//操作录音
@property (nonatomic,strong) AVAudioRecorder * playRecorder;

//存贮录音音频的相关设置

@property (nonatomic,strong) NSMutableDictionary * playDictionary;

//获取录音相关单例
+(instancetype)shareRecorderMusicManager;

//开始录音、并暂时保存录音
-(void)startRecorderWithSavePath:(NSString * ) path;

//开始或暂停录音
-(void)pauseOrStartRecorder;

//结束录音
-(void)stopRecorder;

@end
