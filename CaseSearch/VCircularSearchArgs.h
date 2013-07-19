//
//  VCircularSearchArgs.h
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//
/// <summary>
/// 所有通報資料的視圖的查詢參數
/// </summary>
#import <Foundation/Foundation.h>

@interface VCircularSearchArgs : NSObject

@property(nonatomic,assign) int CurPage;
@property(nonatomic,assign) int CurSize;
// 種類
@property(nonatomic,retain) NSString *Category;
// 所属类别
@property(nonatomic,retain) NSString *TypeGuid;
// 申报人姓名
@property(nonatomic,retain) NSString *Name;
// 申报人暱稱
@property(nonatomic,retain) NSString *Nick;
// 鄉鎮市
@property(nonatomic,retain) NSString *Ctiy;
// 审核状态
@property(nonatomic,retain) NSString *ApprovalStatus;
// 申請開始日期
@property(nonatomic,retain) NSString *SDate;
// 申請結束日期
@property(nonatomic,retain) NSString *EDate;
// 處理人
@property(nonatomic,retain) NSString *Account;
// 處理人名稱
@property(nonatomic,retain) NSString *AccountName;
// 是否變更處理人(1是;2否)
@property(nonatomic,retain) NSString *ChangeAccount;
// 案件是否逾期(1是;2否)
@property(nonatomic,retain) NSString *OverdueExecDate;
// 标志（存放手機APP的唯一編號）
@property(nonatomic,retain) NSString *Flag;
//編號
@property(nonatomic,retain) NSString *Number;
/****将对象转化成字符串***/
-(NSString*)ObjectSeriationToString;
-(NSString*)formatPropertyString:(NSString*)str;
@end
