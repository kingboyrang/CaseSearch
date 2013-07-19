//
//  CircularHR.h
//  CaseSearch
//
//  Created by rang on 13-4-16.
//  Copyright (c) 2013年 rang. All rights reserved.
//
/// <summary>
/// 戶政預約
/// </summary>
#import <Foundation/Foundation.h>

@interface CircularHR : NSObject

@property(nonatomic,copy) NSString * ID;
@property(nonatomic,copy) NSString * GUID;
//姓名
@property(nonatomic,copy) NSString * Name;
//暱稱
@property(nonatomic,copy) NSString * Nick;
//手機
@property(nonatomic,copy) NSString * Mobile;
//市內電話
@property(nonatomic,copy) NSString * Phone;
//申請人地址
@property(nonatomic,copy) NSString * Address;
// 電子郵件
@property(nonatomic,copy) NSString * Email; //Name,Nick,Mobile,Email --Address,Phone
//密碼
@property(nonatomic,copy) NSString * PWD;
// 通報日期
@property(nonatomic,copy) NSString * Created;
// 到期日期
@property(nonatomic,copy) NSString * ExecDate;
// 审核时间
@property(nonatomic,copy) NSString * ApprovalDate;
// 审核说明
@property(nonatomic,copy) NSString * ApprovalMemo;
// 审核状态
@property(nonatomic,copy) NSString * ApprovalStatus;
// 处理人变更次数
@property(nonatomic,copy) NSString * AccountChangeNum;
// 处理人
@property(nonatomic,copy) NSString * Account;
// 簡訊發送1是2否
@property(nonatomic,copy) NSString * IsMessagge;
// 标志
@property(nonatomic,copy) NSString * Flag;
//申請項目 1:出生登記2:結婚登記3:死亡登記
@property(nonatomic,copy) NSString * Category;
// 縣市
@property(nonatomic,copy) NSString * Ctiy;
// 申請人與新生兒之關系
@property(nonatomic,copy) NSString * ChildRelation;
// 男方姓名
@property(nonatomic,copy) NSString * ManName;
// 女方姓名
@property(nonatomic,copy) NSString * WomanName;
// 男方地址
@property(nonatomic,copy) NSString * ManAddress;
// 女方地址
@property(nonatomic,copy) NSString * WomanAddress;
// 申請人與往生者之關係
@property(nonatomic,copy) NSString * DeathRelation;
// 往生者姓名
@property(nonatomic,copy) NSString *DeathName;
// 往生者戶籍地址
@property(nonatomic,copy) NSString *DeathAddress;
// 描述
@property(nonatomic,copy) NSString * Memo;
// 编号
@property(nonatomic,copy) NSString * Number;
@property(nonatomic,readonly) NSString *ApprovalStatusText;
@property(nonatomic,readonly) NSString *CategoryText;
-(NSString*)BulletinDate;
/****将对象转化成字符串***/
-(NSString*)ObjectSeriationToString;
-(NSString*)formatPropertyString:(NSString*)str;
@end
