//
//  ChangeMusicString.m
//  MyProgectChange
//
//  Created by qianfeng007 on 15/9/29.
//  Copyright (c) 2015年 浮生若梦亦如烟. All rights reserved.
//

#import "WQSChangeMusicString.h"

static NSArray * PITCH = nil;
static NSArray * NOTE = nil;

@interface WQSChangeMusicString (){

}

@end



@implementation WQSChangeMusicString


+(NSString *)changeFromPitch:(NSString *)oldPitch ToPitch:(NSString *)newPitch byTextString:(NSString *)text{
    
    //可供选择的原调性和目标调性
    PITCH = @[@"A",@"#A",@"B",@"C",@"#C",@"D",@"#D",@"E",@"F",@"#F",@"G",@"#G"];
    
    //总共49个可表示的音符，其中包括倍低音12个，低音12个，中音12个，高音13个，当超出此范围时，系统将提示超出可选音域
    NOTE  = @[@"{1}",@"{#1}",@"{2}",@"{#2}",@"{3}",@"{4}",@"{#4}",@"{5}",@"{#5}",@"{6}",@"{#6}",@"{7}",
              @"(1)",@"(#1)",@"(2)",@"(#2)",@"(3)",@"(4)",@"(#4)",@"(5)",@"(#5)",@"(6)",@"(#6)",@"(7)",
              @"1",  @"#1",  @"2",  @"#2",  @"3",  @"4",  @"#4",  @"5",  @"#5",  @"6",  @"#6",  @"7",
              @"[1]",@"[#1]",@"[2]",@"[#2]",@"[3]",@"[4]",@"[#4]",@"[5]",@"[#5]",@"[6]",@"[#6]",@"[7]",@"[#7]"];
    
 //   NSArray * NOTE2 = @[@" ",@"-",@"0",@"|",@"\n"];

    //用于记录原调性和目标调性之间的音程差
    NSInteger distance = 0;
    //用于存原来调性下标
    NSInteger oldNumber = 0;
    //用于存目标调性下标
    NSInteger newNumber = 0;
    
    //用于存放转调之后的字符串
//    NSMutableString * NEEDSTRING = [[NSMutableString alloc]init];
    
    
    for(NSInteger i = 0 ; i < 12 ; i++ ){
        if([oldPitch isEqualToString:[PITCH objectAtIndex:i]]){
            oldNumber = i;
        }
        if([newPitch isEqualToString:[PITCH objectAtIndex:i]]){
            newNumber = i;
        }
    }
    
    //此处是保证原调性和目标调性差距不会太大，比如中音C调转换为B调时，不会转换成高音的B调
    distance = oldNumber- newNumber ;
    
    NSString * myTempString = text;
    int flag = 1;
    
    NSString * needString = [self getNewTextByOldText:myTempString andDistance:distance];
    
    while (flag) {
        
        if([@"-1" isEqualToString:needString]){
            distance = distance - 12;
            
            return [self getNewTextByOldText:myTempString andDistance:distance];
        }else if ([@"-2" isEqualToString:needString]){
            distance = distance + 12;

            return [self getNewTextByOldText:myTempString andDistance:distance];
        }
        
        flag = 0;
        
    }

    return needString;
}

+(NSString *)getNewTextByOldText:(NSString *)myTempString andDistance:(NSInteger) distance{
    NSString * getItem = nil;
    NSMutableString * NEEDSTRING = [[NSMutableString alloc]init];
    
    for(NSInteger i = 0 ; i < myTempString.length ;){
        
        //处理倍低音情况的转调
        if('{' == [myTempString characterAtIndex:i]){
            
            //获取接下来第一个”}“出现的位置，因为{}成对出现，所以有{，接下来肯定会有}
            NSRange range = [myTempString rangeOfString:@"}"];
            
            //获得{}中的数据
            getItem = [myTempString substringWithRange:NSMakeRange(i+1,range.location-1)];
            
            //获取除去当前调之后的新的字符串，便于下次转调
            myTempString = [myTempString substringFromIndex:range.location+1];
            
            //在NOTO数组中比对当前调，并加上其偏移，即得到目标调的字符串
            for(NSInteger j = 0 ; j < NOTE.count ; j++){
                if([[NSString stringWithFormat:@"{%@}",getItem] isEqualToString:[NOTE objectAtIndex:j]]){
                    NSInteger target = j + distance;
                    
                    //合法性判断，如果髠调性超出可转范围则返回一个“ERROR”字符
                    if(target > 48 ){
                        return @"-1";
                    }else if (target < 0){
                        return @"-2";
                    }
                    else{
                        [NEEDSTRING appendString:[NOTE objectAtIndex:target]];
                        break;
                    }
                    
                }
            }
        }
        
        else if('(' == [myTempString characterAtIndex:i]){
            
            //获取接下来第一个”)“出现的位置，因为()成对出现，所以有(，接下来肯定会有)
            NSRange range = [myTempString rangeOfString:@")"];
            
            //获得()中的数据
            getItem = [myTempString substringWithRange:NSMakeRange(i+1,range.location-1)];
            
            //获取除去当前调之后的新的字符串，便于下次转调
            myTempString = [myTempString substringFromIndex:range.location+1];
            
            //在NOTO数组中比对当前调，并加上其偏移，即得到目标调的字符串
            for(NSInteger j = 0 ; j < NOTE.count ; j++){
                if([[NSString stringWithFormat:@"(%@)",getItem] isEqualToString:[NOTE objectAtIndex:j]]){
                    NSInteger target = j + distance;
                    
                    //合法性判断，如果髠调性超出可转范围则返回一个“ERROR”字符
                    if(target > 48 ){
                        return @"-1";
                    }else if (target < 0){
                        return @"-2";
                    }else{
                        [NEEDSTRING appendString:[NOTE objectAtIndex:target]];
                        break;
                    }
                    
                }
            }
        }
        
        
        else if('[' == [myTempString characterAtIndex:i]){

            //获取接下来第一个”]“出现的位置，因为[]成对出现，所以有[，接下来肯定会有]
            NSRange range = [myTempString rangeOfString:@"]"];
            
            //获得[]中的数据
            getItem = [myTempString substringWithRange:NSMakeRange(i+1,range.location-1)];
            
            //获取除去当前调之后的新的字符串，便于下次转调
            myTempString = [myTempString substringFromIndex:range.location+1];
            
            //在NOTO数组中比对当前调，并加上其偏移，即得到目标调的字符串
            for(NSInteger j = 0 ; j < NOTE.count ; j++){
                if([[NSString stringWithFormat:@"[%@]",getItem] isEqualToString:[NOTE objectAtIndex:j]]){
                    NSInteger target = j + distance;
                    
                    //合法性判断，如果髠调性超出可转范围则返回一个“ERROR”字符
                    if(target > 48 ){
                        return @"-1";
                    }else if (target < 0){
                        return @"-2";
                    }else{
                        [NEEDSTRING appendString:[NOTE objectAtIndex:target]];
                        break;
                    }
                    
                }
            }
        }
        
        else{
            if('#' == [myTempString characterAtIndex:i] ){
                
                getItem = [NSString stringWithFormat:@"%c%c",[myTempString characterAtIndex:i],[myTempString characterAtIndex:i+1]];
                
                myTempString = [myTempString substringFromIndex:i+1];
                
                //在NOTO数组中比对当前调，并加上其偏移，即得到目标调的字符串
                for(NSInteger j = 0 ; j < NOTE.count ; j++){
                    if([[NSString stringWithFormat:@"%@",getItem] isEqualToString:[NOTE objectAtIndex:j]]){
                        NSInteger target = j + distance;
                        
                        //合法性判断，如果髠调性超出可转范围则返回一个“ERROR”字符
                        if(target > 48 ){
                            return @"-1";
                        }else if (target < 0){
                            return @"-2";
                        }else{
                            [NEEDSTRING appendString:[NOTE objectAtIndex:target]];
                            break;
                        }
                        
                    }
                }
            }else{
                
                getItem = [myTempString substringWithRange:NSMakeRange(i, 1)];
                
                myTempString = [myTempString substringFromIndex:i+1];
                
                //此处为一个标记，如果结束for循环后flag = 0，则证明用户输入的是非法字符，在此将不作处理
                int flag = 0 ;
                
                //在NOTO数组中比对当前调，并加上其偏移，即得到目标调的字符串
                for(NSInteger j = 0 ; j < NOTE.count ; j++){
                    if([[NSString stringWithFormat:@"%@",getItem] isEqualToString:[NOTE objectAtIndex:j]]){

                        NSInteger target = j + distance;
                        flag = 1;

                        //合法性判断，如果髠调性超出可转范围则返回一个“ERROR”字符
                        if(target > 48 ){
                            return @"-1";
                        }else if (target < 0){
                            return @"-2";
                        }else{
                            [NEEDSTRING appendString:[NOTE objectAtIndex:target]];
                            break;
                        }
                        
                    }
                }
                
                //如果没有找到对应音符，标示用户非法输入，再次将不做处理原样输出
                if(flag == 0){
                    [NEEDSTRING appendString:getItem];
                }

            }
            
        }

    }

    return NEEDSTRING;
}


@end
