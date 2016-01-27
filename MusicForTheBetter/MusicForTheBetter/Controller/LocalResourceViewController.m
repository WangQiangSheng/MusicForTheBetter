//
//  LocalResourceViewController.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/22.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "LocalResourceViewController.h"
#import "WQSConstant.h"
#import "UMSocial.h"
#import "WQSDataBaseManager.h"
#import "WQSMusicStringModel.h"
#import "WQSRecorderMessagesModel.h"
#import "MusicStringTableViewCell.h"
#import "WQSRocorderTableViewCell.h"
#import "WQSPlayMusicManager.h"
#import "WQSPlayRecorderViewController.h"
#import "JHRefresh.h"

#define RECORDERFILES [NSString stringWithFormat:@"%@/Documents/RecorderList",NSHomeDirectory()]

@interface LocalResourceViewController () <UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate,UIScrollViewDelegate>

//存放转谱列表的TableView
@property (nonatomic,strong) UITableView * musicStringTableView ;
@property (nonatomic,strong) NSMutableArray * musicDataSource;
//存放录音列表的TableView
@property (nonatomic,strong) UITableView * recorderTableView ;
@property (nonatomic,strong) NSMutableArray * recorderDataSource;

//承接两个Tableview
@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) UISegmentedControl * segmentedControl;

@property (nonatomic,strong) UINib * musicNib;
@property (nonatomic,strong) UINib * recorderNib;

//确定是哪个Cell被点击
@property (nonatomic,assign) NSInteger musicNumber;
@property (nonatomic,assign) NSInteger recorderNumber;


@end

@implementation LocalResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    [self createView];

}

-(void)initData{
    self.musicNumber = NSIntegerMax;
    self.recorderNumber = NSIntegerMax;
    
    WQSDataBaseManager * dataManager = [WQSDataBaseManager shareDataBaseManager];
    self.musicDataSource = [NSMutableArray arrayWithArray:[dataManager selectMusicStringByDataBaseFrom:@"MusicString"]];
    self.recorderDataSource = [NSMutableArray arrayWithArray:[dataManager selectMusicStringByDataBaseFrom:@"RecorderMessages"]];
    NSMutableArray * itemMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0 ; i < self.recorderDataSource.count ; i++ ) {
        WQSRecorderMessagesModel * model = [self.recorderDataSource objectAtIndex:i];
        model.leftTopImage = [UIImage imageNamed:[NSString stringWithFormat:@"music_%d.png",arc4random()%5+1]];
        [itemMutableArray addObject:model];
    }
    self.recorderDataSource = itemMutableArray;
}


-(void)createView{
    NSArray * array = @[@"本地曲谱",@"本地录音"];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:array];
    self.segmentedControl.frame = CGRectMake(10, 64, ScreenWidth-20, 30);
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self.segmentedControl addTarget:self action:@selector(changeTableView) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, ScreenWidth, ScreenHeight-94)];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.musicStringTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-94) style:UITableViewStylePlain];
    self.recorderTableView = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-94) style:UITableViewStylePlain];
//    self.musicStringTableView.backgroundColor = [UIColor purpleColor];
//    self.recorderTableView.backgroundColor = [UIColor greenColor];
    self.musicStringTableView.delegate = self;
    self.musicStringTableView.dataSource = self;
    self.recorderTableView.delegate = self;
    self.recorderTableView.dataSource = self;
    [self.scrollView addSubview:self.musicStringTableView];
    [self.scrollView addSubview:self.recorderTableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

//segmentedControl改变时调用
-(void)changeTableView{
    if(self.segmentedControl.selectedSegmentIndex == 0){
        [UIView animateWithDuration:0.50f animations:^{
            CGPoint point = self.scrollView.contentOffset;
            point.x = 0;
            self.scrollView.contentOffset = point;
        }];
    }else if (self.segmentedControl.selectedSegmentIndex == 1){
        [UIView animateWithDuration:0.50f animations:^{
            CGPoint point = self.scrollView.contentOffset;
            point.x = ScreenWidth;
            self.scrollView.contentOffset = point;
        }];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.musicStringTableView){
        return self.musicDataSource.count;
    }else if (tableView == self.recorderTableView){
        return self.recorderDataSource.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.musicStringTableView){
        MusicStringTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MUSIC"];
        
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MusicStringTableViewCell" owner:self options:nil] firstObject];
        }
        
        WQSMusicStringModel * model = [self.musicDataSource objectAtIndex:indexPath.row];
        cell.titleMusicString.text = model.title;
        cell.pitchLabel.text = model.pitchs;
        cell.nameLabel.text = model.username;
        cell.timeLabel.text = [[model.time componentsSeparatedByString:@" "]firstObject];
        cell.clipsToBounds = YES;
        cell.musicStringModel = model;
        cell.fatherVC = self;
        
        if(indexPath.row%2 == 0){
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            cell.backgroundColor = RGB(240, 240, 240);
        }
        
        return cell;
        
    }else if(tableView == self.recorderTableView){
        WQSRocorderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RECORDER"];
        
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WQSRocorderTableViewCell" owner:self options:nil] firstObject];
        }
        
        WQSRecorderMessagesModel * model = [self.recorderDataSource objectAtIndex:indexPath.row];
        cell.titleLabel.text = model.title;
        cell.recorderList = self.recorderDataSource;
        cell.timeLabel.text = [[model.time componentsSeparatedByString:@" "]firstObject];
        cell.atListNumber = indexPath.row;
        cell.userNameLabel.text = model.username;
        cell.leftImageView.image = model.leftTopImage;
        WQSPlayMusicManager * playManager = [WQSPlayMusicManager sharePlayMusicPlayManagerWithBlock:nil];
        cell.recorderTimeLabel.text = [NSString stringWithFormat:@"时长：%@",[playManager getDurationTimeWithPath:[NSString stringWithFormat:@"%@/%@",RECORDERFILES,model.filespath]]];
        NSLog(@"__func__%@",playManager);
        
        if([model.heart intValue] == 0){
            cell.heartImageView.image = [UIImage imageNamed:@"heart.png"];
        }else{
            cell.heartImageView.image = [UIImage imageNamed:@"redHeart.png"];
        }
        if(indexPath.row%2 == 0){
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            cell.backgroundColor = RGB(240, 240, 240);
        }
        return cell;
    }else{
        return [[UITableViewCell alloc]init];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.musicStringTableView){
        
        if(self.musicNumber == indexPath.row ){
            return 100;
        }else{
            return 70;
        }
        
    }else if (tableView == self.recorderTableView){
        
        return 70.0f;
        
    }else{
        return 100;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView == self.musicStringTableView){
        self.musicNumber = indexPath.row;
        [tableView reloadData];
    }else if (tableView == self.recorderTableView){
        WQSPlayRecorderViewController * playVC = [[WQSPlayRecorderViewController alloc]init];
        playVC.recorderList = self.recorderDataSource;
        playVC.atListNumber = indexPath.row;
        [self.navigationController pushViewController:playVC animated:YES];
    }else{
        
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row%2 == 0){
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = RGB(240, 240, 240);
    }
}

//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == self.musicStringTableView) {
//        return NO;
//    }else if (tableView == self.recorderTableView){
//        return YES;
//    }else{
//        return NO;
//    }
//}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == self.musicStringTableView) {
//        return UITableViewCellEditingStyleNone;
//    }else if (tableView == self.recorderTableView){
//        return UITableViewCellEditingStyleDelete;
//    }else{
//        return UITableViewCellEditingStyleNone;
//    }
//}

//-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == self.musicStringTableView) {
//        
//    }else if (tableView == self.recorderTableView){
//        WQSDataBaseManager * dataBaseManager = [WQSDataBaseManager shareDataBaseManager];
//        WQSRecorderMessagesModel * recorderModel = [self.recorderDataSource objectAtIndex:indexPath.row];
//        [dataBaseManager deleteAmessageToDataBase:@"RecorderMessages" AndFrom:recorderModel.id];
//        [self.recorderTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
//        [self.recorderDataSource removeObjectAtIndex:indexPath.row];
//    }else{
//        
//    }
//    
//}






#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.x <= 0) {
        [self.segmentedControl setSelectedSegmentIndex:0];
    }else if (self.scrollView.contentOffset.x >= ScreenWidth){
        [self.segmentedControl setSelectedSegmentIndex:1];
    }else{
        [self.segmentedControl setSelectedSegmentIndex:0];
    }
}


#pragma mark - UM回调协议方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        //得到分享到的微博平台名
        //        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"分享失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
