//
//  WQSKeyBoardViewController.h
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/11.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WQSChagePitchStringViewController.h"

typedef void(^KeyBlock)(NSInteger number);

@class WQSChagePitchStringViewController;


@interface WQSKeyBoardViewController : UIViewController

//原调性、目标调性
@property (nonatomic,strong) NSString * pitchOld;
@property (nonatomic,strong) NSString * pitchNew;

@property (nonatomic,copy) KeyBlock keyBoardBlock;

@property (weak, nonatomic) IBOutlet UIView *keyBoardCenterView;

@property (weak, nonatomic) IBOutlet UIView *key_1_1;
@property (weak, nonatomic) IBOutlet UIView *key_1_2;
@property (weak, nonatomic) IBOutlet UIView *key_1_3;
@property (weak, nonatomic) IBOutlet UIView *key_1_4;
@property (weak, nonatomic) IBOutlet UIView *key_1_5;
@property (weak, nonatomic) IBOutlet UIView *key_2_1;
@property (weak, nonatomic) IBOutlet UIView *key_2_2;
@property (weak, nonatomic) IBOutlet UIView *key_2_3;
@property (weak, nonatomic) IBOutlet UIView *key_2_4;
@property (weak, nonatomic) IBOutlet UIView *key_2_5;
@property (weak, nonatomic) IBOutlet UIView *key_3_1;
@property (weak, nonatomic) IBOutlet UIView *key_3_2;
@property (weak, nonatomic) IBOutlet UIView *key_3_3;
@property (weak, nonatomic) IBOutlet UIView *key_3_4;
@property (weak, nonatomic) IBOutlet UIView *key_3_5;
@property (weak, nonatomic) IBOutlet UIView *key_4_1;
@property (weak, nonatomic) IBOutlet UIView *key_4_2;
@property (weak, nonatomic) IBOutlet UIView *key_4_3;
@property (weak, nonatomic) IBOutlet UIView *key_4_4;
@property (weak, nonatomic) IBOutlet UIView *key_4_5;
@property (weak, nonatomic) IBOutlet UIButton *keyButton11;
@property (weak, nonatomic) IBOutlet UIButton *keyButton12;
@property (weak, nonatomic) IBOutlet UIButton *keyButton13;
@property (weak, nonatomic) IBOutlet UIButton *keyButton14;
@property (weak, nonatomic) IBOutlet UIButton *keyButton15;
@property (weak, nonatomic) IBOutlet UIButton *keyButton21;
@property (weak, nonatomic) IBOutlet UIButton *keyButton22;
@property (weak, nonatomic) IBOutlet UIButton *keyButton23;
@property (weak, nonatomic) IBOutlet UIButton *keyButton24;
@property (weak, nonatomic) IBOutlet UIButton *keyButton25;
@property (weak, nonatomic) IBOutlet UIButton *keyButton31;
@property (weak, nonatomic) IBOutlet UIButton *keyButton32;
@property (weak, nonatomic) IBOutlet UIButton *keyButton33;
@property (weak, nonatomic) IBOutlet UIButton *keyButton34;
@property (weak, nonatomic) IBOutlet UIButton *keyButton35;
@property (weak, nonatomic) IBOutlet UIButton *keyButton41;
@property (weak, nonatomic) IBOutlet UIButton *keyButton42;
@property (weak, nonatomic) IBOutlet UIButton *keyButton43;
@property (weak, nonatomic) IBOutlet UIButton *keyButton44;
@property (weak, nonatomic) IBOutlet UIButton *keyButton45;


- (IBAction)keyButton14Clicked:(id)sender ;

@end
