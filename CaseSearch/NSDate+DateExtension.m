//
//  NSDate+DateExtension.m
//  CaseSearch
/***
3、iOS-NSDateFormatter 格式说明：

G: 公元时代，例如AD公元
yy: 年的后2位
yyyy: 完整年
MM: 月，显示为1-12
MMM: 月，显示为英文月份简写,如 Jan
MMMM: 月，显示为英文月份全称，如 Janualy
dd: 日，2位数表示，如02
d: 日，1-2位显示，如 2
EEE: 简写星期几，如Sun
EEEE: 全写星期几，如Sunday
aa: 上下午，AM/PM
H: 时，24小时制，0-23
K：时，12小时制，0-11
m: 分，1-2位
mm: 分，2位
s: 秒，1-2位
ss: 秒，2位
S: 毫秒

常用日期结构：
yyyy-MM-dd HH:mm:ss.SSS
yyyy-MM-dd HH:mm:ss
yyyy-MM-dd
MM dd yyyy
 ***/
//  Created by aJia on 12/11/14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "NSDate+DateExtension.h"

@implementation NSDate (DateExtension)

//时间转换成字符串
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:string];
	NSString *timestamp_str = [outputFormatter stringFromDate:date];
	[outputFormatter release];
	return timestamp_str;
}

+(NSDate*)StringToDate:(NSString*)date dateFormatString:(NSString*)formatString{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
	[df setDateFormat:formatString];//[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *newDate=[df dateFromString:date];
	[df release];
	return newDate;
}
+(NSDate*)StringFormatToDate:(NSString*)date orginFormatString:(NSString*)oldStr newFormatString:(NSString*)newStr{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
	[df setDateFormat:oldStr];//[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *oldDate=[df dateFromString:date];
    [df setDateFormat:newStr];
    NSString *strDate=[df stringFromDate:oldDate];
    NSDate *newDate=[df dateFromString:strDate];
    [df release];
    return newDate;
}
+(BOOL)CompareToDate:(NSDate*)date1 compareDate:(NSDate*)date2{
    if ([date1 compare:date2]== NSOrderedDescending) {
		return YES;
	}
	return NO;
}
+(BOOL)CompareToDateString:(NSString *)time1 compareDate:(NSString *)time2{
    NSDate *date1=[self StringToDate:time1 dateFormatString:@"yyyy-MM-dd"];
    NSDate *date2=[self StringToDate:time2 dateFormatString:@"yyyy-MM-dd"];
    return [self CompareToDate:date1 compareDate:date2];
}
@end
