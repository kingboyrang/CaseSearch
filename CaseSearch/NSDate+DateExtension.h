//
//  NSDate+DateExtension.h
//  CaseSearch
//
//  Created by aJia on 12/11/14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateExtension)
//時間字串轉換為日期
+(NSDate*)StringToDate:(NSString*)date dateFormatString:(NSString*)formatString;
+(NSDate*)StringFormatToDate:(NSString*)date orginFormatString:(NSString*)oldStr newFormatString:(NSString*)newStr;

//时间转换成字符串
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;

//時間大小比較
+(BOOL)CompareToDate:(NSDate*)date1 compareDate:(NSDate*)date2;
+(BOOL)CompareToDateString:(NSString *)time1 compareDate:(NSString *)time2;
@end
