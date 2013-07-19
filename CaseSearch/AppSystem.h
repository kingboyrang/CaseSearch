//
//  AppSystem.h
//  CaseSearch
//
//  Created by rang on 13-5-6.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AppSystem : NSObject



//获取案件分类资料
+(NSMutableDictionary*)fileNameToCircularType;
//获取推播列表
+(NSMutableArray*)fileNameToPush;



+(NSString*)infoMessageMemo;
//显示一个提示信息
+(void)showAlterTip;
//判断是否为ipad
+(BOOL)isIPad;

@end
