//
//  CircularTax.h
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircularTax : NSObject
// ID
@property(nonatomic,retain) NSString *ID;
// GUID
@property(nonatomic,retain) NSString *GUID;
// 姓名
@property(nonatomic,retain) NSString *Name;
// 昵稱
@property(nonatomic,retain) NSString *Nick;
// 手機
@property(nonatomic,retain) NSString *Mobile;
// 電子郵件
@property(nonatomic,retain) NSString *Email;
// 密碼
@property(nonatomic,retain) NSString *PWD;
// 类别
@property(nonatomic,retain) NSString *TypeGuid;
// 通报日期
@property(nonatomic,retain) NSString *Created;
// 到期日期
@property(nonatomic,retain) NSString *ExecDate;
// 审核时间
@property(nonatomic,retain) NSString *ApprovalDate;
// 审核说明
@property(nonatomic,retain) NSString *ApprovalMemo;
// 审核状态(1處理中;2已處理)
@property(nonatomic,retain) NSString *ApprovalStatus;
// 处理人变更次数
@property(nonatomic,retain) NSString *AccountChangeNum;
// 处理人
@property(nonatomic,retain) NSString *Account;
// 标志（存放手機APP的唯一編號）
@property(nonatomic,retain) NSString *Flag;
// 地點
@property(nonatomic,retain) NSString *Location;
// 縣市
@property(nonatomic,retain) NSString *Ctiy;
// 描述
@property(nonatomic,retain) NSString *Memo;
// 编号
@property(nonatomic,retain) NSString *Number;
//通报时间
-(NSString*)BulletinDate;
//获取案件分类名称
-(NSString*)TypeGuidName;
//获取类别Soap
-(NSString*)CircularTaxTypeSoap;
//获取类别
-(NSMutableArray*)XmlToCircularTaxType:(NSString*)xml;
//获取案件状态
-(NSString*)ApprovalStatusText;
/****将对象转化成字符串***/
-(NSString*)ObjectSeriationToString;
-(NSString*)formatPropertyString:(NSString*)str;
@end
