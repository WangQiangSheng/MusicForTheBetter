//
//  MusicStringTableViewCell.m
//  MusicForTheBetter
//
//  Created by 美游001 on 16/1/22.
//  Copyright © 2016年 meiyou001. All rights reserved.
//

#import "MusicStringTableViewCell.h"
#import "WQSHelper.h"
#import "UMSocial.h"
#import "AppDelegate.h"
#import "WQSConstant.h"

@implementation MusicStringTableViewCell 

- (void)awakeFromNib {
    self.otherButton.layer.cornerRadius = 8.0f;
    self.otherButton.layer.masksToBounds = YES;
    self.shareButton.layer.cornerRadius = 8.0f;
    self.shareButton.layer.masksToBounds = YES;
    self.checkButton.layer.cornerRadius = 8.0f;
    self.checkButton.layer.masksToBounds = YES;
}

//其他按钮（暂时还没想到）
//IBOutlet UIButton *otherButton;
//查看按钮
//IBOutlet UIButton *checkButton;
//分享按钮
//IBOutlet UIButton *shareButton;


- (IBAction)otherButtonClicked:(id)sender {
//    self.musicBlock(11);
}

- (IBAction)checkButtonClicked:(id)sender {
//    self.musicBlock(12);
}

- (IBAction)shareButtonClicked:(id)sender {
//    self.musicBlock(13);
//    [self saveImageToPhotos:[self GetSaveImage]];

//    NSString * path = [[NSBundle mainBundle]pathForResource:@"icon.jpg" ofType:UIControlStateNormal];
    
    [UMSocialSnsService presentSnsIconSheetView:(LocalResourceViewController *)self.fatherVC
                                         appKey:@"56a3007067e58e5047000db0"//乐来越好，让生活充满音乐，让生活质量乐来越好……
                                      shareText:@"乐来越好，让生活充满音乐，让生活质量越来越好……"
                                     shareImage:[self GetSaveImage]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,nil]
                                       delegate:self.fatherVC];

    NSString * str = [NSString stringWithFormat:@"乐来越好 1.2"];
    //当分享类型为图文时，点击分享内容会跳转到预设的链接，设置方法如下
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://user.qzone.qq.com/970110855/profile/permit";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://user.qzone.qq.com/970110855/profile/permit";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    //设置微信好友的title方法为
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = str;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"乐来越好，让生活充满音乐，让生活质量越来越好……";
    //设置QQ点击分享内容跳转链接调用下面的方法
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://user.qzone.qq.com/970110855/profile/permit";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"http://user.qzone.qq.com/970110855/profile/permit";
//    [UMSocialData defaultData].extConfig.qqData.title = str;
    [UMSocialData defaultData].extConfig.qzoneData.title = str;
    
}

- (void)saveImageToPhotos:(UIImage*)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, nil, nil,nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片成功" message:@"您已将照片存储于图片库中，打开照片程序即可查看。"delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


-(UIImage *)GetSaveImage{
    
    UIImage * image = nil;
    CGFloat textHeight = [WQSHelper textHeightFromTextString:self.musicStringModel.numbersstring width:ScreenWidth-20 fontSize:15.0f];
    
    UIViewController * imageVC = [[UIViewController alloc]init];
    imageVC.view.frame = CGRectMake(0, 0, ScreenWidth, 75 + textHeight + 55) ;
    imageVC.view.backgroundColor = RGB(240, 240, 240);
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, ScreenWidth - 20, 30)];
    titleLabel.text = self.musicStringModel.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:25.0f];
    [imageVC.view addSubview:titleLabel];
    
    UILabel * pitchLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, ScreenWidth/2.0f - 10, 15)];
    pitchLabel.text = self.musicStringModel.pitchs;
    pitchLabel.textAlignment = NSTextAlignmentLeft;
    pitchLabel.font = [UIFont systemFontOfSize:12.0f];
    [imageVC.view addSubview:pitchLabel];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.0f, 55, ScreenWidth/2.0f - 10, 15)];
    nameLabel.text = self.musicStringModel.username;
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.font = [UIFont systemFontOfSize:12.0f];
    [imageVC.view addSubview:nameLabel];

    UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, ScreenWidth - 20, textHeight)];
    textLabel.text = self.musicStringModel.numbersstring;
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.font = [UIFont systemFontOfSize:15.0f];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [imageVC.view addSubview:textLabel];

    UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, textLabel.frame.size.height + textLabel.frame.origin.y + 20, ScreenWidth - 20, 15)];
    timeLabel.text = self.musicStringModel.time;
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:12.0f];
    [imageVC.view addSubview:timeLabel];
    
    image = [self imageFromView:imageVC.view];
    
    return image;
}

//获得屏幕图像
- (UIImage *)imageFromView: (UIView *) theView
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
